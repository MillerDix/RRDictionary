//
//  MILSub.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/1/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILSub.h"
#import "NSString+Base64Decode.h"

@implementation MILSub

-(instancetype)initWithSub:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.filmid = [NSString base64DecodeToString:dict[@"filmid"]];
        self.filmid = [NSString base64DecodeToString:dict[@"filmname"]];
        self.filmid = [NSString base64DecodeToString:dict[@"subaudio"]];
        self.filmid = [NSString base64DecodeToString:dict[@"subcn"]];
        self.filmid = [NSString base64DecodeToString:dict[@"suben"]];
        self.filmid = [NSString base64DecodeToString:dict[@"subimg"]];
    }
    return self;
}

+(instancetype)initWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithSub:dict];
}

@end
