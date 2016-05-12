//
//  MILWordDetail.h
//  RRDictionary2.0
//
//  Created by MillerD on 5/1/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MILMysub.h"
#import "MILSub.h"

@interface MILWordDetail : NSObject

// 单词细节(html)
@property (nonatomic, copy) NSString *detail;
// 解释
@property (nonatomic, copy) NSString *explain;
// 克林贡语言?
@property (nonatomic, copy) NSDictionary *klingon;
// mysub
@property (nonatomic, strong) MILMysub *mysub;
// name
@property (nonatomic, copy) NSString *name;
// tip
@property (nonatomic, copy) NSString *tip;
// tip2
@property (nonatomic, copy) NSString *tip2;
// 音频
@property (nonatomic, copy) NSString *wordaudio;
// 音标
@property (nonatomic, copy) NSString *yinbiao;


-(instancetype)initWithDetail:(NSDictionary *)dict;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
