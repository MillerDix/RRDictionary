//
//  MILArchiveTool.h
//  RRDictionary2.0
//
//  Created by MillerD on 5/8/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MILWords;
@interface MILArchiveTool : NSObject

/**
 *  收藏
 */
+ (void)collect:(MILWords *)deal;

/**
 *  取消收藏
 */
+ (void)uncollect:(MILWords *)deal;

/**
 *  判断是否被收藏
 */
+ (BOOL)isCollected:(MILWords *)deal;

// 已有收藏
+ (NSMutableArray *)alreadyInCollection;

@end
