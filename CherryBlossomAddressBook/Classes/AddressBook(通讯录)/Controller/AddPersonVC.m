//
//  AddPersonVC.m
//  AdressBook
//
//  Created by XuJiajia on 16/1/31.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "AddPersonVC.h"


static NSInteger const lineSpace = 11;

@interface AddPersonVC ()
<
SKTagViewDelegate,
UIPickerViewDelegate,
UIPickerViewDataSource
>

#pragma mark - 控件

/**
 *  头像
 */
@property(nonatomic, strong)UIImageView *avatorImageV;

/**
 *  姓名
 */
@property(nonatomic, strong) SPTextFieldView *nameTextV;

/**
 *  电话
 */
@property(nonatomic, strong) SPTextFieldView *numbleTextV;

/**
 *  地址
 */
@property(nonatomic, strong) SPTextFieldView *addressTextV;

/**
 *  性别
 */
@property (nonatomic, strong) SPTextFieldView *sexTF;

/**
 *  性别选择器
 */
@property (nonatomic, strong) UIPickerView *sexPickerView;

/**
 *  性别选择器数据源
 */
@property (nonatomic, strong) NSArray *sexArray;

/**
 *  标签提示
 */
@property(nonatomic, strong) UILabel *tagLable;

/**
 *  已选标签视图
 */
@property(nonatomic, strong) SKTagView *tagTextFiled;
@property(nonatomic, strong) UIScrollView *selectedScrollView;


/**
 *  可选标签视图
 */
@property (nonatomic, strong) UIScrollView *allTagsScrollerV;
@property (nonatomic, strong) SKTagView    *allTagsView;

#pragma mark - 数据

/**
 *  所有标签数组
 */
@property (nonatomic, strong) NSArray *allTagsArray;

/**
 *  已选标签数组
 */
@property(nonatomic, strong) NSMutableArray *selectedTagsArray;

/**
 *  手动输入标签数组
 */
@property (nonatomic, strong) NSArray *inputTag;

/**
 *  当前构建的联系人模型
 */
@property (nonatomic, strong) ContacterModel *contacterModel;

@end

@implementation AddPersonVC

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"新建联系人";
    [self addAllSubViews];
    
    weakSelf(self);
    [self.allTagsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        JJTag *tag = [JJTag tagWithText:obj];
        [tag setSelected:[weakSelf.selectedTagsArray containsObject:obj]];
        [weakSelf.allTagsView addTag:tag];
    }];
}
- (void)setupNaviBarItems
{
    [super setupNaviBarItems];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(didClickSave)];
}

-(void)addAllSubViews
{
    [self.view addSubview:self.avatorImageV];
    [self.view addSubview:self.nameTextV];
    [self.view addSubview:self.numbleTextV];
    [self.view addSubview:self.addressTextV];
    [self.view addSubview:self.sexTF];
    [self.view addSubview:self.tagLable];
    [self.view addSubview:self.selectedScrollView];
    [self.view addSubview:self.allTagsScrollerV];
}

-(void)viewDidLayoutSubviews{

    [self.avatorImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(4);
        make.width.height.mas_equalTo(100);
    }];
    
    [self.nameTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatorImageV.mas_right).offset(10);
        make.top.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    [self.numbleTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTextV.mas_bottom).offset(10);
        make.left.right.equalTo(self.nameTextV);
    }];
    
    [self.addressTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numbleTextV.mas_bottom).offset(10);
        make.left.right.equalTo(self.numbleTextV);
    }];
    
    [self.sexTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressTextV.mas_bottom).offset(10);
        make.left.right.equalTo(self.addressTextV);
    }];
    
    [self.tagLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sexTF.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
    }];
    
    [self.selectedScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLable.mas_bottom).offset(13.f);
        make.left.equalTo(self.view).offset(4);
        make.right.equalTo(self.view).offset(-4);
        make.height.mas_equalTo(44);
    }];
    
    CGFloat selectedMargin = 10;
    self.tagTextFiled.preferredMaxLayoutWidth = SCREEN_WIDTH - 20*2 - selectedMargin*2;
    [self.tagTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLable.mas_bottom).offset(10);
        make.left.equalTo(self.avatorImageV);
        make.right.equalTo(self.nameTextV);
        make.height.mas_equalTo(44);
    }];
    
    [self.allTagsScrollerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectedScrollView.mas_bottom).offset(13.f);
        make.bottom.equalTo(self.view).offset(8);
        make.left.right.equalTo(self.selectedScrollView);
    }];
    
    [self.allTagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(@(0));
    }];

}

