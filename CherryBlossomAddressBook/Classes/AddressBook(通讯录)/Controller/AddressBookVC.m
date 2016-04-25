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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.arrContact = nil;
    [self parseContacts];
}

#pragma mark - private method

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

#pragma mark - 通知相关

- (void)addNotificationObservers
{
    [super addNotificationObservers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotificationContacterChange:) name:kNotificationContacterChange object:nil];
}
- (void)removeNotificationObservers
{
    [super removeNotificationObservers];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveNotificationContacterChange:(NSNotification *)noti
{
    self.arrContact = nil;
    //重新读取数据库数据
    [self parseContacts];
}


#pragma mark - getter

- (NSMutableArray *)arrContact
{
    if (!_arrContact)
    {
        _arrContact = [NSMutableArray array];
        
        if ([[DataBaseManager shareInstanceDataBase] successOpenDataBaseType:ContacterDataBase])
        {
            _arrContact = [[DataBaseManager shareInstanceDataBase] getAllContacterModelOfDataBase];
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
        if ([[DataBaseManager shareInstanceDataBase] successOpenDataBaseType:ContacterDataBase])
        {
            ContacterModel *contacter = self.listContent[indexPath.section][indexPath.row];
            if ([[DataBaseManager shareInstanceDataBase] successDeleteContacterModle:contacter])
            {
                [SVProgressHUD showSuccessWithStatus:@"删除该联系人成功！"];
                [self didReceiveNotificationContacterChange:nil];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"删除联系人失败！"];
                return ;
            }
        }
        
        
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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [AddressBookCell cellHeight];
//}

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
/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *avatarImageView;

/**
 *  姓名
 */
@property (nonatomic, strong) UILabel *nameLab;

/**
 *  标签
 */
@property (nonatomic, strong) UILabel *tagLab;

/**
 *  联系人模型
 */
@property (nonatomic, strong) ContacterModel *model;
@end

@implementation AddressBookCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.backgroundColor = kColorAppMain;
        UIView *fixView =[self.contentView addShadowTanView];
        
        //头像
        _avatarImageView=[[UIImageView alloc]init];
        _avatarImageView.frame = CGRectMake(10,([AddressBookCell cellHeight]-userImgWidht)/2.f, userImgWidht,userImgWidht);
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.image = [UIImage imageNamed:@"default_head_woman"];
        [_avatarImageView setBackgroundColor:kColorBgSub];
        _avatarImageView.layer.cornerRadius = 4.f;
        _avatarImageView.layer.masksToBounds = YES;
        [fixView addSubview:_avatarImageView];
        

        
        //名字
        _nameLab=[[UILabel alloc]init];
        _nameLab.font = [UIFont systemFontOfSize:24];
        [fixView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_avatarImageView.mas_right).offset(10);
            make.centerY.equalTo(fixView);
        }];
        
        //标签
        _tagLab = [[UILabel alloc]init];
        _tagLab.text = @"大笨蛋,🐷";
        [_tagLab setTextColor:kColorMain];
        _tagLab.font = [UIFont systemFontOfSize:14];
        [fixView addSubview:_tagLab];
        [_tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLab.mas_right).offset(10);
            make.bottom.equalTo(self.nameLab);
        }];
        
        self.separatorLineInset = 10.f;
    }
    return self;
}
- (void)configureCellWithContacterModel:(ContacterModel *)model
{
    _model = model;
    _avatarImageView.image = [UIImage imageNamed:_model.avatarPath];
//    _imgState.image = [UIImage imageNamed:_model.sex == ABSexMan ? @"man_manager_icon":@"woman_manager_icon"];
    _nameLab.text = _model.name;
}
+(CGFloat)cellHeight
{
    return 65.f;
}




@end
