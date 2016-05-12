//
//  TranslateTaskController.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/2/16.
//  Copyright © 2016 millerd. All rights reserved.
//
//http://91dict.com/rr/subshow_word.php
//http://91dict.com/rr/subcontext_word.php?id=1894737

#import "TranslateTaskController.h"
#import "MILNetworkManager.h"
#import "TranslateTask.h"
#import "TranslateTaskCell.h"
#import "SubContextController.h"

@interface TranslateTaskController ()<NSXMLParserDelegate>

// 用于拼接内容
@property (nonatomic, strong) NSMutableString *mString;
// 创建单个模型
@property (nonatomic, strong) TranslateTask *task;
// 创建模型集合
@property (nonatomic, strong) NSMutableArray *tasks;

@end

@implementation TranslateTaskController

static NSString *ID = @"taskCell";

#pragma mark - 懒加载
-(NSMutableArray *)tasks
{
    if (_tasks == nil) {
        _tasks = [NSMutableArray array];
    }
    return _tasks;
}

-(NSMutableString *)mString
{
    if (_mString == nil) {
        _mString = [NSMutableString string];
    }
    return _mString;
}


#pragma mark - 控制器生命周期
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    
    // 取消分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // 注册cell
    //[self.tableView registerNib:[UINib nibWithNibName:@"TranslateTaskCell" bundle:nil] forCellReuseIdentifier:ID];
    
    // 发送请求
    NSString *urlString = @"http://91dict.com/rr/subshow_word.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //设定返回类型为text/xml
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    //发送请求
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSXMLParser *responseObject) {
        
        // 设置解析代理，并开始解析
        responseObject.delegate = self;
        [responseObject parse];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - TableView代理和数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 取得模型
    TranslateTask *task = self.tasks[indexPath.row];
    
    // 创建cell
    TranslateTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 也可在viewDidLoad中注册nib，就不用判断了
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TranslateTaskCell" owner:nil options:nil]lastObject];
    }
    
    // 模型赋值
    cell.task = task;
    
    return cell;
}

// 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 260;
}

// 点选cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    
    // 取得当前cell的模型
    TranslateTask *model = self.tasks[indexPath.row];
    
    // 创建subContext控制器
    SubContextController *vc = [[SubContextController alloc] init];
    vc.task = model;
    
    // 跳转控制器
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - XML解析代理
// 开始解析文档
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"开始解析文档");
}

// 开始解析标签
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if ([elementName isEqualToString:@"sub"]) {
        // 创建单个模型并添加到数组中
        self.task = [[TranslateTask alloc] init];
        [self.tasks addObject:self.task];
    }
}

// 找到字符
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // 拼接字符串

    [self.mString appendString:string];
    
//    NSLog(@"找到字符串%@", string);

}

// 找到CDATA块
-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    // 转换CDATA块后拼接
    NSString *cdata = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    [self.mString appendString:cdata];
}

// 标签解析完毕
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSString *resultString = [self.mString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([elementName isEqualToString:@"subimg"]) {
        self.task.subimg = resultString;
    }else if ([elementName isEqualToString:@"subaudio"]){
        self.task.subaudio = resultString;
    }else if ([elementName isEqualToString:@"suben"]){
        self.task.suben = resultString;
    }else if ([elementName isEqualToString:@"subcn"]){
        self.task.subcn = resultString;
    }else if ([elementName isEqualToString:@"vname"]){
        self.task.vname = resultString;
    }else if ([elementName isEqualToString:@"subid"]){
        self.task.subid = @(resultString.intValue);
    }else if ([elementName isEqualToString:@"sid"]){
        self.task.sid = @(resultString.intValue);
    }else if ([elementName isEqualToString:@"filmid"]){
        self.task.filmid = resultString;
    }else if ([elementName isEqualToString:@"joinnum"]){
        self.task.joinnum = resultString.intValue;
    }else if ([elementName isEqualToString:@"level"]){
        self.task.level = resultString.intValue;
    }else if ([elementName isEqualToString:@"subaudio"]){
        self.task.mysubcn = resultString;
    }
    
    // 清空拼接字符串
    [self.mString setString:@""];
}

// 文档解析完毕
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    TranslateTask *task = self.tasks[0];
    NSLog(@"%@", task.subimg);
    [self.tableView reloadData];
}

// 文档解析错误
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"解析发生错误-%@", parseError);
}

@end
