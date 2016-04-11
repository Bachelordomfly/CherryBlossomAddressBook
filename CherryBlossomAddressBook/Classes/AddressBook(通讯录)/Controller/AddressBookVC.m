//
//  AddressBookVC.m
//  AddressBook2.0
//
//  Created by xujiajia on 15/11/3.
//  Copyright © 2015年 xujiajia. All rights reserved.
//

#import "AddressBookVC.h"
#import "ContacterDetailVC.h"
#import "SearchContacterVC.h"

@interface AddressBookVC () <UISearchBarDelegate>

/**
 *  搜索框
 */
@property (nonatomic, strong) UISearchBar *searchBar;

/**
 *  联系人数组（未排序）
 */
@property(nonatomic, strong) NSMutableArray *arrContact;

/**
 *  联系人列表（已排序）
 */
@property(nonatomic, strong) NSMutableArray *listContent;

/**
 *  分组名数组
 */
@property (nonatomic, strong) NSMutableArray *sectionTitles;
@end

@implementation AddressBookVC

#pragma mark - init

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"联系人";

    [self addAllSubViews];
    [self parseContacts];
}

-(void)addAllSubViews
{
    [self.view addSubview:self.searchBar];
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), self.tableView.width, self.tableView.height - NAVIBAR_AND_STATUSBAR_HEIGHT);
}

/**
 *  解析联系人列表
 */
- (void)parseContacts
{
    //先清空列表
    [self.listContent removeAllObjects];
    
    //
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles removeAllObjects];
    [self.sectionTitles addObjectsFromArray:[theCollation sectionTitles]];
    
    //
    for (ContacterModel *contacter in self.arrContact)
    {
        if(contacter.name.length > 0)
        {
            NSInteger sect = [theCollation sectionForObject:contacter
                                    collationStringSelector:@selector(name)];
            contacter.sectionNumber = sect;
        }
    }
    
    // 组
    NSInteger highSection = [[theCollation sectionTitles] count];
    NSMutableArray *sectionArrays = [NSMutableArray arrayWithCapacity:highSection];
    for (int i=0; i<=highSection; i++)
    {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sectionArrays addObject:sectionArray];
    }
    
    for (ContacterModel *contacter in self.arrContact)
    {
        [(NSMutableArray *)[sectionArrays objectAtIndex:contacter.sectionNumber] addObject:contacter];
    }
    
    for (NSMutableArray *sectionArray in sectionArrays)
    {
        ContacterModel *person=(ContacterModel *)sectionArray.firstObject;
        if (person.name.length > 0)
        {
            NSArray *sortedSection = [theCollation sortedArrayFromArray:sectionArray collationStringSelector:@selector(name)];
            [self.listContent addObject:sortedSection];
        }
    }
    
    //设置索引
    [self setTitleList];
}
/**
 *  设置索引
 */
- (void)setTitleList
{
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles removeAllObjects];
    [self.sectionTitles addObjectsFromArray:[theCollation sectionTitles]];
    
    NSMutableArray *existTitles = [NSMutableArray array];
    
    //过滤 就取存在的索引条标签
    for(int i=0; i<[_listContent count]; i++)
    {
        
        ContacterModel *pm=self.listContent[i][0];
        for(int j=0;j<self.sectionTitles.count;j++)
        {
            if(pm.sectionNumber == j)
            {
                [existTitles addObject:self.sectionTitles[j]];
            }
        }
    }
    
    [self.sectionTitles removeAllObjects];
    self.sectionTitles = existTitles;
    
    [self.tableView reloadData];
}


#pragma mark - getter

- (NSMutableArray *)arrContact
{
    if (!_arrContact)
    {
        _arrContact = [NSMutableArray array];
        NSDictionary *dict1 = @{@"name":@"王小明",
                               @"phone":@"18234080512",
                               @"avatarPath":@"login_logo",
                               @"sex":@(ABSexMan),
                               @"中国上海":@"address"};
        NSDictionary *dict2 = @{@"name":@"张小红",
                               @"phone":@"18200000000",
                               @"avatarPath":@"login_logo",
                               @"sex":@(ABSexWomen),
                               @"address":@"中国北京"};
        NSDictionary *dict3 = @{@"name":@"李小芳",
                                @"phone":@"18211111111",
                                @"avatarPath":@"login_logo",
                                @"sex":@(ABSexWomen),
                                @"address":@"中国山西"};

        ContacterModel *contacter1 = [ContacterModel mj_objectWithKeyValues:dict1];
        ContacterModel *contacter2 = [ContacterModel mj_objectWithKeyValues:dict2];
        ContacterModel *contacter3 = [ContacterModel mj_objectWithKeyValues:dict3];
        for(int i=0; i<3; i++)
        {
            [_arrContact addObject:contacter1];
            [_arrContact addObject:contacter2];
            [_arrContact addObject:contacter3];
        }
    }
    return _arrContact;
}
- (UISearchBar *)searchBar
{
    if (!_searchBar)
    {
         _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.placeholder = @"请输入搜索内容";
        [_searchBar setBarTintColor:[UIColor whiteColor]];
        _searchBar.showsScopeBar = YES;
        _searchBar.delegate = self;
        
        //取出tableBar中field控件，设置它的占位文字颜色
        for (UIView *subView in self.searchBar.subviews)
        {
            for (UIView *secondLevelSubview in subView.subviews)
            {
                if ([secondLevelSubview isKindOfClass:[UITextField class]])
                {
                    UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                    
                    searchBarTextField.placeholderColor = UIColorFromRGB_D(234, 137, 137);
                    searchBarTextField.backgroundColor = kColorBgSub;
                    searchBarTextField.frame = CGRectMake(30, 0, 285, 30);
                    searchBarTextField.font = [UIFont systemFontOfSize:15];
                    break;
                }
            }
        }
        for(UIView *view in _searchBar.subviews)
        {
            if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0)
            {
                [[view.subviews objectAtIndex:0] removeFromSuperview];
            }
        }
    }
    return _searchBar;
}
- (NSMutableArray *)listContent
{
    if (!_listContent)
    {
        _listContent = [NSMutableArray array];
    }
    return _listContent;
}
- (NSMutableArray *)sectionTitles
{
    if (!_sectionTitles)
    {
        _sectionTitles = [NSMutableArray array];
    }
    return _sectionTitles;
}

