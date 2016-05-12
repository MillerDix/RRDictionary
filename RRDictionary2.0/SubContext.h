//
//  SubContext.h
//  RRDictionary2.0
//
//  Created by MillerD on 5/6/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mysub.h"

@interface SubContext : NSObject

// 遮盖的内容编号
@property (nonatomic, assign) int mysid;
// mysub数组
@property (nonatomic, strong) NSArray *mysub;

@end
