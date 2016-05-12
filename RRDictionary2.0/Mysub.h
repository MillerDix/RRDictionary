//
//  Mysub.h
//  RRDictionary2.0
//
//  Created by MillerD on 5/6/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mysub : NSObject
// 图片
@property (nonatomic, copy) NSString *subimg;
// 音频地址
@property (nonatomic, copy) NSString *subaudio;
// 英文字幕
@property (nonatomic, copy) NSString *suben;
// 中文字幕
@property (nonatomic, copy) NSString *subcn;
// task编号,此处英文有误
@property (nonatomic, assign) int sudid;
// sid
@property (nonatomic, assign) int sid;

@end
