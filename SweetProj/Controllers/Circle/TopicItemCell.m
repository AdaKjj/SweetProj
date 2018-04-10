//
//  TopicItemCell.m
//  SweetProj
//
//  Created by 殷婕 on 2018/4/10.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "TopicItemCell.h"
#import <YYKit/YYLabel.h>
#import "UIButton+EdgeInsets.h"
#import "UIImage+Addition.h"

#define UIScreenWidth   [UIScreen mainScreen].bounds.size.width
#define UIScreenHeight  [UIScreen mainScreen].bounds.size.height
#define LayoutWidth     (UIScreenWidth - margin*2 - 40 - 10*2 - 10)
#define ButtonWidth            LayoutWidth / 4.0f
#define Others_ButtonWidth     LayoutWidth / 3.0f

@interface TopicItemCell ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UIImageView *bgImageView;

@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UILabel *levelLabel;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UIButton *followBtn;
@property (nonatomic) YYLabel *contentLabel;

@property (nonatomic) UICollectionView *imageCollectionView;

@property (nonatomic) UIButton *likeBtn;
@property (nonatomic) UILabel *likeCountLabel;
@property (nonatomic) UIButton *locBtn;
@property (nonatomic) UIButton *commentBtn;

@end

static CGFloat margin = 20.f;
static CGFloat height_margin = 3.0f;
@implementation TopicItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI
{
    //self.contentView.backgroundColor = CTRandomColor;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _bgImageView = [[UIImageView alloc] init];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.layer.masksToBounds = YES;
    _bgImageView.layer.cornerRadius = 5.0;
    _bgImageView.image = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    _bgImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bgImageView.layer.shadowOffset = CGSizeMake(0, 10);
    _bgImageView.layer.shadowOpacity = 0.8;
    _bgImageView.layer.shadowRadius = 8;
    _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _avatarImageView = [[UIImageView alloc] init];
    _avatarImageView.image = [UIImage imageNamed:@"头像"];
    _avatarImageView.userInteractionEnabled = YES;
    _avatarImageView.layer.cornerRadius = 20.0;
    _avatarImageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapUserImage:)];
    [_avatarImageView addGestureRecognizer:tap];
    
    _levelLabel = [UILabel new];
    _levelLabel.textAlignment = NSTextAlignmentCenter;
    _levelLabel.font = systemFont(14);
    _levelLabel.textColor = SYSTEMCOLOR;
    _levelLabel.layer.masksToBounds = YES;
    _levelLabel.layer.cornerRadius = 8;
    _levelLabel.layer.borderColor = SYSTEMCOLOR.CGColor;
    _levelLabel.layer.borderWidth = 1;
    _levelLabel.text = @"lv.11";
    
    _nameLabel = [UILabel new];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = systemFont(16);
    _nameLabel.textColor = __RGB_75;
    [_nameLabel sizeToFit];
    
    _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_followBtn setTitle:@"关注" forState:UIControlStateNormal];
    [_followBtn setTitleColor:SYSTEMCOLOR forState:UIControlStateNormal];
    [_followBtn.titleLabel setFont:systemFont(14)];
    _followBtn.layer.masksToBounds = YES;
    _followBtn.layer.cornerRadius = 8;
    _followBtn.layer.borderColor = SYSTEMCOLOR.CGColor;
    _followBtn.layer.borderWidth = 1;
    
    _timeLabel = [UILabel new];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = systemFont(12);
    _timeLabel.textColor = __RGB_160;
    [_timeLabel sizeToFit];
    
    _contentLabel = [YYLabel new];
    _contentLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _contentLabel.displaysAsynchronously = YES;
    _contentLabel.ignoreCommonProperties = YES;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.fadeOnHighlight = NO;
    _contentLabel.fadeOnAsynchronouslyDisplay = NO;
    _contentLabel.numberOfLines = 0;
    _contentLabel.preferredMaxLayoutWidth = LayoutWidth;
    _contentLabel.textColor = __RGB_75;
    _contentLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
    };
    
    UIEdgeInsets sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 4;
    layout.minimumLineSpacing = 4;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = sectionInset;
    
    _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _imageCollectionView.backgroundColor = [UIColor whiteColor];
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    _imageCollectionView.alwaysBounceHorizontal = NO;
    _imageCollectionView.alwaysBounceVertical = YES;
    _imageCollectionView.showsHorizontalScrollIndicator = NO;
    _imageCollectionView.showsVerticalScrollIndicator = NO;
    _imageCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -2);
    //_imageCollectionView.contentSize = CGSizeMake(self.view.viewWidth, ((_albumModel.count + 3) / 4) * self.view.viewWidth);
    
    [_imageCollectionView registerClass:[PhotoImageCell class] forCellWithReuseIdentifier:@"PhotoImageCell"];
    
    _likeBtn = [[UIButton alloc] init];
    [_likeBtn setImage:[UIImage imageNamed:@"circle_praise"] forState:UIControlStateNormal];
    [_likeBtn setImage:[UIImage imageNamed:@"circle_praiseSelected"] forState:UIControlStateSelected];
    [_likeBtn addTarget:self action:@selector(onTouchLike) forControlEvents:UIControlEventTouchUpInside];
    
    _likeCountLabel = [UILabel new];
    _likeCountLabel.textAlignment = NSTextAlignmentCenter;
    _likeCountLabel.font = systemFont(12);
    _likeCountLabel.textColor = [UIColor whiteColor];
    _likeCountLabel.layer.masksToBounds = YES;
    _likeCountLabel.layer.cornerRadius = 14;
    
    _commentBtn = [[UIButton alloc] init];
    [_commentBtn setImage:[UIImage imageNamed:@"circle_review"] forState:UIControlStateNormal];
    [_commentBtn setImage:[UIImage imageNamed:@"circle_reviewSelected"] forState:UIControlStateSelected];
    [_commentBtn addTarget:self action:@selector(onTouchComment) forControlEvents:UIControlEventTouchUpInside];
    
    
    _locBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locBtn setImage:[UIImage imageNamed:@"circle_loc"] forState:UIControlStateNormal];
    [_locBtn setTitle:@"商户位置" forState:UIControlStateNormal];
    [_locBtn setTitleColor:__RGB_160 forState:UIControlStateNormal];
    [_locBtn.titleLabel setFont:systemFont(14)];
    _locBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_locBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:3];
    _locBtn.userInteractionEnabled = NO;
    [_locBtn sizeToFit];
    
    
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.avatarImageView];
    [self.bgImageView addSubview:self.levelLabel];
    [self.bgImageView addSubview:self.nameLabel];
    [self.bgImageView addSubview:self.timeLabel];
    [self.bgImageView addSubview:self.followBtn];
    [self.bgImageView addSubview:self.contentLabel];
    [self.bgImageView addSubview:self.imageCollectionView];
    [self.bgImageView addSubview:self.likeBtn];
    [self.bgImageView addSubview:self.likeCountLabel];
    [self.bgImageView addSubview:self.locBtn];
    [self.bgImageView addSubview:self.commentBtn];
    
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(10);
        make.bottom.equalTo(-10);
        make.right.equalTo(-10);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(margin);
        make.left.mas_equalTo(margin);
        make.width.and.height.equalTo(40);
    }];
    
    
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.avatarImageView);
        make.top.mas_equalTo(self.avatarImageView.mas_bottom);
        make.width.equalTo(40);
        make.height.equalTo(16);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(10);
        make.right.mas_equalTo(self.followBtn.mas_left);
        make.top.mas_equalTo(self.avatarImageView);
        make.height.equalTo(18);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel);
        make.width.equalTo(150);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        make.height.equalTo(14);
    }];
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-margin);
        make.width.equalTo(30);
        make.centerY.mas_equalTo(self.nameLabel);
        make.height.equalTo(16);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.levelLabel.mas_bottom).offset(3);
        make.leading.mas_equalTo(self.nameLabel);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(0).priorityLow();
    }];
    
    [self.imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.nameLabel);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(0).priorityLow();
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-20);
        make.centerX.mas_equalTo(self.avatarImageView);
        make.width.and.height.mas_equalTo(35);
    }];
    
    [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.likeBtn.mas_bottom).equalTo(3);
        make.width.and.height.mas_equalTo(28);
        make.centerX.mas_equalTo(self.likeBtn);
    }];
    
    [self.locBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(16);
        make.bottom.equalTo(-4);
        make.leading.mas_equalTo(self.nameLabel);
        make.right.mas_equalTo(self.commentBtn.mas_left);
    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(16);
        make.bottom.equalTo(-4);
        make.width.mas_equalTo(20);
    }];
}

