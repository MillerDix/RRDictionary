//
//  TranslateTask.h
//  RRDictionary2.0
//
//  Created by MillerD on 5/3/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TranslateTask : NSObject

// 图片地址
@property (nonatomic, copy) NSString *subimg;
// 音频地址
@property (nonatomic, copy) NSString *subaudio;
// 英文字幕
@property (nonatomic, copy) NSString *suben;
// 中文字幕
@property (nonatomic, copy) NSString *subcn;
// 剧集
@property (nonatomic, copy) NSString *vname;
// subid
@property (nonatomic, copy) NSNumber *subid;
// sid
@property (nonatomic, copy) NSNumber *sid;
// filmid
@property (nonatomic, copy) NSString *filmid;
// 参与人数
@property (nonatomic, assign) int joinnum;
// 难度
@property (nonatomic, assign) int level;
// mysubcn
@property (nonatomic, copy) NSString *mysubcn;

@end
