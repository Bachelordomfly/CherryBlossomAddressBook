//
//  ContacterDetailVC.m
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import "ContacterDetailVC.h"
#import "ContacterAvatarCell.h"
#import "ContacterDetailChangeVC.h"
#import "ContacterSexPopView.h"
#import "ImageScaleViewController.h"


@interface ContacterDetailVC ()
<
ContacterAvatarCellDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

/**
 *  联系人模型
 */
@property (nonatomic, strong) ContacterModel *contacterModel;

/**
 *  联系人信息标题
 */
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ContacterDetailVC

#pragma mark - init

- (instancetype)initWithContacterModel:(ContacterModel *)model
{
    if (self = [super init])
    {
        _contacterModel = model;
    }
    return self;
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"联系人详情";
    
    
}

#pragma mark - lazyload

- (NSArray *)titleArray
{
    if(!_titleArray)
    {
        _titleArray = [NSArray array];
        _titleArray = @[@[@"头像", @"姓名"],
                        @[@"备注名", @"性别"],
                        @[@"电话", @"地址"]];
    }
    return _titleArray;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = self.titleArray[section];
    return sectionArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*************** 头部 第0组 ******************/
    if(indexPath.section == ContacterSectionTypeTop)
    {
        //头像
        if(indexPath.row == 0)
        {
            static NSString *reuseID = @"HeaderCell";
            ContacterAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if(!cell)
            {
                cell = [[ContacterAvatarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
            }
            cell.delegate = self;
            [cell updateWithUserModel:_contacterModel];
            return cell;
        }
        else if (indexPath.row == 1)
        {
            static NSString *reuseID = @"NameCell";
            BaseSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if(!cell)
            {
                cell = [[BaseSimpleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
            }
            cell.position = BaseSimpleCellBGPositionBottom;
            cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
            cell.detailTextLabel.text = _contacterModel.name;
            return cell;
        }
    }
    /*************** 中间 第1组 ******************/
    else if(indexPath.section == ContacterSectionTypeMid)
    {
        //备注名
        if(indexPath.row == 0)
        {
            static NSString *reuseID = @"NickNameCell";
            BaseSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if(!cell)
            {
                cell = [[BaseSimpleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
            }
            cell.position = BaseSimpleCellBGPositionTop;
            cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
            NSLog(@"%@", _contacterModel.nickName);
            cell.detailTextLabel.text = [_contacterModel.nickName isEqualToString:@"(null)"] ? @"暂无" : _contacterModel.nickName;
            return cell;
        }
        //性别
        else if (indexPath.row == 1)
        {
            static NSString *reuseID = @"SexCell";
            BaseSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if(!cell)
            {
                cell = [[BaseSimpleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
            }
            cell.position = BaseSimpleCellBGPositionBottom;
            cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
            //非男即女
            NSString *sex = @"";
            switch (_contacterModel.sex) {
                case ABSexMan:
                    sex = @"男";
                    break;
                case ABSexWomen:
                    sex = @"女";
                    break;
                case ABSexUnknow:
                    sex = @"未知";
                    break;
                default:
                    break;
            }
            cell.detailTextLabel.text = sex;
            return cell;
        }
    }
    /*************** 底部 第2组 ******************/
    else if (indexPath.section == ContacterSectionTypeBottom)
    {
        //电话
        if(indexPath.row == 0)
        {
            static NSString *reuseID = @"PhoneCell";
            BaseSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if(!cell)
            {
                cell = [[BaseSimpleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
            }
            cell.position = BaseSimpleCellBGPositionTop;
            cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
            cell.detailTextLabel.text = _contacterModel.phone;
            return cell;
        }
        //地址
        else if (indexPath.row == 1)
        {
            static NSString *reuseID = @"AddressCell";
            BaseSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
            if (!cell)
            {
                cell = [[BaseSimpleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
            }
            cell.position = BaseSimpleCellBGPositionBottom;
            cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
            cell.detailTextLabel.text = _contacterModel.address.length > 0 ? _contacterModel.address : @"暂无信息";
            return cell;
        }
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == ContacterSectionTypeTop && indexPath.row == 0)
    {
        return [ContacterAvatarCell cellHeight];
    }
    else
    {
        return [BaseSimpleCell cellHeight];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == ContacterSectionTypeTop)
    {
        return 0.f;
    }
    else
    {
        return 14.f;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /************** 头 **************/
    if(indexPath.section == ContacterSectionTypeTop)
    {
        //头像
        if(indexPath.row == 0)
        {
            UIAlertController *changeAvatar = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self getPhotoWithSourceType:UIImagePickerControllerSourceTypeCamera];
            }];
            UIAlertAction *choosePhoto = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //判断是否支持相机
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    [self getPhotoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                }
                else
                {
                    [self getPhotoWithSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
                }
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [changeAvatar addAction:takePhoto];
            [changeAvatar addAction:choosePhoto];
            [changeAvatar addAction:cancel];
            [self presentViewController:changeAvatar animated:YES completion:nil];
            
        }
        //姓名
        else if (indexPath.row == 1)
        {
            [self cellIndexPath:indexPath ContacterDetailChangeType:ContacterDetailChangeName];
        }
    }
    /************** 中间 **************/
    else if(indexPath.section == ContacterSectionTypeMid)
    {
        //备注
        if(indexPath.row == 0)
        {
            [self cellIndexPath:indexPath ContacterDetailChangeType:ContacterDetailChangeNickName];
        }
        //性别
        else if (indexPath.row == 1)
        {
            ContacterSexPopView *sexPopView = [[ContacterSexPopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withABSex:_contacterModel.sex];
            [self.tableView addSubview:sexPopView];
        }
    }
    /************** 底部 **************/
    else if (indexPath.section == ContacterSectionTypeTop)
    {
        //电话
        if(indexPath.row == 0)
        {
            [self cellIndexPath:indexPath ContacterDetailChangeType:ContacterDetailChangePhone];
        }
        //地址
        else if(indexPath.row == 1)
        {
            [self cellIndexPath:indexPath ContacterDetailChangeType:ContacterDetailChangeAddress];
        }
    }
    //点击状态还原
    deselectRowWithTableView(tableView);
}
#pragma mark - UserProfileHeaderCellDelegate

- (void)didClickAvatarImageView:(UIImageView *)avatarImageView
{
    ImageScaleViewController *scaleVC = [[ImageScaleViewController alloc] initWithImageView:avatarImageView];
    [scaleVC setModalPresentationStyle:UIModalPresentationFullScreen];
    [scaleVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:scaleVC animated:YES completion:nil];
}

#pragma mark - 修改头像调用系统相机和系统相册

- (void)getPhotoWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = sourceType;
    imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate

/**
 *  获取照片
 *
 *  @param picker
 *  @param info
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType;      // an NSString (UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    __block UIImage *photoImg = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //此处存储照片
//    [self requestUploadImg:photoImg];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}
#pragma mark - 点击cell跳转封装方法
/**
 *  修改用户资料，点击不同cell跳转
 *
 *  @param indexPath  cell 的indexPath
 *  @param changeType cell 的种类
 */
- (void)cellIndexPath:(NSIndexPath *)indexPath ContacterDetailChangeType:(ContacterDetailChangeType)changeType
{
    ContacterDetailChangeVC *contacterChangeVC = [[ContacterDetailChangeVC alloc] initWithContacterModel:_contacterModel];
    
    //使用block给 ContacterDetailChangeVC 传值
    switch (changeType) {
        case ContacterDetailChangeName:
        {
            NSLog(@"%@", _contacterModel.name);
            [contacterChangeVC prepareCellTitle:self.titleArray[indexPath.section][indexPath.row] CellContentInfo:_contacterModel.name ContacterDetailChangeNameBlock:^(NSString *newNickName) {
            }];
        }
            break;
        case ContacterDetailChangeNickName:
        {
            [contacterChangeVC prepareCellTitle:self.titleArray[indexPath.section][indexPath.row] CellContentInfo:_contacterModel.nickName ContacterDetailChangeNameBlock:^(NSString *newName) {
            }];
        }
            break;
        case ContacterDetailChangePhone:
        {
            [contacterChangeVC prepareCellTitle:self.titleArray[indexPath.section][indexPath.row] CellContentInfo:_contacterModel.phone ContacterDetailChangePhoneBlock:^(NSString *newWeChatAccount) {
            }];
        }
            break;
        case ContacterDetailChangeAddress:
        {
            [contacterChangeVC prepareCellTitle:self.titleArray[indexPath.section][indexPath.row] CellContentInfo:_contacterModel.address ContacterDetailChangeAddressBlock:^(NSString *newStoreName) {
            }];
        }
        default:
            break;
    }
    
    [self.navigationController pushViewController:contacterChangeVC animated:YES];
}

#pragma mark - 保存修改

- (void)didClickSaveChange
{
    if ([[DataBaseManager shareInstanceDataBase] successOpenDataBaseType:ContacterDataBase])
    {
        
    }
}


@end


@interface ContacterAddressCell ()

@property (nonatomic, strong) ContacterModel *contacterModel;
@property (nonatomic, strong) UIView *line;
@end

/**
 *  详细备注cell
 */
@implementation ContacterAddressCell

+ (CGFloat)cellHeight
{
    return 140;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.remarkTV];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)updateWithContact:(ContacterModel *)contact
{
    _contacterModel = contact;
    [self.remarkTV setText:_contacterModel.address.length > 0 ? _contacterModel.address : @"暂无信息"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.remarkTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.mas_equalTo(self.contentView);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

- (UITextView *)remarkTV
{
    if(!_remarkTV)
    {
        _remarkTV = [[UITextView alloc] init];
        [_remarkTV setUserInteractionEnabled:NO];
        [_remarkTV setFont:[UIFont fontWithName:kDefaultRegularFontFamilyName size:16.0]];
        [_remarkTV setTextColor:kColorTextMain];
    }
    return _remarkTV;
}
- (UIView *)line
{
    if (!_line)
    {
        _line = [UIView new];
        _line.backgroundColor = [UIColor grayColor];
        _line.alpha = 0.3;
    }
    return _line;
}

@end














