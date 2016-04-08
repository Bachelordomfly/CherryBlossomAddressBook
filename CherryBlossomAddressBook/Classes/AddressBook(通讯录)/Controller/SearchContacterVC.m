//
//  SearchContacterVC.m
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import "SearchContacterVC.h"
#import "SearchBar.h"

@interface SearchContacterVC () <SearchBarDelegate>

@property (nonatomic, strong) SearchBar *searchBar;
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

- (SearchBar *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[SearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _searchBar.delegate = self;
    }
    return _searchBar;
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
