//
//  UIButton+Custom.m
//  RRDictionary2.0
//
//  Created by MillerD on 5/2/16.
//  Copyright © 2016 millerd. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton (Custom)

-(instancetype)initWithTitle:(NSString *)title normalColor:(UIColor *)normalColor highlightColor:(UIColor *)hightlightColor
{
    if (self = [super init]) {
        [self setBackgroundImage:[self createImageWithColor:normalColor] forState:UIControlStateNormal];
        self.titleLabel.text = title;
        [self setBackgroundImage:[self createImageWithColor:hightlightColor] forState:UIControlStateHighlighted];
    }
    return self;
}

// 颜色转图片
-(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
