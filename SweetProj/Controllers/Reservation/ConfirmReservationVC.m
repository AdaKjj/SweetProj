//
//  ConfirmReservationVC.m
//  SweetProj
//
//  Created by 殷婕 on 2018/1/31.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "ConfirmReservationVC.h"
#import "UIImage+Addition.h"
#import "PayVC.h"
#import "ConfirmTBCell.h"

#import "MainVC.h"

@interface ConfirmReservationVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@end

@implementation ConfirmReservationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.title = @"确认订单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainBg"]];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(0);
        make.height.equalTo(self.view.height);
        make.width.equalTo(self.view.width);
    }];
    
    [self configConfirm];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(43, 124, self.view.frame.size.width - 43-43, 500) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview: self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(124);
        make.left.equalTo(43);
        make.right.equalTo(-43);
        make.height.equalTo(500);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)configConfirm {
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"confirmReservation"]];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.top.equalTo(60);
        make.bottom.equalTo(20);
    }];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确认付款" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setFont:systemFont(18)];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.layer.cornerRadius = 10;
    confirmBtn.backgroundColor = SYSTEMCOLOR;
    [confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-95);
        make.centerX.equalTo(0);
        make.height.equalTo(40);
        make.width.equalTo(280);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:systemFont(18)];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = 10;
    cancelBtn.backgroundColor = SYSTEMCOLOR;
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmBtn.mas_bottom).inset(10);
        make.centerX.equalTo(0);
        make.height.equalTo(40);
        make.width.equalTo(280);
    }];
}

- (void)confirmBtnClicked {
    PayVC *vc = [[PayVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cancelBtnClicked {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MainVC class]]) {
            MainVC *vc =(MainVC *)controller;
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}


/**
 *  返回当前时间
 *
 *  @return 当前时间
 */
- (NSString *)getTimeNow
{
    NSString *date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY.MM.dd hh:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    return date;
}

#pragma mark - tableViewDelegate
//用来指定表视图的分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//用来指定特定分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shopCarArr.count;
}

//配置特定行中的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ConfirmTBCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[ConfirmTBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.model = [_shopCarArr objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *ID = @"header";
    ConfirmTBHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if(!headerView){
        headerView = [[ConfirmTBHeader alloc] initWithReuseIdentifier:ID];
        headerView.seat.text = @"222";
    }
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    static NSString *ID = @"footer";
    ConfirmTBFooter *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if(!footerView){
        footerView = [[ConfirmTBFooter alloc] initWithReuseIdentifier:ID];
        footerView.time.text = [self getTimeNow];
        footerView.price.text = [NSString stringWithFormat:@"¥%.2f",_totalPrice];
    }
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        CGFloat sectionHeaderHeight = 0;
        CGFloat sectionFooterHeight = 20;
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY >= 0 && offsetY <= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
        }else if (offsetY >= sectionHeaderHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
        }else if (offsetY >= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height) {
            scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight), 0);
        }
    
}

@end
