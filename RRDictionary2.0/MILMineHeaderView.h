//
//  MILMineHeaderView.h
//  RRDictionary2.0
//
//  Created by MillerD on 5/7/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MILMineHeaderViewDelegate <NSObject>

-(void)didClickHeadButton:(UIButton *)button;
-(void)didClickUnknownWordButton:(UIButton *)button;
-(void)didClickTranslateButton:(UIButton *)button;

@end

@interface MILMineHeaderView : UIView

@property (nonatomic, weak) id<MILMineHeaderViewDelegate> delegate;

@end
