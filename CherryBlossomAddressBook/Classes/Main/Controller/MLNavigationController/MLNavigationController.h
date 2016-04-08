//
//  MLNavigationController.h
//  MultiLayerNavigation
//
//  Created by Feather Chan on 13-4-12.
//  Copyright (c) 2013年 Feather Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNavibar : UINavigationBar

@end

@interface MLNavigationController : UINavigationController <UIGestureRecognizerDelegate>

// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;
- (void)backToPreviousWithAnimation;
@end

@protocol MLNavigationControllerDelegate <NSObject>
@optional
-(NSNumber *)canDragBackInThisView;
@end