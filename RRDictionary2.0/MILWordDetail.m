//
//  MILWordDetail.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/1/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "MILWordDetail.h"
#import "NSString+Base64Decode.h"

@implementation MILWordDetail

-(instancetype)initWithDetail:(NSDictionary *)dict
{
    if (self = [super init]) {
        // html代码NSString
        NSString *detailText = dict[@"detail"];
        if (detailText.length > 0 && detailText != nil)
            self.detail = [NSString base64DecodeToString:detailText];
        
        self.explain = [NSString base64DecodeToString:dict[@"explain"]];
        // gotta be wrong
        self.klingon = dict[@"klingon"];
        // mysub
        NSDictionary *mysubTemp = dict[@"mysub"];
        self.mysub = [MILMysub subWithDict:mysubTemp];
        self.name = [NSString base64DecodeToString:dict[@"name"]];
        self.tip = [NSString base64DecodeToString:dict[@"tip"]];
        self.tip2 = [NSString base64DecodeToString:dict[@"tip2"]];
        self.wordaudio = [NSString base64DecodeToString:dict[@"wordaudio"]];
        self.yinbiao = [NSString base64DecodeToString:dict[@"yinbiao"]];
    }
    return self;
}

+(instancetype)initWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDetail:dict];
}

@end
