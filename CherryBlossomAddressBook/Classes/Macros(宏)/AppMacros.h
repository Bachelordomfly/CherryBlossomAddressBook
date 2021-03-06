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
#import <MessageUI/MessageUI.h>

/* Const */
#import "DataBasePath.h"

/* 宏文件 */
#import "ConfigMacro.h"
#import "NotificationMacro.h"


/* Venders */
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "AMSmoothAlertView.h"
#import "HTPressableButton.h"
#import "SVProgressHUD.h"
#import "FMDB.h"
#import "MJExtension.h"

/* HttpRequest */



/* Controler */
#import "JJNavigationController.h"
#import "GestureNavigationController.h"
#import "MLNavigationController.h"
#import "ABTabBarController.h"
#import "BaseVC.h"
#import "BaseTableVC.h"


/* Model */
#import "Model.h"
#import "UserModel.h"
#import "ContacterModel.h"

/* Managers */
#import "AppManager.h"
#import "UserManager.h"
#import "DataBaseManager.h"

/* Category */
#import "UIView+Util.h"
#import "UIImage+FlatUI.h"
#import "UIView+Frame.h"
#import "UIView+Util.h"
#import "UIView+Additions.h"
#import "UIImage+Tint.h"
#import "UITextField+Category.h"
#import "NSString+Utilities.h"
#import "UIColor+Util.h"


/* View */
#import "Views.h"
#import "SPTextFieldView.h"
#import "JJButton.h"
#import "BaseTableViewCell.h"
#import "BaseSimpleCell.h"
#import "SKTagView.h"
#import "SKTag.h"

#import "SKTagButton.h"
#import "FlipTableView.h"
#import "SegmentTapView.h"

#pragma mark - 快捷方法

//点击列表后，还原列表状态为deselect状态
#define deselectRowWithTableView(tableView) double delayInSeconds = 1.0;dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));dispatch_after(popTime, dispatch_get_main_queue(), ^(void){[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];});

//随机颜色
#define kColorARC4Random [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

//Document文件夹路径
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//根据联系人id 获取本地头像图片路径
#define AvatarPathWithContacterID(contacterID) [DocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld", contacterID]]

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

#define NAVIBAR_AND_STATUSBAR_HEIGHT 64

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
#define SHFontTabBarItem  [UIFont systemWithFont:20]

#define kDefaultRegularFontFamilyName @"HelveticaNeue"
#define kDefaultBoldFontFamilyName    @"HelveticaNeue-Bold"
#define kDefaultFontFamilyNameForRead @"XinGothic-Mzread W4"

#pragma mark - UIColor


#define kColorBlue          UIColorFromRGBA_D(36, 175, 224, 1)
#define kColorMain          UIColorFromRGBA_D(253, 165, 198, 1)
#define kColorTabBarItem    UIColorFromRGBA_D(252, 99, 97, 1)

#define kColorAppMain       UIColorFromRGB_0x(0xf7e4ed)       //APP主色调(樱花色)
#define kColorBgMain        UIColorFromRGB_0x(0xFFFFFF)       //一级框架背景色(纯白色)
#define kColorBgSub         UIColorFromRGB_0x(0xeFeFF4)       //二级框架背景色
#define kColorBgLine        UIColorFromRGB_0x(0xfa8ec2)       //普通分割线颜色
#define kColorHairline      UIColorFromRGB_0x(0xe5e5e5)        //cell分割线颜色
#define kSimpleCellHeight   55.f
#define kColorTextMain      UIColorFromRGB_0x(0x333333)
#define kColorTextSub       UIColorFromRGB_0x(0x666666)

#define kColorCellBgSel    [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.95f alpha:1.0f] //cell背景色
#define kNaviBarBgImg [UIImage imageWithColor:kColorAppMain cornerRadius:0]

#pragma mark - 预编译函数及命令

//发布(release)的项目不打印日志
#ifndef __OPTIMIZE__ //debug
#define NSLog(...) NSLog(__VA_ARGS__)
#else //release
#define NSLog(...) {}
#endif





#endif /* Macros_h */
