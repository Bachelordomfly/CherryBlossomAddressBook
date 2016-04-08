//
//  GoodsSearchBar.h
//  Penkr
//
//  Created by RenSihao on 16/3/10.
//  Copyright © 2016年 ShopEX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchBar;
@class CustomTextField;
@protocol SearchBarDelegate <NSObject>

@optional
/**
 *  实时回调输入字符变化
 *
 *  @param goodsSearchBar
 *  @param searchText
 */
- (void)searchBar:(SearchBar *)searchBar searchText:(NSString *)searchText;

/**
 *  点击搜索回调
 *
 *  @param goodsSearchBar
 *  @param searchText
 */
- (void)searchBar:(SearchBar *)searchBar didClickSearchText:(NSString *)searchText;

/**
 *  点击取消回调
 *
 *  @param goodsSearchBar 
 */
- (void)searchBarDidClickCancel:(SearchBar *)searchBar;
@end


/**************** 自定义SearchBar 包含cancelButton ************************/
@interface SearchBar : UIView

@property (nonatomic, strong) CustomTextField *searchTextField;//自定义搜索框
@property (nonatomic, weak) id<SearchBarDelegate> delegate;
@end


/**************** 为了实现UI精细 自定义UITextField ************************/
@interface CustomTextField : UITextField

@end