#pragma mark - getter

- (UIImageView *)avatorImageV
{
    if (!_avatorImageV)
    {
        _avatorImageV = [[UIImageView alloc]init];
        _avatorImageV.image = [UIImage imageNamed:@"default_head_man"];
    }
    return _avatorImageV;
}
- (SPTextFieldView *)nameTextV
{
    if (!_nameTextV)
    {
        _nameTextV = [[SPTextFieldView alloc]init];
        _nameTextV.imageType = SPTextFieldImageNone;
        _nameTextV.textField.placeholder = @"姓名";
    }
    return _nameTextV;
}
- (SPTextFieldView *)numbleTextV
{
    if (!_numbleTextV)
    {
        _numbleTextV = [[SPTextFieldView alloc]init];
        _numbleTextV.imageType = SPTextFieldImageNone;
        _numbleTextV.textField.placeholder = @"电话号码";
        _numbleTextV.textField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _numbleTextV;
}
- (SPTextFieldView *)addressTextV
{
    if (!_addressTextV)
    {
        _addressTextV = [[SPTextFieldView alloc]init];
        _addressTextV.imageType = SPTextFieldImageNone;
        _addressTextV.textField.placeholder = @"地址";
    }
    return _addressTextV;
}
- (SPTextFieldView *)sexTF
{
    if (!_sexTF)
    {
        _sexTF = [[SPTextFieldView alloc] initWithSPTextFieldImageType:SPTextFieldImageNone];
        _sexTF.textField.placeholder = @"性别";
        _sexTF.textField.inputView = self.sexPickerView;
    }
    return _sexTF;
}
- (UIPickerView *)sexPickerView
{
    if (!_sexPickerView)
    {
        _sexPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
        _sexPickerView.delegate = self;
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(didSaveSex:)];
         UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didCancelSex:)];
        toolBar.items = @[cancelBtn, flexSpace,doneBtn];
        [_sexPickerView addSubview:toolBar];
        
    }
    return _sexPickerView;
}
- (NSArray *)sexArray
{
    if (!_sexArray)
    {
        _sexArray = @[@"未知", @"男", @"女"];
    }
    return _sexArray;
}
- (UILabel *)tagLable
{
    if (!_tagLable)
    {
        _tagLable = [[UILabel alloc]init];
        _tagLable.text = @"标签（最多可选择三个）";
        _tagLable.textColor = [UIColor orangeColor];
        _tagLable.font = [UIFont systemFontOfSize:16];
    }
    return _tagLable;
}
- (SKTagView *)tagTextFiled
{
    if (!_tagTextFiled)
    {
        _tagTextFiled = [[SKTagView alloc]init];
        _tagTextFiled.backgroundColor = [UIColor clearColor];
        _tagTextFiled.padding   = UIEdgeInsetsMake(5, 10, -5, -5);
        _tagTextFiled.insets    = 6;
        _tagTextFiled.lineSpace = lineSpace;
        _tagTextFiled.delegate = self;
        
        weakSelf(self);
        _tagTextFiled.didClickTagAtIndex = ^(NSUInteger index){
            NSString *tag = [weakSelf.allTagsArray objectAtIndex:index];
            [weakSelf didToggleTag:tag scroll:NO];
        };
        CGFloat selectedMargin = 10;
        _tagTextFiled.preferredMaxLayoutWidth = SCREEN_WIDTH-20*2 - selectedMargin*2;
        
    }
    return _tagTextFiled;
}

-(UIScrollView *)allTagsScrollerV{

    if (!_allTagsScrollerV) {
        _allTagsScrollerV = [[UIScrollView alloc]init];
        _allTagsScrollerV.backgroundColor = [UIColor clearColor];
        _allTagsScrollerV.bounces = YES;
        _allTagsScrollerV.alwaysBounceVertical = YES;
        _allTagsScrollerV.showsVerticalScrollIndicator = YES;
        _allTagsScrollerV.scrollEnabled = YES;
        [_allTagsScrollerV addSubview:self.allTagsView];
    }
    return _allTagsScrollerV;
}

