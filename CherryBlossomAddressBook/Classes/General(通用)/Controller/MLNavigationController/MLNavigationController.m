//
//  MLNavigationController.m
//  MultiLayerNavigation
//
//  Created by Feather Chan on 13-4-12.
//  Copyright (c) 2013年 Feather Chan. All rights reserved.
//

#import "MLNavigationController.h"
#import <QuartzCore/QuartzCore.h>

#define KEY_WINDOW   [UIApplication sharedApplication].delegate.window
#define TOP_VIEW     [self currentTopView]
#define WINDOW_WIDTH [UIApplication sharedApplication].delegate.window.frame.size.width

@implementation CNavibar

- (void)layoutSubviews{
    [super layoutSubviews];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        [self adjustMargins:self.topItem.leftBarButtonItems isLeft:YES];
        [self adjustMargins:self.topItem.rightBarButtonItems isLeft:NO];
    }
}
- (void)adjustMargins :(NSArray *)barBtns isLeft:(BOOL)isLeft{
    CGFloat d = isLeft ? -8.0 : 8.0;
    for (UIBarButtonItem * barBtn in barBtns) {
        if (barBtn.customView) {
            UIView * view = barBtn.customView;
            CGPoint c = view.center;
            c.x += d;
            view.center = c;
        }
    }
}
@end


@interface MLNavigationController ()
{
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
    UIImageView *leftShadowView;
}

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;

@property (nonatomic,assign) BOOL isMoving;

@property (nonatomic,strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic,assign) CGPoint panOrigin;
@property (nonatomic,assign) BOOL animationInProgress;

@end

@implementation MLNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithNavigationBarClass:[CNavibar class] toolbarClass:nil];
    if (self) {
        self.screenShotsList = [[NSMutableArray alloc] initWithCapacity:2];
        if(rootViewController) self.viewControllers = @[rootViewController];
        self.canDragBack = YES;
        
//        [self.navigationBar setBackgroundImage:kNavibarBgImg forBarMetrics:UIBarMetricsDefault];
        if ([self.navigationBar respondsToSelector:@selector(setShadowImage:)]) {
            [self.navigationBar setShadowImage:[[UIImage alloc] init]];
        }
    }
    return self;
}

-(id)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass{
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    if (self) {
        self.screenShotsList = [[NSMutableArray alloc] initWithCapacity:2];
//        self.canDragBack = ![MZContants isPad];
        self.canDragBack = YES;
    }
    return self;
}

- (void)dealloc
{
    self.screenShotsList = nil;    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    [self setPanGesture:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // draw a shadow for navigation view to differ the layers obviously.
    // using this way to draw shadow will lead to the low performace
    // the best alternative way is making a shadow image.
    //
    //self.view.layer.shadowColor = [[UIColor blackColor]CGColor];
    //self.view.layer.shadowOffset = CGSizeMake(5, 5);
    //self.view.layer.shadowRadius = 5;
    //self.view.layer.shadowOpacity = 1;
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                                 action:@selector(paningGestureReceive:)];
    recognizer.delegate = self;
    self.panGesture = recognizer;
    [self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:(BOOL)animated];
    
    if (self.screenShotsList.count == 0 && self.canDragBack) {
        
        UIImage *capturedImage = [self capture];
        
        if (capturedImage) {
            [self.screenShotsList addObject:capturedImage];
        }
    }
    
    if (!leftShadowView) {
        UIImageView *shadowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"left-shadow"]];
        shadowImageView.frame = CGRectMake(-10, 0, 10, TOP_VIEW.frame.size.height);
        [TOP_VIEW addSubview:shadowImageView];
        shadowImageView.alpha = 0.1;
        leftShadowView = shadowImageView;
    }
   
    
}

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL canDragBack = self.canDragBack ;
    
    if (canDragBack) {
        UIImage *capturedImage = [self capture];
        
        if (capturedImage) {
            [self.screenShotsList addObject:capturedImage];
        }
    }
 
    [super pushViewController:viewController animated:animated];
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsList removeLastObject];
    
    return [super popViewControllerAnimated:animated];
}