#pragma mark - UISearchBarDelegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    SearchContacterVC  *searchVC = [[SearchContacterVC alloc] init];
    JJNavigationController *searchNav = [[JJNavigationController alloc] initWithRootViewController:searchVC];
    [self presentViewController:searchNav animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.listContent count];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[self.listContent objectAtIndex:(section)] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"PCVCcell";
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if(!cell)
    {
        cell = [[AddressBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    NSArray *sectionArr=[self.listContent objectAtIndex:indexPath.section];
    ContacterModel *contacter = (ContacterModel *)[sectionArr objectAtIndex:indexPath.row];
    [cell configureCellWithContacterModel:contacter];
    cell.drawHeadLine = (indexPath.row == 0);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.listContent removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        
    }
}
//开启右侧索引条
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AddressBookCell cellHeight];
}

- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(self.sectionTitles==nil||self.sectionTitles.count==0)
    {
        return nil;
    }
    
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectZero];
    [viewSection setBackgroundColor:kColorBgSub];
    viewSection.userInteractionEnabled = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 10)];
    label.font=[UIFont fontWithName:@"STHeitiTC-Light" size:10];
    NSString *sectionStr=[self.sectionTitles objectAtIndex:(section)];
    [label setText:sectionStr];
    [viewSection addSubview:label];
    
    return viewSection;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    deselectRowWithTableView(self.tableView);
    
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    ContacterModel *person = (ContacterModel *)[sectionArr objectAtIndex:indexPath.row];
    ContacterDetailVC *detailVC = [[ContacterDetailVC alloc] initWithContacterModel:person];
    [self.navigationController pushViewController:detailVC animated:YES];
}




@end


#define stateImgWidth 22.f
#define userImgWidht 40.f
@interface AddressBookCell ()

@property (nonatomic, strong) UIImageView *imgUser;
@property (nonatomic, strong) UIImageView *imgState;
@property (nonatomic, strong) UILabel *lbTitle;

@property (nonatomic, strong) ContacterModel *model;
@end

@implementation AddressBookCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
//        self.backgroundColor = kColorAppMain;
//        UIView *fixView =[self.contentView addShadowTanView];
//        
//        UIImageView *avatorImageView = [[UIImageView alloc]init];
//        avatorImageView.image = [UIImage imageNamed:@"login_id_icon"];
//        [fixView addSubview:avatorImageView];
//        [avatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.equalTo(self.imageView);
//            make.left.equalTo(self).offset(20);
//            make.centerY.equalTo(self);
//        }];
//        
//        UILabel *nameLable = [[UILabel alloc]init];
//        nameLable.text = @"jiajia";
//        nameLable.font = [UIFont systemFontOfSize:25];
//        [fixView addSubview:nameLable];
//        [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.equalTo(self.textLabel);
//            make.left.equalTo(avatorImageView.mas_right).offset(10);
//            make.centerY.equalTo(avatorImageView);
//        }];
//
        
        self.backgroundColor = kColorBgMain;
        
        //头像
        _imgUser=[[UIImageView alloc]init];
        _imgUser.contentMode = UIViewContentModeScaleAspectFill;
        [_imgUser setBackgroundColor:kColorBgSub];
        _imgUser.layer.cornerRadius = 4.f;
        _imgUser.layer.masksToBounds = YES;
        [self.contentView addSubview:_imgUser];
        
        //
        _imgState=[[UIImageView alloc]init];
        _imgState.image = [UIImage imageNamed:@"contact_icon_active"];
        [self.contentView addSubview:_imgState];
        
        //名字
        _lbTitle=[[UILabel alloc]initWithFrame:CGRectMake(81, 18, 160, 25)];
        _lbTitle.font=[UIFont fontWithName:@"STHeitiTC-Light" size:16];
        [self.contentView addSubview:_lbTitle];
        
        self.separatorLineInset = 10.f;
        
    }
    return self;
}
- (void)configureCellWithContacterModel:(ContacterModel *)model
{
    _model = model;
    _imgUser.image = [UIImage imageNamed:_model.avatarPath];
    _imgState.image = [UIImage imageNamed:_model.sex == ABSexMan ? @"man_manager_icon":@"woman_manager_icon"];
    _lbTitle.text = _model.name;
}
+(CGFloat)cellHeight
{
    return 65.f;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgUser.frame = CGRectMake(10,([AddressBookCell cellHeight]-userImgWidht)/2.f, userImgWidht,userImgWidht);
    _imgState.frame = CGRectMake(CGRectGetMaxX(_imgUser.frame)+9.f, ([AddressBookCell cellHeight]-stateImgWidth)/2.f-2, stateImgWidth,stateImgWidth);
    
    CGFloat titleWidth = self.width - CGRectGetMaxX(_imgState.frame) - 9.f - 26.f;
    _lbTitle.frame = CGRectMake(CGRectGetMaxX(_imgState.frame)+2.f, ([AddressBookCell cellHeight]-stateImgWidth-4)/2.f,titleWidth ,stateImgWidth+4);
}



@end
