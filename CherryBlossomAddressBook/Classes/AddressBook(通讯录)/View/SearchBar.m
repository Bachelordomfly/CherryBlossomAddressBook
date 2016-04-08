//
//  GoodsSearchBar.m
//  Penkr
//
//  Created by RenSihao on 16/3/10.
//  Copyright © 2016年 ShopEX. All rights reserved.
//

#import "SearchBar.h"

@interface SearchBar ()
<
UITextFieldDelegate
>

@property (nonatomic, strong) UIButton        *cancelBtn;       //取消按钮
@end

@implementation SearchBar

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addAllSubViews];
        //监听字数限制 (避免emoji和中英文切换 crash)
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(textFiledEditChanged:)
                                                    name:@"UITextFieldTextDidChangeNotification"
                                                  object:self.searchTextField];
        
        
    }
    return self;
}

#pragma mark - private method

- (void)addAllSubViews
{
    [self addSubview:self.searchTextField];
    [self addSubview:self.cancelBtn];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //自定义搜索框
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(5);;
        make.right.mas_equalTo(self).offset(-44);
        make.bottom.mas_equalTo(self).offset(-5);
    }];

    //取消按钮
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-15);
        make.right.mas_equalTo(self).offset(-4);
        make.width.mas_equalTo(34);
        make.height.mas_equalTo(17);
    }];
}

#pragma mark - lazy load

- (CustomTextField *)searchTextField
{
    if (!_searchTextField)
    {
        _searchTextField = [[CustomTextField alloc] init];
        _searchTextField.delegate = self;
        [_searchTextField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchTextField;
}
- (UIButton *)cancelBtn
{
    if (!_cancelBtn)
    {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn.titleLabel setFont:[UIFont fontWithName:kDefaultRegularFontFamilyName size:17.f]];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIColorFromRGB_0x(0xFFFFFF) forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.contentEdgeInsets = UIEdgeInsetsZero;
        _cancelBtn.titleEdgeInsets = UIEdgeInsetsZero;
        [_cancelBtn sizeToFit];
    }
    return _cancelBtn;
}

#pragma mark - 监听点击取消

- (void)clickCancel:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarDidClickCancel:)])
    {
        [self.delegate searchBarDidClickCancel:self];
    }
}

#pragma mark - UITextFieldDelegate

//实时回调 输入搜索字符变化
- (void)textfieldDidChange:(UITextField *)textField
{   //无法输入空字符串
    NSString *lTmp = [NSString stringWithFormat:@"%s"," "];
    textField.text = [textField.text stringByReplacingOccurrencesOfString:lTmp withString:@""];
    
    if ([self.delegate respondsToSelector:@selector(searchBar:searchText:)])
    {
        [self.delegate searchBar:self searchText:textField.text];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    NSLog(@"%s", __func__);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
{
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{
    NSLog(@"%s", __func__);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField               // called when clear button pressed. return NO to ignore (no notifications)
{
    return YES;
}
//回调 点击搜索按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%s", __func__);
    if (textField.text.length > 0 && [self.delegate respondsToSelector:@selector(searchBar:didClickSearchText:)])
    {
        [self.delegate searchBar:self didClickSearchText:textField.text];
        return YES;
    }
    else
        return NO;
}

#pragma  mark - 通知监听字数限制

-(void)textFiledEditChanged:(NSNotification *)obj
{
    CustomTextField *textField = (CustomTextField *)obj.object;
    
    //目标字符
    NSString *toBeString = textField.text;
    
    //键盘输入模式
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    
    //简体中文输入
    if ([lang isEqualToString:@"zh-Hans"])
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position || !selectedRange)
        {
            if (toBeString.length > 30)
            {
                textField.text = [toBeString substringToIndex:30];
                [SVProgressHUD showErrorWithStatus:@"不得超过30字"];
            }
        }
    }
    //非简体中文
    else
    {
        if (toBeString.length > 30)
        {
            [SVProgressHUD showErrorWithStatus:@"不得超过30字"];
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:30];
            
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:30];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 30)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

@end



@implementation CustomTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //设置相应属性
        self.clearButtonMode = UITextFieldViewModeWhileEditing;//显示清除按钮
        self.placeholder = @"搜索";
        self.layer.cornerRadius = 4.f;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.1;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.backgroundColor = [UIColor whiteColor];
        self.keyboardType = UIKeyboardTypeDefault;
        self.returnKeyType = UIReturnKeySearch;
        self.tintColor = self.textColor;
        [self becomeFirstResponder];
        
        //放大镜图标
        UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
        leftImageView.contentMode = UIViewContentModeLeft;
        leftImageView.layer.masksToBounds = YES;
        self.leftView = leftImageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //输入字体、颜色
//        self.textColor = UIColorFromRGB_0x(0x333333);
//        self.font = [UIFont fontWithName:kDefaultFontFamilyName size:16.f];
        
        //placeholder字体、颜色
        [self setValue:UIColorFromRGB_0x(0xBFBFBF) forKeyPath:@"_placeholderLabel.textColor"];
        [self setValue:[UIFont fontWithName:kDefaultRegularFontFamilyName size:16.f] forKeyPath:@"_placeholderLabel.font"];
    }
    return self;
}
////设置placeholder
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [UIColorFromRGB_0x(0xBFBFBF) setFill];
//    [[self placeholder] drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont fontWithName:kDefaultFontFamilyName size:16.f]}];
//}
//设置text
- (void)drawTextInRect:(CGRect)rect
{
    [UIColorFromRGB_0x(0x333333) setFill];
    [[self text] drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont fontWithName:kDefaultRegularFontFamilyName size:16.f]}];
}
//设置可编辑区域
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    bounds.origin.x = 40;
    bounds.size.width = bounds.size.width - 50;
    return bounds;
}
//设置placeholder区域
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    bounds.origin.x = 40;
    bounds.origin.y = self.centerY - bounds.size.height/2.0-3;
    return bounds;
}
//设置leftView区域
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    bounds.origin.x = 10;
    bounds.origin.y = 7.5;
    bounds.size.width = 20;
    bounds.size.height = 20;
    return bounds;
}

- (CGRect)textRectForBounds:(CGRect)bounds{
    bounds.origin.x = 40;
    bounds.origin.y = self.centerY - bounds.size.height/2.0+3;
    return bounds;
}

@end