-(SKTagView *)allTagsView{

    if (!_allTagsView) {
        _allTagsView = [[SKTagView alloc]init];
        _allTagsView.backgroundColor = [UIColor clearColor];
        _allTagsView.padding   = UIEdgeInsetsMake(10, 10, 10, 10);
        _allTagsView.insets    = 5;
        _allTagsView.lineSpace = 8;

        __weak typeof(self) weakSelf = self;
        _allTagsView.didClickTagAtIndex = ^(NSUInteger index){
            NSString *tag = [weakSelf.allTagsArray objectAtIndex:index];
            [weakSelf didToggleTag:tag scroll:YES];
        };
        _allTagsView.preferredMaxLayoutWidth = SCREEN_WIDTH - 20*2;

    }
    return _allTagsView;
}

-(UIScrollView *)selectedScrollView{

    if (!_selectedScrollView) {
        _selectedScrollView = [[UIScrollView alloc]init];
        _selectedScrollView = [[UIScrollView alloc] init];
        _selectedScrollView.backgroundColor = [UIColor whiteColor];
        _selectedScrollView.layer.cornerRadius = 5.f;
        _selectedScrollView.layer.masksToBounds = YES;
        _selectedScrollView.bounces = YES;
        _selectedScrollView.alwaysBounceVertical = YES;
        _selectedScrollView.showsVerticalScrollIndicator = YES;
        _selectedScrollView.showsHorizontalScrollIndicator = NO;
        _selectedScrollView.scrollEnabled = YES;
        
        [_selectedScrollView addSubview:self.tagTextFiled];
        
    }
    return _selectedScrollView;
}

-(NSArray *)allTagsArray
{

    if (!_allTagsArray)
    {
        _allTagsArray = [NSArray arrayWithObjects:@"逗比",@"书呆子",@"土豪",@"跟屁虫",@"大胸妹",@"大眼镜",@"小短腿",@"白富美",@"大帅哥",@"代码狗",@"百科全书",@"娘娘腔",@"女汉子",@"游戏王",@"男佣" ,nil];
    }
    return _allTagsArray;
}

-(NSMutableArray *)selectedTagsArray{

    if (!_selectedTagsArray) {
        
        _selectedTagsArray = [NSMutableArray array] ;
    }
    return _selectedTagsArray;
}

-(NSArray *)inputTag
{
    if (!_inputTag)
    {
        _inputTag = [NSArray array];
    }
    return _inputTag;
}
- (ContacterModel *)contacterModel
{
    if (!_contacterModel)
    {
        _contacterModel = [ContacterModel new];
    }
    return _contacterModel;
}

#pragma mark - UIPickerViewDataSource 协议
//返回列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.sexArray.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return SCREEN_WIDTH / 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.sexArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (row) {
        case 0:
            self.contacterModel.sex = ABSexUnknow;
            break;
        case 1:
            self.contacterModel.sex = ABSexMan;
            break;
        case 2:
            self.contacterModel.sex = ABSexWomen;
            break;
        default:
            break;
    }
}

#pragma mark - 选择性别点击事件
- (void)didSaveSex:(UIBarButtonItem *)item
{
    [self.sexTF resignFirstResponder];
    [self.view becomeFirstResponder];
}
- (void)didCancelSex:(UIBarButtonItem *)item
{
    self.contacterModel.sex = ABSexUnknow;
    [self.sexTF resignFirstResponder];
    [self.view becomeFirstResponder];
}


/*
 * 重新计算选中tag框的大小和滚动区域
 */
- (void)layoutSelectedScrollView:(BOOL)scroll
{
    CGFloat padding = 2*lineSpace;
    CGFloat contentHeight = self.tagTextFiled.intrinsicContentSize.height;
    if (contentHeight < 20) {
        contentHeight = 20;
    }
    
    contentHeight += padding;
    CGFloat height = contentHeight;
    if (height > 34*3 + padding) {
        height = 34*3 + padding;
    }
    
    [self.selectedScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(MAX(height, 50)));
    }];
    
    [self.view layoutIfNeeded];
    
    if (scroll) {
        if (height < contentHeight) {
            self.selectedScrollView.contentOffset = CGPointMake(0, contentHeight - height);
        }
    }
}

/*
 * 用户点击了Tag，执行选中开关操作
 */
