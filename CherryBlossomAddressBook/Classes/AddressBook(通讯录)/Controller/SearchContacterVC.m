//
//  SearchContacterVC.m
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import "SearchContacterVC.h"
#import "SearchBar.h"
#import "ContacterDetailVC.h"

@interface SearchContacterVC () <SearchBarDelegate>

@property (nonatomic, strong) SearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *contacterArray;
@end

@implementation SearchContacterVC

#pragma mark - init

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

#pragma mark - private method

- (void)setupNaviBarItems
{
    [super setupNaviBarItems];
    
    self.navigationItem.titleView = self.searchBar;
}

#pragma mark - getter
- (SearchBar *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[SearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}
- (NSMutableArray *)contacterArray
{
    if (!_contacterArray)
    {
        _contacterArray = [NSMutableArray array];
    }
    return _contacterArray;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

#pragma mark - SearchBarDelegate

/**
 *  实时回调输入字符变化
 *
 *  @param goodsSearchBar
 *  @param searchText
 */
- (void)searchBar:(SearchBar *)searchBar searchText:(NSString *)searchText
{
    
}

/**
 *  点击搜索回调
 *
 *  @param goodsSearchBar
 *  @param searchText
 */
- (void)searchBar:(SearchBar *)searchBar didClickSearchText:(NSString *)searchText
{
    if ([[DataBaseManager shareInstanceDataBase] successOpenDataBaseType:ContacterDataBase])
    {
        ContacterModel *contacterModel = [[DataBaseManager shareInstanceDataBase] getContacterModelOfContacterName:searchText];
        if (contacterModel)
        {
            ContacterDetailVC *vc = [[ContacterDetailVC alloc] initWithContacterModel:contacterModel];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"暂无此人"];
        }
    }
}

/**
 *  点击取消回调
 *
 *  @param goodsSearchBar
 */
- (void)searchBarDidClickCancel:(SearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
