//
//  AddPersonVC.m
//  AdressBook
//
//  Created by XuJiajia on 16/1/31.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "AddPersonVC.h"


static NSInteger const lineSpace = 11;

@interface AddPersonVC ()<SKTagViewDelegate>
/**
 *  上传图片
 */
@property(nonatomic, strong)UIImageView *avatorImageV;
/**
 *  添加姓名
 *  添加号码
 *  添加地址
 *  添加标签
 */
@property(nonatomic, strong) SPTextFieldView *nameTextV;
@property(nonatomic, strong) SPTextFieldView *numbleTextV;
@property(nonatomic, strong) SPTextFieldView *addressTextV;
@property(nonatomic, strong) UILabel *tagLable;
/**
 *  上面已选标签视图
 */
@property(nonatomic, strong) SKTagView *tagTextFiled;
@property(nonatomic, strong) UIScrollView *selectedScrollView;
/**
 *  下面可选标签列表
 */
@property (nonatomic, strong) NSArray *selectedTagArr;
/**
 *  已选所有tag列表
 */
@property(nonatomic, strong) NSMutableArray *allTagArr;
/**
 *  输入tag列表
 */
@property (nonatomic, copy) NSArray* inputTag;

/**
 *  下面可选标签视图
 */
@property (nonatomic, strong) UIScrollView *allTagsScrollerV;
@property (nonatomic, strong) SKTagView    *allTagsView;

@end

@implementation AddPersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
<<<<<<< HEAD
    
=======
    self.title = @"新建联系人";
    [self addAllSubViews];
    
    __weak typeof(self) weakSelf = self;
    [weakSelf.selectedTagArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        JJTag *tag = [JJTag tagWithText:obj];
        [tag setSelected:[weakSelf.allTagArr containsObject:obj]];
        
        [self.allTagsView addTag:tag];
    }];

}

-(void)addAllSubViews{

    [self.view addSubview:self.avatorImageV];
    [self.view addSubview:self.nameTextV];
    [self.view addSubview:self.numbleTextV];
    [self.view addSubview:self.addressTextV];
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
    
    [self.tagLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressTextV.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
    }];
    
    [self.selectedScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLable.mas_bottom).offset(13.f);
        make.left.equalTo(self.view).offset(4);
        make.right.equalTo(self.view).offset(-4);
        make.height.mas_equalTo(100);
    }];
    
    CGFloat selectedMargin = 10;
    self.tagTextFiled.preferredMaxLayoutWidth = SCREEN_WIDTH - 20*2 - selectedMargin*2;
    [self.tagTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@(11));
//        make.left.equalTo(@(selectedMargin));
//        make.right.equalTo(@(self.tagTextFiled.preferredMaxLayoutWidth));
//        make.bottom.equalTo(@(11));
//        make.top.mas_equalTo(11);
//        make.left.mas_equalTo(11);
        make.top.equalTo(self.tagLable.mas_bottom).offset(10);
        make.left.equalTo(self.avatorImageV);
        make.right.equalTo(self.nameTextV);
        make.height.mas_equalTo(100);
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