- (void)setCircleItem:(CircleItem *)circleItem {
    _circleItem = circleItem;
    
    //TODO: avatarImage
    //TODO: 还没有头像和等级
    self.nameLabel.text = circleItem.nikcname;
    self.timeLabel.text = circleItem.createTime;
    
    YYTextContainer *container2 = [YYTextContainer containerWithSize:CGSizeMake(LayoutWidth, CGFLOAT_MAX)];
    
    NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc]         initWithString:circleItem.content attributes:@{NSFontAttributeName:self.contentLabel.font, NSForegroundColorAttributeName:self.contentLabel.textColor,NSKernAttributeName:@1.5f}];
    
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle2 setLineSpacing:5.0];
    [attributeString2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [circleItem.content length])];
    
    YYTextLayout *layout2 = [YYTextLayout layoutWithContainer:container2 text:attributeString2];
    
    self.contentLabel.textLayout = layout2;
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(layout2.textBoundingSize.height);
    }];
    
    if (circleItem.photoUrl.count == 0) {
        [self.imageCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityMedium();
            make.bottom.mas_equalTo(self.contentLabel).priorityMedium();
        }];
    }
    else {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.imageCollectionView.collectionViewLayout;
        UIEdgeInsets edgeInset = layout.sectionInset;
        
        CGFloat numberInLine = floor((circleItem.photoUrl.count - 1)/3.0) + 1;
        CGFloat numberInRow = 0.0;
        switch (circleItem.photoUrl.count) {
            case 1:numberInRow = 1;
                break;
            case 2:numberInRow = 2;
                break;
            case 3:numberInRow = 3;
                break;
            case 4:numberInRow = 2;
                break;
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:numberInRow = 3;
                break;
            default:
                break;
        }
        
        CGFloat itemWidth;
        if (circleItem.photoUrl.count == 1)
            itemWidth = LayoutWidth - edgeInset.left - edgeInset.right;
        else
            itemWidth = (LayoutWidth - edgeInset.left - edgeInset.right - (numberInRow-1) * layout.minimumInteritemSpacing)/numberInRow;
        
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        
        CGFloat height = floor(itemWidth + edgeInset.top + edgeInset.bottom + (numberInLine -1)*layout.minimumInteritemSpacing);
        
        [self.imageCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height).priorityMedium();
        }];
        
        [self.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-10).priorityMedium();
        }];
        
        [self.imageCollectionView reloadData];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.nameLabel.text = self.circleItem.nikcname;
    self.timeLabel.text = self.circleItem.createTime;
    
    YYTextContainer *container2 = [YYTextContainer containerWithSize:CGSizeMake(LayoutWidth, CGFLOAT_MAX)];
    
    NSString *contentString = self.circleItem.content;
    if (!contentString) {
        contentString = @"";
    }
    
    NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc]         initWithString:contentString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:self.contentLabel.textColor,NSKernAttributeName:@1.5f}];
    
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle2 setLineSpacing:5.0];
    [attributeString2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [contentString length])];
    
    YYTextLayout *layout2 = [YYTextLayout layoutWithContainer:container2 text:attributeString2];
    
    self.contentLabel.textLayout = layout2;
    
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(layout2.textBoundingSize.height);
    }];
    
    if (self.circleItem.photoUrl.count == 0) {
        [self.imageCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priorityMedium();
            make.bottom.mas_equalTo(self.contentLabel).priorityMedium();
        }];
    }
    else {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.imageCollectionView.collectionViewLayout;
        UIEdgeInsets edgeInset = layout.sectionInset;
        
        CGFloat numberInLine = floor((self.circleItem.photoUrl.count - 1)/3.0) + 1;
        CGFloat numberInRow = 0.0;
        switch (self.circleItem.photoUrl.count) {
            case 1:numberInRow = 1;
                break;
            case 2:numberInRow = 2;
                break;
            case 3:numberInRow = 3;
                break;
            case 4:numberInRow = 2;
                break;
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:numberInRow = 3;
                break;
            default:
                break;
        }
        
        CGFloat itemWidth;
        if (self.circleItem.photoUrl.count == 1)
            itemWidth = LayoutWidth - edgeInset.left - edgeInset.right;
        else
            itemWidth = (LayoutWidth - edgeInset.left - edgeInset.right - (numberInRow-1) * layout.minimumInteritemSpacing)/numberInRow;
        
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        
        CGFloat height = floor(itemWidth + edgeInset.top + edgeInset.bottom + (numberInLine -1)*layout.minimumInteritemSpacing);
        
        [self.imageCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height).priorityMedium();
        }];
        
        [self.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-10).priorityMedium();
        }];
        
        [self.imageCollectionView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.circleItem.photoUrl.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoImageCell" forIndexPath:indexPath];
    [cell setImage:self.circleItem.photoUrl[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (self.photosVC) {
//        [self.photosVC dismissViewControllerAnimated:NO completion:^{
//
//        }];
//        self.photosVC = nil;
//        return;
//    }
//
//    NSMutableArray *items = @[].mutableCopy;
//    for (int i = 0; i < self.modal.postInfo.postPhotosArray_Count; i++) {
//        PhotoImageCell *cell = (PhotoImageCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        CTPostPhotoProto *photo = self.modal.postInfo.postPhotosArray[i];
//        KSPhotoItem *item = [KSPhotoItem itemWithSourceView:cell.photoImageView imageUrl:photo.photoFileName];
//        [items addObject:item];
//    }
//
//    PostPhotosDetailVC *browser = [[PostPhotosDetailVC alloc] initWithPhotoItems:items selectedIndex:indexPath.row];
//
//    browser.delegate = self;
//    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleScale;
//    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlurPhoto;
//    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleDeterminate;
//    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleDot;
//    browser.bounces = NO;
//    browser.photoInfo = self.modal.postInfo;
//
//    browser.isSelfID = self.isSelfID;
//    browser.deletePhotoBlock = ^(BOOL isLastPhoto, NSInteger deleteIndex) {
//        if (isLastPhoto) {
//            [self.delegate didDeletePenyouquanCell:self];
//        }
//        else {
//            [self.imageCollectionView performBatchUpdates:^{
//                [self.modal.postInfo.postPhotosArray removeObjectAtIndex:deleteIndex];
//                [self.imageCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:deleteIndex inSection:0]]];
//                if (self.modal.postInfo.postPhotosArray.count < 4) {
//
//                    self.imageCollectionView.alwaysBounceHorizontal = self.modal.postInfo.postPhotosArray.count > 2;
//
//                    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.imageCollectionView.collectionViewLayout;
//                    UIEdgeInsets edgeInset = layout.sectionInset;
//
//                    CGFloat numberInRow = self.modal.postInfo.postPhotosArray.count <= 2 ? 2 : 2.5;
//                    CGFloat itemWidth = (FULL_WIDTH - margin*2 - edgeInset.left - edgeInset.right - (numberInRow-1) * layout.minimumInteritemSpacing)/numberInRow;
//                    itemWidth = floor(itemWidth);
//
//                    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
//
//                    CGFloat height = floor(itemWidth + edgeInset.top + edgeInset.bottom);
//
//                    [self.imageCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.height.mas_equalTo(height).priorityMedium();
//                    }];
//
//                    [self.imageCollectionView reloadData];
//                    [self.delegate PenyouquanCellItemDidDelete];
//                }
//            } completion:^(BOOL finished) {
//
//            }];
//        }
//    };
//
//
//    UINavigationController *nav = (UINavigationController *)[self.delegate viewControllerForshowPhotoPreview];
//    [browser showFromViewController:nav];
//
//    [self sendFeedbackOfPhoto:self.modal.postInfo];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



@implementation PhotoImageCell
- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.userInteractionEnabled = NO;
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.contentView addSubview:_photoImageView];
        
        [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setImage:(NSString *)photoUrl
{
//    [self.photoImageView cancelCurrentImageRequest];
//    
//    NSString *tmp = [photoInfo.photoFileName stringWithXOssProcess:@"image/resize,m_lfit,h_500,w_500"];
//    
//    [self.photoImageView ct_setImageWithURL:tmp
//                                placeholder:[UIImage imageNamed:@"defaultImage"]
//                                    options:kNilOptions //CTOssImageOptionIgnoreDiskCache
//                                 completion:nil];
}
@end

