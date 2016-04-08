//
//  BaseTableVC.m
//  AdressBook
//
//  Created by xujiajia on 16/3/28.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "BaseTableVC.h"

@interface BaseTableVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, assign) UITableViewStyle style;
@end

@implementation BaseTableVC

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithNibName:nil bundle:nil];
    if(self)
    {
        _style = style;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self initWithStyle:UITableViewStylePlain];
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //修正view的正确高度
    CGRect frame = self.view.frame;
    frame.size.height -= self.navigationController.navigationBar ? NAV_BAR_HEIGHT : 0;
    self.view.frame = frame;
    
    self.tableView.backgroundColor = kColorBgMain;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - getter/setter

- (UITableView *)tableView{
    if (!_tableView)
    {
        CGRect frame = self.view.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        _tableView = [[UITableView alloc] initWithFrame:frame style:_style];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

@end
