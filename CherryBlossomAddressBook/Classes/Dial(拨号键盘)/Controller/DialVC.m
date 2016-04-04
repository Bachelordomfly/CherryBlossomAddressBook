//
//  DialVC.m
//  AddressBook2.0
//
//  Created by xujiajia on 15/11/3.
//  Copyright © 2015年 xujiajia. All rights reserved.
//

#import "DialVC.h"

#define ROW 4
#define COL 3

@interface DialVC ()

@property (nonatomic, strong) UITextField *headerTF;

@property (nonatomic, strong) NSMutableArray *btnArray;
@end

@implementation DialVC

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //添加头部隐藏视图（特殊）
    [self.view addSubview:self.headerTF];
    
    //添加数字按钮
    [self addDigitalButtons];
    
    //添加拨号按钮
    [self addDialButton];
    
    
}


#pragma mark - lazyload
- (UITextField *)headerTF
{
    if(!_headerTF)
    {
        _headerTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _headerTF.textAlignment = NSTextAlignmentCenter;
        _headerTF.backgroundColor = [UIColor whiteColor];
        _headerTF.placeholder = @"输入号码";
    }
    return _headerTF;
}

#pragma mark - 自定义方法
- (void)addDigitalButtons
{
    
}
- (void)addDialButton
{
    
}















@end