-(UIImageView *)avatorImageV{

    if (!_avatorImageV) {
        _avatorImageV = [[UIImageView alloc]init];
        _avatorImageV.image = [UIImage imageNamed:@"default_head_man"];
    }
    return _avatorImageV;
}
-(SPTextFieldView *)nameTextV{

    if (!_nameTextV) {
        _nameTextV = [[SPTextFieldView alloc]init];
        _nameTextV.imageType = SPTextFieldImageNone;
        _nameTextV.textField.placeholder = @"姓名";
    }
    return _nameTextV;
}
-(SPTextFieldView *)numbleTextV{

    if (!_numbleTextV) {
        _numbleTextV = [[SPTextFieldView alloc]init];
        _numbleTextV.imageType = SPTextFieldImageNone;
        _numbleTextV.textField.placeholder = @"电话号码";
    }
    return _numbleTextV;
}
-(SPTextFieldView *)addressTextV{

    if (!_addressTextV) {
        _addressTextV = [[SPTextFieldView alloc]init];
        _addressTextV.imageType = SPTextFieldImageNone;
        _addressTextV.textField.placeholder = @"地址";
    }
    return _addressTextV;
>>>>>>> Bachelordomfly/master
}
-(UILabel *)tagLable{

    if (!_tagLable) {
        _tagLable = [[UILabel alloc]init];
        _tagLable.text = @"标签";
        _tagLable.textColor = [UIColor orangeColor];
        _tagLable.font = [UIFont systemFontOfSize:16];
    }
    return _tagLable;
}
-(SKTagView *)tagTextFiled{

    if (!_tagTextFiled) {
        _tagTextFiled = [[SKTagView alloc]init];
        _tagTextFiled.backgroundColor = [UIColor clearColor];
        _tagTextFiled.padding    = UIEdgeInsetsMake(5, 10, -5, -5);
        _tagTextFiled.insets    = 6;
        _tagTextFiled.lineSpace = lineSpace;
        [_tagTextFiled setEditable:@"手动输入标签"];
        _tagTextFiled.delegate = self;
        
        weakSelf(self);
//        Handle tag's click event
        _tagTextFiled.didClickTagAtIndex = ^(NSUInteger index){
            NSString *tag = [weakSelf.selectedTagArr objectAtIndex:index];
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
        _allTagsView.padding    = UIEdgeInsetsMake(0, 0, 0, 0);
        _allTagsView.insets    = 5;
        _allTagsView.lineSpace = 8;

        __weak typeof(self) weakSelf = self;
        //Handle tag's click event
        _allTagsView.didClickTagAtIndex = ^(NSUInteger index){
            NSString *tag = [weakSelf.selectedTagArr objectAtIndex:index];
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

-(NSArray *)selectedTagArr{

    if (!_selectedTagArr) {
        _selectedTagArr = [NSArray arrayWithObjects:@"逗比",@"书呆子",@"土豪",@"跟屁虫",@"大胸妹",@"大眼镜",@"小短腿",@"白富美",@"大帅哥",@"代码狗",@"百科全书",@"娘娘腔",@"女汉子",@"游戏王",@"男佣" ,nil];
    }
    return _selectedTagArr;
}

-(NSMutableArray *)allTagArr{

    if (!_allTagArr) {
        
        _allTagArr =[NSMutableArray array] ;
    }
    return _allTagArr;
}

-(NSArray *)inputTag{

    if (!_inputTag) {
        _inputTag = [NSArray array];
    }
    return _inputTag;
}
/*
 * 重新计算选中tag框的大小和滚动区域
 */
- (void)layoutSelectedScrollView:(BOOL)scroll {
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
- (void) didToggleTag:(NSString*)str scroll:(BOOL)scroll {
    __block BOOL isSelected = YES;
    weakSelf(self);
    [self.allTagArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if ([(NSString*)obj isEqualToString:str]) {
             isSelected = NO;

             [weakSelf.tagTextFiled removeTagAtIndex:idx];
             [weakSelf.allTagArr removeObjectAtIndex:idx];
             *stop = YES;
         }
     }];
    
    if (isSelected == YES) {
        
        [self.allTagArr addObject:str];
        
        JJTag *tag = [JJTag tagWithText:str];
        tag.textColor = UIColor.whiteColor;
        tag.bgColor = kColorMain;
        
        [self.tagTextFiled addTag:tag];
        
    }
    
    [self.allTagsView removeAllTags];
    

    [self.selectedTagArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        JJTag *tag = [JJTag tagWithText:obj];
        [tag setSelected:[weakSelf.allTagArr containsObject:obj]];
        [weakSelf.allTagsView addTag:tag];
    }];
    
    [self.allTagArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
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
        //此处尚未加入到selectedTagArr时,maxTagCount-1
//        if (self.selectedTagArr.count > maxTagCount-1){
//            [NCHitMessage showInfoWithMessage:[NSString stringWithFormat:@"最多只能选择%ld个领域", (long)maxTagCount]];
//            return;
//        }
        
        [self insertSelectedTag:self.tagTextFiled tagText:tagText atIndex:-1];
        [self.allTagArr addObject:tagText];
    }
    
    [self layoutSelectedScrollView:NO];
}


@end
