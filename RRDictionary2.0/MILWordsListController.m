//
//  MILWordsListController.m
//  RRDictionary2.0
//
//  Created by MillerD on 3/29/16.
//  Copyright © 2016 millerd. All rights reserved.
//

//http://91dict.com/rr/subcontext_word.php?id=1989032

#import "MILWordsListController.h"
#import "MILHomeCell.h"
#import "MILHomeController.h"
//#import <SDImageCache.h>
#import "MILContextDetailController.h"

@interface MILWordsListController () <UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
//@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end
@implementation MILWordsListController


static NSString *ID = @"homeCell";

// 为模型赋值时set方法
-(void)setWords:(NSArray *)words
{
    _words = words;
    [self.collectionView reloadData];
    
    //[self.refreshControl endRefreshing];
    
}

-(instancetype)init
{
    // 设置flowLayout
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 275);

    // 设置水平滚动
    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    return [super initWithCollectionViewLayout:self.flowLayout];
}

#pragma mark - 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem hidesBackButton];
    
    // 设置collection
    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    // 注册xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"MILHomeCell" bundle:nil] forCellWithReuseIdentifier:ID];
 
    // 设置刷新控件
    [self setupRefresh];

}

#pragma mark - 刷新操作
// 设置刷新控件
-(void)setupRefresh
{
    // 下拉刷新
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    
    // 马上进入刷新状态并不会触发UIControlEventValueChanged
    [refreshControl beginRefreshing];
    
    // 加载数据
    [self refreshStateChange:refreshControl];
    
}

// 刷新执行
-(void)refreshStateChange:(UIRefreshControl *)refreshControl
{
    if ([self.delegate respondsToSelector:@selector(wordListPullToRefresh:)]) {
        [self.delegate wordListPullToRefresh:refreshControl];
    }
    
}

#pragma mark - collectionView的数据源
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.words.count == 0) {
        return 10;
    }
    else{
        return self.words.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MILHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[MILHomeCell alloc] init];
//    }
    
    if (self.words.count != 0) {
        cell.word = self.words[indexPath.item];
    }
    
//    // 清除缓存?
//    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
//    [[SDImageCache sharedImageCache] clearDisk];
//    [[SDImageCache sharedImageCache] clearMemory];
    

    return cell;
}

// 点选
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 取得模型
    //cell.word = self.words[indexPath.item];
    MILContextDetailController *vc = [[MILContextDetailController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - ScrollView代理方法

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    MILHomeController *homeCtl = (MILHomeController *)self.parentViewController;
    
    homeCtl.collectionOffset = scrollView.contentOffset.y;
    
}

@end