-(NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    [self.screenShotsList removeAllObjects];
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark - Utility Methods -
- (UIView *)currentTopView{
    UIViewController * rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (rootVC.presentedViewController) {
        return rootVC.presentedViewController.view;
    }else{
        return rootVC.view;
    }
}
// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(TOP_VIEW.bounds.size, TOP_VIEW.opaque, 0.0);
    [TOP_VIEW.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)backToPreviousWithAnimation{
    if (!self.canDragBack) {
        [self popViewControllerAnimated:YES];
        return;
    }
    
    if (_isMoving) {
        return;
    }
    
    _isMoving = YES;
    if (!self.backgroundView)
    {
        CGRect frame = TOP_VIEW.frame;
        
        self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        [TOP_VIEW.superview insertSubview:self.backgroundView belowSubview:TOP_VIEW];
        
        blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        blackMask.backgroundColor = [UIColor blackColor];
        [self.backgroundView addSubview:blackMask];
    }
    
    self.backgroundView.hidden = NO;
    
    if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
    
    UIImage *lastScreenShot = [self.screenShotsList lastObject];
    lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
    [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
    [self moveViewWithX:1];

    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self moveViewWithX:WINDOW_WIDTH];
    } completion:^(BOOL finished) {
        [self popViewControllerAnimated:NO];
        CGRect frame = TOP_VIEW.frame;
        frame.origin.x = 0;
        TOP_VIEW.frame = frame;
        
        _isMoving = NO;
        self.backgroundView.hidden = YES;
    }];
}

- (void)moveViewWithX:(float)x
{
//    NSLog(@"Move to:%f",x);
    x = x>WINDOW_WIDTH?WINDOW_WIDTH:x;
    x = x<0?0:x;
    
    CGRect frame = TOP_VIEW.frame;
    frame.origin.x = x;
    TOP_VIEW.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);
    alpha = 0.1- (x/(WINDOW_WIDTH*10));

//    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
    leftShadowView.alpha = alpha;
}

#pragma mark - UIGestureRecognizerDelegate

# pragma mark - Avoid Unwanted Vertical Gesture
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    return (translation.x>0) && (fabs(translation.x) > fabs(translation.y));
}

#pragma mark - Gesture recognizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIViewController * vc =  [self.viewControllers lastObject];
    if ([vc respondsToSelector:@selector(canDragBackInThisView)]) {
        BOOL canDragBack = [[vc performSelector:@selector(canDragBackInThisView)] boolValue];
        if (canDragBack==NO) {
            return NO;
        }
    }
    _panOrigin = vc.view.frame.origin;
    gestureRecognizer.enabled = YES;
    return !_isMoving;
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    DLog(@"%@ isMoving %d",NSStringFromCGPoint(_panOrigin),_isMoving);
//    DLog(@"other gesture %@",otherGestureRecognizer);
    if ([otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return NO;
    }
    return !_isMoving;
}

#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    BOOL canDragBack = self.canDragBack ;
    if ([[self topViewController] respondsToSelector:@selector(canDragBackInThisView)]) {
        canDragBack = canDragBack && [[[self topViewController] performSelector:@selector(canDragBackInThisView)] boolValue];
    }
    
    if (self.viewControllers.count <= 1 || !canDragBack) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;

        if (!self.backgroundView)
        {
            CGRect frame = TOP_VIEW.frame;
            
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            [TOP_VIEW.superview insertSubview:self.backgroundView belowSubview:TOP_VIEW];
            
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:WINDOW_WIDTH];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = TOP_VIEW.frame;
                frame.origin.x = 0;
                TOP_VIEW.frame = frame;
                
                _isMoving = NO;
                self.backgroundView.hidden = YES;

            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}

@end
