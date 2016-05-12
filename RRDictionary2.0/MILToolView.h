//
//  MILToolView.h
//  RRDictionary2.0
//
//  Created by MillerD on 3/21/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MILToolViewDelegate <NSObject>

-(void)pushToController:(UIViewController *)controller byButton:(UIButton *)button;
@end
@interface MILToolView : UIView

@property (nonatomic, weak) id<MILToolViewDelegate> delegate;

@end
