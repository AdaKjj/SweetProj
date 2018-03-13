//
//  FoodPreviewVC.m
//  SweetProj
//
//  Created by 殷婕 on 2017/12/27.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "FoodPreviewVC.h"
#import "FoodPreviewCell.h"
#import "FoodDetailVC.h"
#import "DOPDropDownMenu.h"
#import "PreViewDDListManager.h"

@interface FoodPreviewVC ()<UITableViewDelegate,UITableViewDataSource,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate> {
    NSArray *_ImageArr;
    NSArray *_nameArr;
}
@property (nonatomic) UITableView *itemTableView;

@property (nonatomic, strong) NSArray *circle;
@property (nonatomic, strong) NSArray *classify;
@property (nonatomic, strong) NSArray *order;

//原先的DDDrop
@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSArray *areas;
@property (nonatomic, strong) NSArray *sorts;
@property (nonatomic, weak) DOPDropDownMenu *menu;
@property (nonatomic, weak) DOPDropDownMenu *menuB;


@end

@implementation FoodPreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = _topicString;
    [self createTableView];
    [self setupArr];
    
    PreViewDDListManager *mana = [[PreViewDDListManager alloc] init];
    mana.foodPreviewVC = self;
    [mana sendRequestWithCity:_cityString];
    
    // dropdownmenu
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:@selector(menuReloadData)];
//    self.classifys = @[@"美食",@"今日新单",@"电影",@"酒店"];
//    self.cates = @[@"自助餐",@"快餐",@"火锅",@"日韩料理",@"西餐",@"烧烤小吃"];
//    self.movices = @[@"内地剧",@"港台剧",@"英美剧"];
//    self.hostels = @[@"经济酒店",@"商务酒店",@"连锁酒店",@"度假酒店",@"公寓酒店"];
//    self.areas = @[@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
//    self.sorts = @[@"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:50];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    //当下拉菜单收回时的回调，用于网络请求新的数据
    _menu.finishedBlock=^(DOPIndexPath *indexPath){
        if (indexPath.item >= 0) {
            NSLog(@"收起:点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
        }else {
            NSLog(@"收起:点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
        }
    };
    //     创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    //    [menu selectDefalutIndexPath];
    [menu selectIndexPath:[DOPIndexPath indexPathWithCol:0 row:0 item:0]];
}

- (void)getDDMenuArr:(NSDictionary *)valueDic {
    self.ddMenuModel = [[DDMenuModel alloc] initWithDictionary:valueDic error:nil];
//    [_foodCollectionView reloadData];
//    [_relaxCollectionView reloadData];
//    [_topicCollectionView reloadData];
    self.circle = self.ddMenuModel.circle;
    self.classify = self.ddMenuModel.classify;
    self.order = self.ddMenuModel.order;
    [_menu reloadData];
}

- (void)menuReloadData
{
    self.classifys = @[@"美食",@"今日新单",@"电影"];
    [_menu reloadData];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.circle.count;
    }else if (column == 1){
        return self.classify.count;
    }else {
        return self.order.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.circle[indexPath.row];
    } else if (indexPath.column == 1){
        return self.classify[indexPath.row];
    } else {
        return self.order[indexPath.row];
    }
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0 || indexPath.column == 1) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.row];
    }
    return nil;
}

- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0 && indexPath.item >= 0) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld",indexPath.item];
    }
    return nil;
}

// new datasource

- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column < 2) {
        return [@(arc4random()%1000) stringValue];
    }
    return nil;
}

//- (NSString *)menu:(DOPDropDownMenu *)menu detailTextForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
//{
//    return [@(arc4random()%1000) stringValue];
//}

//- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
//{
//    if (column == 0) {
//        if (row == 0) {
//            return self.cates.count;
//        } else if (row == 2){
//            return self.movices.count;
//        } else if (row == 3){
//            return self.hostels.count;
//        }
//    }
//    return 0;
//}

//- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
//{
//    if (indexPath.column == 0) {
//        if (indexPath.row == 0) {
//            return self.cates[indexPath.item];
//        } else if (indexPath.row == 2){
//            return self.movices[indexPath.item];
//        } else if (indexPath.row == 3){
//            return self.hostels[indexPath.item];
//        }
//    }
//    return nil;
//}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)createTableView
{
    self.itemTableView = [[UITableView alloc] init];
    self.itemTableView.backgroundColor = [UIColor whiteColor];
    self.itemTableView.dataSource = self;
    self.itemTableView.delegate = self;
    [self.itemTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview: self.itemTableView];
    [self.itemTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(50);
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
}

- (void)setupArr {
    _ImageArr = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"text1"], [UIImage imageNamed:@"text2"], [UIImage imageNamed:@"text3"], nil];
    _nameArr = [[NSArray alloc] initWithObjects:@"老板娘烤肉店", @"老板娘烤肉店", @"老板娘烤肉店", nil];
}

#pragma tableViewDelegate
//用来指定表视图的分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //分区设置为1m
    return 1;
}

//用来指定特定分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //设置为20行
    return [_ImageArr count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    FoodPreviewCell *cell = (FoodPreviewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FoodDetailVC *detailVC = [[FoodDetailVC alloc] init];
    detailVC.storeString = cell.storeNameLabel.text;
    detailVC.topImage = cell.topImageView.image;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
//配置特定行中的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    FoodPreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[FoodPreviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.topImageView.image = [UIImage imageNamed:@"text4"];
        cell.bottomImageView1.image = [_ImageArr objectAtIndex:0];
        cell.bottomImageView2.image = [_ImageArr objectAtIndex:1];
        cell.bottomImageView3.image = [_ImageArr objectAtIndex:2];
        
        cell.storeNameLabel.text = [_nameArr objectAtIndex:indexPath.row];
        cell.introLabel.text = [_nameArr objectAtIndex:indexPath.row];
        
    }
    return cell;
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    //这里设置成150
    return 285+(SCREEN_WIDTH-40)/3;
}
@end
