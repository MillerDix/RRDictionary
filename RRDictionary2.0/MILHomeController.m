//
//  MILHomeController.m
//  RRDictionary2.0
//
//  Created by MillerD on 3/21/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILHomeController.h"
#import "MILToolView.h"
#import "MILWords.h"
#import <AFNetworking.h>
#import "PureLayout.h"
#import "MILWordsListController.h"
#import "MILWordDetailController.h"

//http://91dict.com/rr/index_word.php word_index

@interface MILHomeController ()<UISearchBarDelegate, NSXMLParserDelegate,UIScrollViewDelegate, UITableViewDelegate,UITableViewDataSource, MILToolViewDelegate, MILWordsListRefreshDelegate>

@property (nonatomic, assign) CGFloat lastOffset;

#pragma mark - 控件属性
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) MILToolView *toolView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *coverView;

// 刷新控件
@property (nonatomic, weak) UIRefreshControl *refreshControl;

#pragma mark - 模型属性
//存储当前节点的内容
@property (nonatomic, strong) NSMutableString *mString;
//存储word对象
@property (nonatomic, strong) MILWords *word;
//所有的word对象数组
@property (nonatomic, strong) NSMutableArray *words;
//搜索内容
@property (nonatomic, copy) NSString *searchText;

@end

@implementation MILHomeController

#pragma mark - 首页列表的下拉刷新代理
-(void)wordListPullToRefresh:(UIRefreshControl *)refreshControl
{
    // 清空当前模型
    self.refreshControl = refreshControl;
    [self.mString setString:@""];
    self.word = nil;
    [self.words removeAllObjects];
    
    // 发送请求
    [self sendNetworkRequest];
}

#pragma mark - 工具栏按钮的代理方法
-(void)pushToController:(UIViewController *)controller byButton:(UIButton *)button
{
    // 隐藏搜索栏
    self.searchBar.hidden = YES;
    
    // 执行跳转
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 属性懒加载

-(MILToolView *)toolView
{
    if (_toolView == nil) {
        _toolView = [[MILToolView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 100)];
        _toolView.backgroundColor = MILRandom;
        
        // 设置代理
        _toolView.delegate = self;
    }
    return _toolView;
}

// 搜索蒙版coverView
-(UITableView *)coverView
{
    if (_coverView == nil) {
   
        // 初始化搜索蒙版
        _coverView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNaviBar_maxY, kScreen_width, kScreen_height)];
        _coverView.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 设置coverView的代理和数据源
        _coverView.delegate = self;
        _coverView.dataSource = self;
        [self.view addSubview:_coverView];
        
    }
    return _coverView;
}

// 搜索条懒加载
-(UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        //取消导航栏标题
        self.navigationItem.title = nil;
        
        //创建搜索条并设置
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, 44)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.placeholder = @"请输入查询单词";
        _searchBar.delegate = self;
    }
    return _searchBar;
}


-(NSMutableString *)mString
{
    if (_mString == nil) {
        _mString = [[NSMutableString alloc] init];
    }
    return _mString;
}

-(NSMutableArray *)words
{
    if (_words == nil) {
        _words = [[NSMutableArray alloc] init];
    }
    return _words;
}

// 设置工具栏的偏移
-(void)setCollectionOffset:(CGFloat)collectionOffset{
    _collectionOffset = collectionOffset;
    
    if (self.collectionView.frame.size.height >= self.collectionView.contentSize.height) {
        return;
    }
    
    //moving up
    if (self.lastOffset < _collectionOffset && _collectionOffset >= (self.navigationController.navigationBar.frame.size.height + 20 - self.toolView.frame.size.height)) {
        if (self.toolView.frame.origin.y > (self.navigationController.navigationBar.frame.size.height + 20 - self.toolView.frame.size.height)) {//not yet hidden
            float newY = self.toolView.frame.origin.y - (_collectionOffset - self.lastOffset);
            if (newY < (self.navigationController.navigationBar.frame.size.height + 20 - self.toolView.frame.size.height)) {
                newY = self.navigationController.navigationBar.frame.size.height + 20 - self.toolView.frame.size.height;
                
            }
            CGRect frame = self.toolView.frame;
            frame.origin.y = newY;
            self.toolView.frame = frame;
        }
    }else
    {
        if (self.toolView.frame.origin.y < self.navigationController.navigationBar.frame.size.height + 20) {
            float newY = self.toolView.frame.origin.y + (self.lastOffset - _collectionOffset);
            if (newY > self.navigationController.navigationBar.frame.size.height + 20) {
                newY = self.navigationController.navigationBar.frame.size.height + 20;
            }
            CGRect frame = self.toolView.frame;
            frame.origin.y = newY;
            self.toolView.frame = frame;
        }
    }
    
    self.lastOffset = _collectionOffset;
}



#pragma mark - 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 设置显示searchBar(从单词详情返回时)
    self.searchBar.hidden = NO;
    
    // 显示tabbar
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MILRandom;
    [self.navigationItem hidesBackButton];
    
    //取消自动添加64 fuck you!
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加toolView
    [self setToolView];
    
    //添加一个collectionView
    [self setCollectionView];

    // 网络请求
    //[self sendNetworkRequest];

    //设置搜索条
    [self setSearchbar];
    
}

#pragma mark - 网络请求及解析

