//
//  MILArchiveTool.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/8/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILArchiveTool.h"
#import "MILWords.h"

#define MILCollectionFile  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collection.data"]

@implementation MILArchiveTool

static NSMutableArray *_collectionArray;

+ (void)initialize
{
    // 从文件中读取之前收藏
    _collectionArray = [NSKeyedUnarchiver unarchiveObjectWithFile:MILCollectionFile];
    // 如果是第一次收藏,先初始化一个可变的数组
    if (_collectionArray == nil) {
        _collectionArray = [NSMutableArray array];
    }
    
}

+ (NSMutableArray *)alreadyInCollection
{
    return _collectionArray;
}

+ (void)collect:(MILWords *)deal
{
    // 1. 将收藏的团购插入到数组的最前面
    [_collectionArray insertObject:deal atIndex:0];
    // 2. 归档
    [NSKeyedArchiver archiveRootObject:_collectionArray toFile:MILCollectionFile];
    NSLog(@"%@", MILCollectionFile);
}

+ (void)uncollect:(MILWords *)deal
{
    // 1. 移除团购
    [_collectionArray removeObject:deal];
    // 2. 归档
    [NSKeyedArchiver archiveRootObject:_collectionArray toFile:MILCollectionFile];
}

// 判断是否已经收藏
+ (BOOL)isCollected:(MILWords *)deal
{
    return [_collectionArray containsObject:deal];
}


@end
