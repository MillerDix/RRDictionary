//
//  MILMysub.h
//  RRDictionary2.0
//
//  Created by MillerD on 5/1/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MILMysub : NSObject

@property (nonatomic, strong) NSArray *sub;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)subWithDict:(NSDictionary *)dict;

@end
