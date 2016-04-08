//
//  AvatarScaleViewController.m
//  Penkr
//
//  Created by RenSihao on 16/1/18.
//  Copyright © 2016年 ShopEX. All rights reserved.
//

#import "ImageScaleViewController.h"

@interface ImageScaleViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) UIImageView *imageView;
@end


@implementation ImageScaleViewController

- (instancetype)initWithImageView:(UIImageView *)originImageView
{
    if (self = [super init])
    {
        self.imageView.image = originImageView.image;
    }
    return self;
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    //添加子控件
    [self.view addSubview:self.scrollerView];
    [self.scrollerView addSubview:self.imageView];
    
}



#pragma mark - lazy load
- (UIScrollView *)scrollerView
{
    if (!_scrollerView)
    {
        _scrollerView = [[UIScrollView alloc] init];
        _scrollerView.userInteractionEnabled = YES;
        _scrollerView.delegate = self;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.scrollsToTop = NO;
        _scrollerView.scrollEnabled = YES;
        _scrollerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        _scrollerView.maximumZoomScale = 2.0f;
        _scrollerView.minimumZoomScale = 0.5f;
        [_scrollerView setZoomScale:0.5f animated:YES];
        
        _scrollerView.contentMode = UIViewContentModeScaleAspectFit;
        _scrollerView.contentInset = UIEdgeInsetsMake(0, 20, 80, 20);
        
    }
    return _scrollerView;
}
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, NAVIBAR_AND_STATUSBAR_HEIGHT, SCREEN_WIDTH*2.0, SCREEN_HEIGHT*1.5);
        _imageView.userInteractionEnabled = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClick:)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
        doubleTap.numberOfTapsRequired = 2;
        doubleTap.numberOfTouchesRequired = 1;
        
        //单击和双击不能同时生效
        [singleTap requireGestureRecognizerToFail:doubleTap];
        
        [_imageView addGestureRecognizer:singleTap];
        [_imageView addGestureRecognizer:doubleTap];
    }
    return _imageView;
}



#pragma mark - private method
- (void)singleClick:(UITapGestureRecognizer *)singleTap
{
    NSLog(@"%s", __func__);
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)doubleClick:(UITapGestureRecognizer *)doubleTap
{
    //zoomScale这个值决定了contents当前扩展的比例
    float newScale = self.scrollerView.zoomScale * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[doubleTap locationInView:doubleTap.view]];
    [self.scrollerView zoomToRect:zoomRect animated:YES];
}
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.scrollerView.frame.size.height / scale;
    NSLog(@"zoomRect.size.height is %f",zoomRect.size.height);
    NSLog(@"self.frame.size.height is %f",self.scrollerView.frame.size.height);
    zoomRect.size.width  = self.scrollerView.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}


#pragma mark - UIGestureRecognizerDelegate

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
//当滑动结束时
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
{
    //把当前的缩放比例设进ZoomScale，以便下次缩放时实在现有的比例的基础上
    NSLog(@"scale is %f",scale);
    [self.scrollerView setZoomScale:scale animated:NO];
}







@end
