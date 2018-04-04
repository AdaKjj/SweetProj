//
//  MyCommentVC.m
//  SweetProj
//
//  Created by 殷婕 on 2018/3/14.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "MyCommentVC.h"
#import "MyCommentCell.h"
@interface MyCommentVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *itemTableView;

@end

@implementation MyCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"历史订单";
    
    self.itemTableView = [[UITableView alloc] init];
    self.itemTableView.backgroundColor = [UIColor whiteColor];
    self.itemTableView.dataSource = self;
    self.itemTableView.delegate = self;
    [self.itemTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.itemTableView.separatorColor = [UIColor grayColor];
    self.itemTableView.separatorInset = UIEdgeInsetsMake(0,15, 0, 15);// 设置端距，这里表示separator离左边和右边均80像素
    [self.view addSubview: self.itemTableView];
    [self.itemTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    //导航栏颜色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
}

#pragma mark - tableViewDelegate
//用来指定表视图的分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //分区设置为1m
    return 1;
}

//用来指定特定分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //设置为20行
    return 20;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//
//    MyCommentCell *cell = (MyCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    FoodDetailVC *detailVC = [[FoodDetailVC alloc] init];
//    [self.navigationController pushViewController:detailVC animated:YES];
//
//}

//配置特定行中的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    MyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[MyCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.name.text = @"101烤羊腿";
        cell.money.text = @"总计 100元";
        cell.date.text = @"2018年10月10日";
        cell.shopImageView.image = [UIImage imageNamed:@"text1"];
        cell.state.text = @"已完成";
        cell.time.text = @"23:23";
        
    }
    return cell;
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    //这里设置成150
    return 98;
}

@end
