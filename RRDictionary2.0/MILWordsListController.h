//
//  MILWordsListController.h
//  RRDictionary2.0
//
//  Created by MillerD on 3/29/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <UIKit/UIKit.h>

// 刷新代理
@protocol MILWordsListRefreshDelegate <NSObject>

-(void)wordListPullToRefresh:(UIRefreshControl *)refreshControl;

@end
@interface MILWordsListController : UICollectionViewController

// 模型
@property (nonatomic, strong) NSArray *words;
// 刷新代理
@property (nonatomic, weak) id<MILWordsListRefreshDelegate> delegate;

@end