// 发送请求
-(void)sendNetworkRequest{
    //xml数据请求
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //设定返回类型为text/xml
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    //发送请求
    [manager GET:@"http://91dict.com/rr/index_word.php" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSXMLParser *responseObject) {
        
        responseObject.delegate = self;
        [responseObject parse];
        
        // UIRefreshControl对collection的contentInset会造成影响，在刷新后重新设定contentInset
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.refreshControl endRefreshing];
            self.collectionView.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + 120, 0, 50, 0);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//开始解析文件
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    //NSLog(@"did start document");
}

//开始解析标签
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if ([elementName isEqualToString:@"yourword"]) {
        self.word = [[MILWords alloc] init];
        [self.words addObject:self.word];
    }
}

//找到字符串内容
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //NSLog(@"found characters:%@",string);
    [self.mString appendString:string];
}

//本标签解析完毕
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
    NSString *resultString = [self.mString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([elementName isEqualToString:@"subimg"]) {
        self.word.subimg = resultString;
    }else if ([elementName isEqualToString:@"suben"]){
        self.word.suben = resultString;
    }else if ([elementName isEqualToString:@"subcn"]){
        self.word.subcn = resultString;
    }else if ([elementName isEqualToString:@"keyword"]){
        self.word.keyword = resultString;
    }else if ([elementName isEqualToString:@"yinbiao"]){
        self.word.yinbiao = resultString;
    }else if ([elementName isEqualToString:@"explain"]){
        self.word.explain = resultString;
    }else if ([elementName isEqualToString:@"subaudio"]){
        self.word.subaudio = resultString;
    }else if ([elementName isEqualToString:@"subid"]){
        self.word.subid = @(resultString.intValue);
        NSLog(@"fuck");
    }else if ([elementName isEqualToString:@"filmname"]){
        self.word.filmname = resultString;
    }else if ([elementName isEqualToString:@"filmid"]){
        self.word.filmid = @(resultString.intValue);
    }
    //NSLog(@"%@",self.mString);
    [self.mString setString:@""];
}

//文件解析完毕
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"did end document");
    NSLog(@"%lu",(unsigned long)self.words.count);
    
    //将模型传给collectionView的控制器
    MILWordsListController *wordListController = [self.childViewControllers lastObject];
    wordListController.words = self.words;
    
    MILWords *word = self.words[0];
    
    NSLog(@"%@",word.subimg);
    NSLog(@"%@",word.subaudio);
    NSLog(@"%@",word.subcn);
    NSLog(@"%@",word.filmname);
    
    //结束刷新
    //[self.refreshControl endRefreshing];
}

//找到!CDATA内容块
-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    NSString *string = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    
    [self.mString appendString:string];
}

//解析发生错误
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"解析错误:%@",parseError);
}


#pragma mark - 设置工具栏toolView

-(void)setToolView
{
//    self.toolView = [[MILToolView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 100)];

//#warning 为何会出现内存泄露
    //必须添加到子view，如果只是属性引用的话，没有父子关系？
    [self.view addSubview:self.toolView];
//    self.toolView.backgroundColor = MILRandom;
//    
//    // 设置代理
//    self.toolView.delegate = self;
    
}


#pragma mark - 设置collectionView

//static NSString * ID = @"homeCell";
-(void)setCollectionView
{

    MILWordsListController *wordList = [[MILWordsListController alloc] init];
    wordList.delegate = self;
    wordList.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.collectionView = wordList.collectionView;
    [self.view addSubview:self.collectionView];
    [self addChildViewController:wordList];
    
    wordList.collectionView.contentInset = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + 120, 0, 50, 0);
    
    [self.view bringSubviewToFront:self.toolView];
    
    
}


#pragma mark - 设置搜索条

-(void)setSearchbar
{
    [self.navigationController.navigationBar addSubview:self.searchBar];
}

#pragma mark - 搜索栏代理

// searchBar获得焦点
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 显示cancel button
    [self.searchBar setShowsCancelButton:YES animated:YES];
    
    // 添加蒙版
    self.coverView.hidden = NO;
    
    // 隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
}

// 点击searchBar取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // 隐藏蒙版并辞去第一响应者
    self.coverView.hidden = YES;
    [self.searchBar resignFirstResponder];
    
    // 隐藏cancel按钮
    [self.searchBar setShowsCancelButton:NO animated:YES];
    
    self.searchBar.text = nil;
    
    // 显示tabbar
    self.tabBarController.tabBar.hidden = NO;
    
}

// 点击了search按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    MILWordDetailController *vc = [[MILWordDetailController alloc] init];
    vc.title = @"单词详情";
    vc.word = self.searchText;
    // 为什么searchBar不会自动消失
    self.searchBar.hidden = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchText = searchText;
    [self.coverView reloadData];
}


#pragma mark - 蒙版tableView数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

static NSString *ID = @"coverCell";

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    if (self.searchText.length > 0) {
        cell.textLabel.text = self.searchText;
        cell.detailTextLabel.text = @"Fuck my life";
    }
    return cell;
}

#pragma mark - 蒙版tableView的代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MILWordDetailController *vc = [[MILWordDetailController alloc] init];
    vc.title = @"单词详情";
    vc.word = self.searchText;
    // 为什么searchBar不会自动消失
    self.searchBar.hidden = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