- (void)didToggleTag:(NSString*)str scroll:(BOOL)scroll
{
    __block BOOL isSelected = YES;
    weakSelf(self);
    
    [self.selectedTagsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
         if ([(NSString*)obj isEqualToString:str])
         {
             isSelected = NO;
             [weakSelf.tagTextFiled removeTagAtIndex:idx];
             [weakSelf.selectedTagsArray removeObjectAtIndex:idx];
             *stop = YES;
         }
     }];
    
    if (isSelected == YES)
    {
        [self.selectedTagsArray addObject:str];
        
        JJTag *tag = [JJTag tagWithText:str];
        tag.textColor = UIColor.whiteColor;
        tag.bgColor = kColorMain;
        
        [self.tagTextFiled addTag:tag];
    }
    
    [self.allTagsView removeAllTags];
    
    [self.allTagsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        JJTag *tag = [JJTag tagWithText:obj];
        [tag setSelected:[weakSelf.selectedTagsArray containsObject:obj]];
        [weakSelf.allTagsView addTag:tag];
    }];
    
    [self.selectedTagsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSString*)obj isEqualToString:str]) {
            [weakSelf.tagTextFiled removeTagAtIndex:idx];
            
            if (isSelected) {
                [weakSelf insertSelectedTag:self.tagTextFiled tagText:obj atIndex:idx];
            } else {
                [weakSelf insertUnselectedTag:self.tagTextFiled tagText:obj atIndex:idx];
            }
            
            *stop = YES;
        }
    }];
    
    [self layoutSelectedScrollView:scroll];
}

/*
 * 插入一个未选中样式的Tag
 */
- (void)insertUnselectedTag:(SKTagView *)tagView tagText:(NSString *)tagText atIndex:(NSUInteger)atIndex
{
    JJTag *tag = [JJTag tagWithText:tagText];
    tag.textColor = kColorBgSub;
    tag.bgColor = [UIColor clearColor];
    
    if (atIndex == -1) {
        [tagView addTag:tag];
    } else {
        [tagView insertTag:tag atIndex:atIndex];
    }
}

/*
 * 插入一个选中样式的Tag
 */
- (void)insertSelectedTag:(SKTagView *)tagView tagText:(NSString *)tagText atIndex:(NSUInteger)atIndex
{
    JJTag *tag = [JJTag tagWithText:tagText];
    tag.textColor = [UIColor whiteColor];
    tag.bgColor = kColorMain;
    
    if (atIndex == -1) {
        [tagView addTag:tag];
    } else {
        [tagView insertTag:tag atIndex:atIndex];
    }
}

- (void)newTag:(NSString *)tagText
{
    if (tagText.length > 0) {
        //此处尚未加入到allTagsArray时,maxTagCount-1
//        if (self.allTagsArray.count > maxTagCount-1){
//            [NCHitMessage showInfoWithMessage:[NSString stringWithFormat:@"最多只能选择%ld个领域", (long)maxTagCount]];
//            return;
//        }
        
        [self insertSelectedTag:self.tagTextFiled tagText:tagText atIndex:-1];
        [self.selectedTagsArray addObject:tagText];
    }
    
    [self layoutSelectedScrollView:NO];
}

#pragma mark - 保存

- (void)didClickSave
{
    if ([[DataBaseManager shareInstanceDataBase] successOpenDataBaseType:ContacterDataBase])
    {
        //1、实例化联系人模型
        self.contacterModel.name = self.nameTextV.textField.text;
        self.contacterModel.phone = self.numbleTextV.textField.text;
        self.contacterModel.address = self.addressTextV.textField.text;
        
        NSString *tagStr = @"";
        for (NSString *tag in self.selectedTagsArray)
        {
            if (tag.length > 0)
            {
                tagStr = [tagStr stringByAppendingString:tag];
            }
        }
        self.contacterModel.tagStr = tagStr;
        
        //2、打开联系人数据库
        if ([[DataBaseManager shareInstanceDataBase] isExistsOfContacterModel:self.contacterModel])
        {
            [SVProgressHUD showErrorWithStatus:@"该联系人已存在！"];
            return ;
        }
        else
        {
            //3、插入数据
            if ([[DataBaseManager shareInstanceDataBase] successInsertContacterModel:self.contacterModel])
            {
                [SVProgressHUD showSuccessWithStatus:@"保存新联系人成功！"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
                //4、新建联系人 - 发布通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationContacterChange object:nil];
            }
        }
    }
}


@end
