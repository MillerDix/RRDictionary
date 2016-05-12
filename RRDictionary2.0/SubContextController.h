//
//  SubContextController.h
//  RRDictionary2.0
//
//  Created by MillerD on 5/6/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TranslateTask.h"

@interface SubContextController : UITableViewController

// 上级页面传入的模型属性
@property (nonatomic, strong) TranslateTask *task;

@end
