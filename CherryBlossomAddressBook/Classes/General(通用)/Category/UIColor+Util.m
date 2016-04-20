//
//  UIColor+Util.m
//  CherryBlossomAddressBook
//
//  Created by XuJiajia on 16/4/20.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import "UIColor+Util.h"

@implementation UIColor (Util)

+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
