//
//  MILWords.h
//  RRDictionary2.0
//
//  Created by MillerD on 3/24/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MILWords : NSObject

//图片地址
@property (nonatomic, copy) NSString *subimg;
//英文标题
@property (nonatomic, copy) NSString *suben;
//中文标题
@property (nonatomic, copy) NSString *subcn;
//关键字
@property (nonatomic, copy) NSString *keyword;
//音标
@property (nonatomic, copy) NSString *yinbiao;
//关键字翻译
@property (nonatomic, copy) NSString *explain;
//音频地址
@property (nonatomic, copy) NSString *subaudio;
//标题id
@property (nonatomic, copy) NSNumber *subid;
//剧名
@property (nonatomic, copy) NSString *filmname;
//剧集id
@property (nonatomic, copy) NSNumber *filmid;

@end
