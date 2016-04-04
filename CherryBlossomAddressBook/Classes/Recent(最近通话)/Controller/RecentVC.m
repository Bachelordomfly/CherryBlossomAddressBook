//
//  RecentVC.m
//  AddressBook2.0
//
//  Created by mac-025 on 15/11/3.
//  Copyright © 2015年 mac-025. All rights reserved.
//

#import "RecentVC.h"

@interface RecentVC ()

@property (nonatomic, strong) RecentTitleView *titleView;
@property (nonatomic, strong) NSMutableArray *recentData;
@end

@implementation RecentVC

#pragma mark - 生命周期
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.titleView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //
    
}
#pragma mark - 自定义
/**
 加载数据源
 */
- (NSMutableArray *)recentData
{
    if(!_recentData)
    {
//        _recentData = [RecentCellInfo dataFromPlist ];
    }
    return _recentData;
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
    NSLog(@"%ld", self.recentData.count);
    return self.recentData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"RecentCell";
    RecentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if(!cell)
    {
        cell = [[RecentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    
//    cell.info = self.recentData[indexPath.row];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_recentData removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



@end

@implementation RecentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
}

@end
