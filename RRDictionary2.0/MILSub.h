//
//  MILSub.h
//  RRDictionary2.0
//
//  Created by MillerD on 5/1/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MILSub : NSObject

@property (nonatomic, copy) NSString *filmid;
@property (nonatomic, copy) NSString *filmname;
@property (nonatomic, copy) NSString *subaudio;
@property (nonatomic, copy) NSString *subcn;
@property (nonatomic, copy) NSString *suben;
@property (nonatomic, copy) NSString *subimg;

-(instancetype)initWithSub:(NSDictionary *)dict;
+(instancetype)initWithDict:(NSDictionary *)dict;

@end
