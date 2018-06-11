//
//  PersonalSettingsVC.m
//  SweetProj
//
//  Created by 殷婕 on 2017/12/19.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "PersonalSettingsVC.h"
#import "UIImage+Addition.h"
#import "TableViewCellItem.h"
#import "UITableViewCell+seperatorInset.h"
#import "LoginVC.h"

@interface PersonalSettingsVC () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *_itemArr;
}

@property (nonatomic) UITableView *tableView;
@end

@implementation PersonalSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
   // self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"个人信息";

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"username"]) {
        [self setupLogoutBtn];
    }
    
    UIImage *backBarImage = [UIImage imageNamed:@"backBarBtnClicked"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:backBarImage
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(backBtnPressed)];
    self.navigationItem.leftBarButtonItem = item;
    
    [self loadDataSource];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = TABLE_BACKGROUND_COLOR;
    _tableView.rowHeight       = 50.0f;
    _tableView.sectionHeaderHeight = TABLE_SECTION_HEADER_HEIGHT;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor  = CELL_SEPARATOR_COLOR;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(0);
    }];
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    //导航栏颜色
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttrs];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    
    //状态栏颜色
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    //[UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
}

- (void)setupLogoutBtn {
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(settingsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(40);
        make.width.height.equalTo(80);
    }];
}

- (void)loadDataSource
{
    TableViewCellItem *avatarCellItem = [[TableViewCellItem alloc] initWithTitle:@"头像"];
    
    TableViewCellItem *nameCellItem = [[TableViewCellItem alloc] initWithTitle:@"昵称"];
    TableViewCellItem *accountCellItem = [[TableViewCellItem alloc] initWithTitle:@"用户ID"];
    TableViewCellItem *birthdayCellItem = [[TableViewCellItem alloc] initWithTitle:@"生日"];
    TableViewCellItem *logoutCellItem = [[TableViewCellItem alloc] initWithTitle:@"退出登录"];
    
    NSArray *section1 = @[avatarCellItem];
    NSArray *section2 = @[nameCellItem, accountCellItem, birthdayCellItem];
    NSArray *section3 = @[logoutCellItem];
    _itemArr = [NSArray arrayWithObjects:section1, section2, section3, nil];
}

// 退出登录
- (void)settingsButtonPressed {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"username"];
    [userDefaults removeObjectForKey:@"password"];
    [userDefaults synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backBtnPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _itemArr.count;
}

// cell分区分段
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)_itemArr[section] count];
}

//配置特定行中的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCellItem *cellItem = _itemArr[indexPath.section][indexPath.row];
    
    UITableViewCell * cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = cellItem.title;
    
    if ([cellItem.title isEqualToString:@"头像"]) {
        [cell showCustomAccessoryView];
        const NSInteger ImageRightMargin = 35;
        const NSInteger ImageTopMargin = 12;
        
        CGFloat cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
        
        CGFloat imageHeight = cellHeight-2*ImageTopMargin;
        
        CGRect frame = CGRectMake(SCREEN_WIDTH-imageHeight-ImageRightMargin, ImageTopMargin, imageHeight, imageHeight);
        
        self.avatarView = [[UIImageView alloc] initWithFrame:frame];
        self.avatarView.userInteractionEnabled = YES;
        self.avatarView.contentMode = UIViewContentModeScaleAspectFit;
        //[imageView roundedCornerAndBorderView];
        self.avatarView.layer.cornerRadius = CGRectGetHeight(frame)/2.0;
        self.avatarView.layer.masksToBounds = YES;
        [cell.contentView addSubview:self.avatarView];
        
        self.avatarView.image = [UIImage imageNamed:@"text1"];
//        [TheUserModule.currentUser updateAvatarImage:self.avatarView];
//
//        // 如果有大图头像，显示大图
//        if ([TheUserModule.currentUser hasAvatarImageOfThumb:NO]) {
//            self.avatarView.image = [TheUserModule.currentUser avatarImageOfThumb:NO];
//        }
//
//        [cell showCustomAccessoryView];
//
//        UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAvatar:)];
//        touch.numberOfTapsRequired = 1;
//        [self.avatarView addGestureRecognizer:touch];
    }
    else if([cellItem.title isEqualToString:@"昵称"]) {
        [cell showCustomAccessoryView];
        cell.detailTextLabel.text = @"昵称";
    }
    else if ([cellItem.title isEqualToString:@"用户ID"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.detailTextLabel.text = @"ID";
    }
    else if ([cellItem.title isEqualToString:@"生日"]) {
        [cell showCustomAccessoryView];
        
        cell.detailTextLabel.text = @"1996.12.03";
//        if (TheUserModule.currentUser.birthday > 0) {
//            cell.detailTextLabel.text = [TheUserModule.currentUser birthdayString];
//        }
    }
    else if ([cellItem.title isEqualToString:@"退出登录"]) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.imageView.image = nil;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 96;
    }
    else {
        return TABLE_ROW_HEIGHT;
    }
}

//TODO: 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TableViewCellItem *cellItem = _itemArr[indexPath.section][indexPath.row];
    DLog(@"点击 %@", cellItem.title);
    if ([cellItem.title isEqualToString:@"退出登录"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"您确定要退出么" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:self];
            [USERDEFAULTS removeObjectForKey:@"Session"];
            [self.navigationController popViewControllerAnimated:NO];
            self.tabBarController.selectedIndex = 0;
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TABLE_SECTION_HEADER_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

//状态栏颜色
//一定要在viewWillDisappear里面写，如果写在viewDidDisappear里面会出问题！！！！
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //为了不影响其他页面在viewDidDisappear做以下设置
    self.navigationController.navigationBar.translucent = YES;//透明
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
}


@end
