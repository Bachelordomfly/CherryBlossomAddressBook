//
//  Macros.h
//  MicroBlog
//
//  Created by xujiajia on 15/11/12.
//  Copyright © 2015年 xujiajia. All rights reserved.
//

#ifndef AppMacros_h
#define AppMacros_h


/* FrameWorks */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/* 宏文件 */
#import "ConfigMacro.h"
#import "NotificationMacro.h"


/* Venders */
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "AMSmoothAlertView.h"
#import "HTPressableButton.h"

/* HttpRequest */



/* Controler */
#import "JJNavigationController.h"
#import "ABTabBarController.h"
#import "BaseVC.h"
#import "BaseTableVC.h"


/* Model */
#import "ABModel.h"
#import "ContacterModel.h"

/* Managers */
#import "AppManager.h"
#import "UserManager.h"

/* Category */
#import "UIView+Util.h"


/* View */
#import "Views.h"
#import "SPTextFieldView.h"
#import "JJButton.h"

#pragma mark - 快捷方法

//点击列表后，还原列表状态为deselect状态
#define deselectRowWithTableView(tableView) double delayInSeconds = 1.0;dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));dispatch_after(popTime, dispatch_get_main_queue(), ^(void){[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];});

// self弱引用
#define weakSelf(args)   __weak typeof(args) weakSelf = args
// self强引用
#define strongSelf(args) __strong typeof(args) strongSelf = args

/*********** UIColor **************/
//UIColor 十六进制RGB_0x
#define UIColorFromRGB_0x(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//UIColor 十六进制RGBA_0x
#define UIColorFromRGBA_0x(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF000000) >> 24))/255.0 \
green:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
blue:((float)((rgbValue & 0xFF00) >>8 ))/255.0 \
alpha:((float)(rgbValue & 0xFF))/255.0]

//UIColor 十进制RGB_D
#define UIColorFromRGB_D(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

//UIColor 十进制RGBA_D
#define UIColorFromRGBA_D(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]

/************** CGColor *****************/
//CGColor 十六进制RGB_0x
#define CGColorFromRGB_0x(rgbValue) UIColorFromRGB_0x(rgbValue).CGColor

//CGColor 十六进制RGBA_0x
#define CGColorFromRGBA_0x(rgbValue) UIColorFromRGB_0x(rgbVaue).CGColor

//CGColor 十进制RGB_D
#define CGColorFromRGB_D(R, G, B) UIColorFromRGB_D(R, G, B).CGColor

//CGColor 十进制RGBA_D
#define CGColorFromRGBA_D(R, G, B, A) UIColorFromRGBA_D(R, G, B, A).CGColor


#define ColorWithSureButton 0x51C4D4
#define ColorWithSureButtonShadow 0x59D5F4

#define ColorWithViewBackgroud 0xF1F1F1
#define ColorWithCancleButton 0x51C4D4

/*************** General *****************/

#define SHKeyWindow [UIApplication sharedApplication].keyWindow //App唯一主窗口

#pragma mark - Frame

#define STATUES_HEIGHT 20 //默认状态栏高度
#define NAV_BAR_HEIGHT 64 //默认NavigationBar高度
#define TAB_BAR_HEIGHT 49 //默认TabBar高度

#define SCREEN_BOUNDS       [UIScreen mainScreen].bounds
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

#define CGWidth(rect)                   rect.size.width
#define CGHeight(rect)                  rect.size.height
#define CGOriginX(rect)                 rect.origin.x
#define CGOriginY(rect)                 rect.origin.y
#define CGEndX(rect)                 rect.origin.x + rect.size.width
#define CGEndY(rect)                 rect.origin.y + rect.size.height

#define WIDTH_3_5_INCH  320.f
#define WIDTH_4_INCH    320.f
#define WIDTH_4_7_INCH  375.f
#define WIDTH_5_5_INCH  414.f
#define HEIGHT_3_5_INCH 480.f
#define HEIGHT_4_INCH   568.f
#define HEIGHT_4_7_INCH 667.f
#define HEIGHT_5_5_INCH 736.f


#pragma mark - 适配机型和系统

#define WINDOW_3_5_INCH ([[UIScreen mainScreen] bounds].size.height == HEIGHT_3_5_INCH)
#define WINDOW_4_INCH   ([[UIScreen mainScreen] bounds].size.height == HEIGHT_4_INCH)
#define WINDOW_4_7_INCH ([[UIScreen mainScreen] bounds].size.height == HEIGHT_4_7_INCH)
#define WINDOW_5_5_INCH ([[UIScreen mainScreen] bounds].size.height == HEIGHT_5_5_INCH)

#define IOS_7_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS_9_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#define IMAGE_WIDTH 50.f


#pragma mark - Font

#define SHFontNavBarTitle [UIFont systemWithFont:34]
#define SHFontTabBarItem [UIFont systemWithFont:20]

#define kDefaultRegularFontFamilyName @"HelveticaNeue"
#define kDefaultBoldFontFamilyName @"HelveticaNeue-Bold"
#define kDefaultFontFamilyNameForRead @"XinGothic-Mzread W4"

#pragma mark - UIColor

#define kColorAppMain       UIColorFromRGB_0x(0xFF8200)      //APP主色调(橘色)
#define kColorBgMain        UIColorFromRGB_0x(0xFFFFFF)      //一级框架背景色(纯白色)
#define kColorBgSub         UIColorFromRGB_0x(0xeFeFF4)      //二级框架背景色



#pragma mark - 预编译函数及命令

//发布(release)的项目不打印日志
#ifndef __OPTIMIZE__ //debug
#define NSLog(...) NSLog(__VA_ARGS__)
#else //release
#define NSLog(...) {}
#endif





#endif /* Macros_h */
