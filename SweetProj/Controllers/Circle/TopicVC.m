//
//  TopicVC.m
//  SweetProj
//
//  Created by 殷婕 on 2017/11/29.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "TopicVC.h"
#import "UIImage+Addition.h"
#import "TopicTableViewCell.h"

@interface TopicVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UIImageView *avatarImageView;

@property (nonatomic) UIButton *friendsBtn;
@property (nonatomic) UIButton *todayBtn;
@property (nonatomic) UIButton *circleBtn;

@property (nonatomic) UITableView *photoTableView;

@property (nonatomic) int textHeight;

@end

@implementation TopicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _avatarImageView = [[UIImageView alloc]init];
    _avatarImageView.backgroundColor = [UIColor grayColor];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 22.0;
    [self.view addSubview:_avatarImageView];
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-25);
        make.top.equalTo(25);
        make.height.width.equalTo(44);
    }];
    
    // 添加边框
    CALayer * layer = [_avatarImageView layer];
    layer.borderColor = RGB(173, 173, 173).CGColor;
    layer.borderWidth = 2.0f;
    
    _friendsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _friendsBtn.selected = YES;
    _friendsBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [_friendsBtn setTitle:@"朋友" forState:UIControlStateNormal];
    [_friendsBtn.titleLabel setFont:systemFont(20)];
    [_friendsBtn setTitleColor:RGB(173, 173, 173) forState:UIControlStateNormal];
    [_friendsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_friendsBtn addTarget:self action:@selector(friendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_friendsBtn];
    [_friendsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(30);
        make.left.equalTo(25);
        make.width.equalTo(40);
        make.height.equalTo(25);
    }];
    
    _todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _todayBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [_todayBtn setTitle:@"今日" forState:UIControlStateNormal];
    [_todayBtn.titleLabel setFont:systemFont(20)];
    [_todayBtn setTitleColor:RGB(173, 173, 173) forState:UIControlStateNormal];
    [_todayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_todayBtn addTarget:self action:@selector(todayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_todayBtn];
    [_todayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(30);
        make.left.equalTo(_friendsBtn.right).inset(15);
        make.width.equalTo(40);
        make.height.equalTo(25);
    }];
    
    _circleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _circleBtn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [_circleBtn setTitle:@"广场" forState:UIControlStateNormal];
    [_circleBtn.titleLabel setFont:systemFont(20)];
    [_circleBtn setTitleColor:RGB(173, 173, 173) forState:UIControlStateNormal];
    [_circleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_circleBtn addTarget:self action:@selector(circleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_circleBtn];
    [_circleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(30);
        make.left.equalTo(_todayBtn.right).equalTo(15);
        make.width.equalTo(40);
        make.height.equalTo(25);
    }];
    
    UIImage *lingImage = [UIImage imageWithColor:RGB(173, 173, 173) size:CGSizeMake(SCREEN_WIDTH - 50, 3.0)];
    UIImageView *lineImageView = [[UIImageView alloc]initWithImage:lingImage];
    [self.view addSubview:lineImageView];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatarImageView.bottom).inset(10);
        make.left.equalTo(20);
        make.height.equalTo(3);
        make.width.equalTo(SCREEN_WIDTH - 40);
    }];
    
    self.photoTableView = [[UITableView alloc] init];
    self.photoTableView.dataSource = self;
    self.photoTableView.delegate = self;
    [self.photoTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview: self.photoTableView];
    [self.photoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineImageView.mas_bottom);
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)friendBtnClick {
    _friendsBtn.selected = YES;
    _todayBtn.selected = NO;
    _circleBtn.selected = NO;
}

- (void)todayBtnClick {
    _friendsBtn.selected = NO;
    _todayBtn.selected = YES;
    _circleBtn.selected = NO;
}

- (void)circleBtnClick {
    _friendsBtn.selected = NO;
    _todayBtn.selected = NO;
    _circleBtn.selected = YES;
}

- (void)setupSearchBar
{
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH - 70,40)];
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0,2,SCREEN_WIDTH - 70,35);
    searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    //边框线粗细
    [searchBar.layer setBorderWidth:8];
    //设置边框为白色是为了盖住UISearchBar上的灰色
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    searchBar.placeholder = @"在Sweet上搜索";
    [titleView addSubview:searchBar];
    self.navigationItem.titleView = titleView;
}

#pragma tableViewDelegate
// 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //分区设置为1m
    return 1;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

//配置特定行中的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    TopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[TopicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.avatarImageView.image = [UIImage imageNamed:@"text2"];
        
        cell.descLabel.text = @"哈哈哈哈哈哈哈啊哈哈哈哈啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊";
        UIFont *descTextFont = systemFont(14);
        CGSize size = CGSizeMake(0, 0);
        if (cell.descLabel.text != nil) {
            NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:cell.descLabel.text
                                                                                 attributes:@{NSFontAttributeName: descTextFont}];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){SCREEN_WIDTH - 108, CGFLOAT_MAX}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
            size = rect.size;
            self.textHeight = size.height;
            cell.descLabel.frame = rect;
        }
        
        cell.nameLabel.text = @"这是名字";
        cell.levelLabel.text = @"LV 10";
        cell.timeLabel.text = @"11:10";
        [cell.locBtn.titleLabel setText:@"大连市"];
        [cell.likeCountBtn.titleLabel setText:@"100"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = @"哈哈哈哈哈哈哈啊哈哈哈哈啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊";
    UIFont *descTextFont = systemFont(14);
    CGSize size = CGSizeMake(0, 0);
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                             attributes:@{NSFontAttributeName: descTextFont}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){SCREEN_WIDTH - 108, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        size = rect.size;
    CGFloat imageheght = (SCREEN_WIDTH - 108 - 40)/3;
    CGFloat height = 20 + 20 + 16 + 20 + size.height + imageheght + 5 + 18 + 5 + 10+20;
    return height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selected = NO;
}

@end
