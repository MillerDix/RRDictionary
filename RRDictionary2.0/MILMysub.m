//
//  MILMysub.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/1/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILMysub.h"
#import "MILSub.h"

@implementation MILMysub

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *mArray = [NSMutableArray array];
        
        if ([self.sub isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in self.sub) {
                MILSub *item = [MILSub initWithDict:dict];
                [mArray addObject:item];
            }
        }
        
        self.sub = mArray.copy;
        
    }
    return self;
}

+(instancetype)subWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

// 设置无效键
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{};

@end
