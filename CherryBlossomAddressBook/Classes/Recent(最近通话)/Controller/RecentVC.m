//
//  RecentVC.m
//  AddressBook2.0
//
//  Created by mac-025 on 15/11/3.
//  Copyright © 2015年 mac-025. All rights reserved.
//

#import "RecentVC.h"
#import "RecentCell.h"

@interface RecentVC ()

@property (nonatomic, strong) RecentTitleView *titleView;

@end

@implementation RecentVC

#pragma mark - life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
}


#pragma mark - private method

- (void)setupNaviBarItems
{
    [super setupNaviBarItems];
    
    self.navigationItem.titleView = self.titleView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - lazyload
- (RecentTitleView *)titleView
{
    if(!_titleView)
    {
        _titleView = [[RecentTitleView alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    }
    return _titleView;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"RecentCell";
    RecentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if(!cell)
    {
        cell = [[RecentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    return cell;
}



@end

