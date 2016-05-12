//
//  SubContextCell.h
//  RRDictionary2.0
//
//  Created by MillerD on 5/6/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubContext.h"

@interface SubContextCell : UITableViewCell

// 传入模型
@property (nonatomic, strong) Mysub *model;
// 遮盖cell
@property (nonatomic, assign) int mysid;

@end
