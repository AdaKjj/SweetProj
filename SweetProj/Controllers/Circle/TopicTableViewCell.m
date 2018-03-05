//
//  TopicTableViewCell.m
//  SweetProj
//
//  Created by 殷婕 on 2017/12/20.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "TopicTableViewCell.h"
#import "ImageCollectionViewCell.h"

#define ONEPHOTOHEIGHT (SCREEN_WIDTH - 108 - 40)/3
#define TWOPHOTOHEIGHT (SCREEN_WIDTH - 108 - 40)/3*2 + 20
#define THREEPHOTOHEIGHT (SCREEN_WIDTH - 108 - 40) + 40
@interface TopicTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout> {
    NSArray *_onePhotoArr;
    NSArray *_fourPhotoArr;
}


@property (nonatomic) UIButton *addFriendBtn;
@property (nonatomic) UIButton *likeBtn;
@property (nonatomic) UIButton *collectionBtn;
@property (nonatomic) UIButton *reviewBtn;


@property (nonatomic) UICollectionView *photoCollectionView;




@property (nonatomic) int photoNum;
@property (nonatomic) float collectionViewHeight;

@end
@implementation TopicTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 照片数量
        if ((_photoNum - 1)/3 == 0) {
            _collectionViewHeight = ONEPHOTOHEIGHT;
        }
        else if ((_photoNum - 1)/3 == 1) {
            _collectionViewHeight = TWOPHOTOHEIGHT;
        }
        else if ((_photoNum - 1)/3 == 2) {
            _collectionViewHeight = THREEPHOTOHEIGHT;
        }
        
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.contentMode = UIViewContentModeScaleToFill;
        _avatarImageView.layer.cornerRadius = 22;
        [self.contentView addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(16);
            make.top.equalTo(20);
            make.height.width.equalTo(44);
        }];
        // 添加边框
        CALayer * layer = [_avatarImageView layer];
        layer.borderColor = RGB(181, 181, 181).CGColor;
        layer.borderWidth = 2.0f;
        
        _addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addFriendBtn setImage:[UIImage imageNamed:@"circle_add"] forState:UIControlStateNormal];
        [self.contentView addSubview:_addFriendBtn];
        [_addFriendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_avatarImageView.centerX);
            make.top.equalTo(_avatarImageView.mas_bottom).inset(15);
            make.width.height.equalTo(20);
        }];
        
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"circle_love"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"circle_loveSelected"] forState:UIControlStateSelected];
        [self.contentView addSubview:_likeBtn];
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_avatarImageView.centerX);
            make.top.equalTo(_addFriendBtn.mas_bottom).inset(10);
            make.width.height.equalTo(20);
        }];
        
        _collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionBtn setImage:[UIImage imageNamed:@"circle_star"] forState:UIControlStateNormal];
        [_collectionBtn setImage:[UIImage imageNamed:@"circle_starSelected"] forState:UIControlStateNormal];
        [self.contentView addSubview:_collectionBtn];
        [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_avatarImageView.centerX);
            make.top.equalTo(_likeBtn.mas_bottom).inset(10);
            make.width.height.equalTo(20);
        }];
        
        _reviewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reviewBtn setImage:[UIImage imageNamed:@"circle_review"] forState:UIControlStateNormal];
        [_reviewBtn setImage:[UIImage imageNamed:@"circle_reviewSelected"] forState:UIControlStateNormal];
        [self.contentView addSubview:_reviewBtn];
        [_reviewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_avatarImageView.centerX);
            make.top.equalTo(_collectionBtn.mas_bottom).inset(10);
            make.width.height.equalTo(20);
        }];
        
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.layer.masksToBounds = YES;
        _backgroundImageView.layer.cornerRadius = 20;
        [self.contentView addSubview:_backgroundImageView];
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(20);
            make.left.equalTo(_avatarImageView.mas_right).inset(16);
            make.right.equalTo(-16);
            make.bottom.equalTo(-10);
        }];
        
        CALayer * layer1 = [_backgroundImageView layer];
        layer1.borderColor = RGB(181, 181, 181).CGColor;
        layer1.borderWidth = 2.0f;
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        [_nameLabel setFont:BoldSystemFont(14)];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(40);
            make.left.equalTo(_backgroundImageView.left).inset(10);
            make.width.equalTo(80);
            make.height.equalTo(16);
        }];
        
        _levelLabel = [[UILabel alloc] init];
        _levelLabel.textColor = RGB(146, 186, 84);
        [_levelLabel setFont:systemFont(10)];
        _levelLabel.layer.cornerRadius = 6.;//边框圆角大小
        _levelLabel.textAlignment = NSTextAlignmentCenter;
        _levelLabel.layer.masksToBounds = YES;
        _levelLabel.layer.borderColor = RGB(146, 186, 84).CGColor;//边框颜色
        _levelLabel.layer.borderWidth = 1;//边框宽度
        [self.contentView addSubview:_levelLabel];
        [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameLabel.mas_right).inset(10);
            make.bottom.equalTo(_nameLabel.mas_bottom);
            make.height.equalTo(12);
            make.width.equalTo(35);
        }];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = RGB(181, 181, 181);
        [_timeLabel setFont:systemFont(10)];
        [self.contentView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_nameLabel.mas_bottom);
            make.right.equalTo(-10-20);
            make.height.equalTo(12);
            make.width.equalTo(25);
        }];
        
        UIFont *descTextFont = systemFont(14);
        CGSize size = CGSizeMake(0, 0);
        if (_descLabel.text != nil) {
            NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:_descLabel.text
                                                                                 attributes:@{NSFontAttributeName: descTextFont}];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){SCREEN_WIDTH - 108, CGFLOAT_MAX}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
            size = rect.size;
        }
        _descLabel = [[UILabel alloc] init];
        [_descLabel setFont:systemFont(14)];
        _descLabel.numberOfLines = 0;
        _descLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_backgroundImageView.left).inset(10);
            make.top.equalTo(_nameLabel.mas_bottom).equalTo(20);
            make.width.equalTo(SCREEN_WIDTH - 108);
        }];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.contentView addSubview:_photoCollectionView];
        _photoCollectionView.showsHorizontalScrollIndicator = NO;
        _photoCollectionView.backgroundColor = [UIColor whiteColor];
        [_photoCollectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"photoCell"];
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        [_photoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_descLabel.mas_bottom).inset(20);
            make.left.equalTo(_backgroundImageView.left).inset(10);
            make.right.equalTo(-10-16);
            ///////
            make.height.equalTo(ONEPHOTOHEIGHT);
        }];
        
        _locBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locBtn setImage:[UIImage imageNamed:@"circle_loc"] forState:UIControlStateNormal];
        [_locBtn.titleLabel setFont:systemFont(10)];
        [_locBtn.titleLabel setTextColor:RGB(181, 181, 181)];
        [self.contentView addSubview:_locBtn];
        [_locBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_photoCollectionView.mas_bottom).inset(5);
            make.left.equalTo(_backgroundImageView.left).inset(10);
            make.height.equalTo(18);
            make.width.equalTo(15);
        }];
        
        _likeCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeCountBtn setImage:[UIImage imageNamed:@"circle_likeCount"] forState:UIControlStateNormal];
        [_likeCountBtn.titleLabel setFont:systemFont(10)];
        [_likeCountBtn.titleLabel setTextColor:RGB(181, 181, 181)];
        [self.contentView addSubview:_likeCountBtn];
        [_likeCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_photoCollectionView.mas_bottom).inset(5);
            make.right.equalTo(-10-40);
            make.height.equalTo(18);
            make.width.equalTo(18);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ONEPHOTOHEIGHT, ONEPHOTOHEIGHT);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    /////
    cell.photoImageView.image = [UIImage imageNamed:@"text1"];
    return cell;
}

//TODO: 点击查看大图
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

// Section中每个Cell的上下边距
- (CGFloat)collectionView: (UICollectionView *)collectionView layout: (UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex: (NSInteger)section{
    return 20.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 20.0f;
}

@end
