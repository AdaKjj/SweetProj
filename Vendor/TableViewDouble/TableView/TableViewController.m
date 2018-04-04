//
//  TableViewController.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "TableViewHeaderView.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "CategoryModel.h"
#import "TableViewController.h"
#import "UIImage+Addition.h"
#import "UITableViewCell+seperatorInset.h"
#import "ReservationInfoVC.h"
#import "MenuManager.h"
#import "OSSManager.h"

#import "ShopCarView.h"

static float kLeftTableViewWidth = 100.f;

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource, CAAnimationDelegate>

@property (nonatomic, strong) NSMutableArray *categoryData;
@property (nonatomic, strong) NSMutableArray *foodData;
@property (nonatomic) NSMutableArray *photoArr;
@property (nonatomic) int foodCount;

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic) UILabel *priceLabel;
@property (nonatomic) UIButton *verbBtn;
@property (nonatomic) UILabel *countLabel;
@property (nonatomic) float price;

@property (nonatomic) NSMutableArray *shopCarArr;

@end

@implementation TableViewController
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];

    _selectIndex = 0;
    _isScrollDown = YES;
    
    MenuManager *manager = [[MenuManager alloc] init];
    manager.tbVC = self;
    [manager sendRequestWithMerid:_merId];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _shopCarArr = [NSMutableArray array];
    
    UIButton *shopCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shopCarBtn.frame = CGRectMake(0, 0, 40, 22);
    [shopCarBtn setImage:[UIImage imageNamed:@"shopcar"] forState:UIControlStateNormal];
    [shopCarBtn addTarget:self action:@selector(onTouchShopCar) forControlEvents:UIControlEventTouchUpInside];
    
    _countLabel = [[UILabel alloc] init];
    _countLabel.text = @"0";
    _countLabel.backgroundColor = [UIColor redColor];
    _countLabel.layer.cornerRadius = 6;
    _countLabel.textColor = [UIColor whiteColor];
    [_countLabel setFont:systemFont(10)];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.layer.masksToBounds = YES;
    [shopCarBtn addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(3);
        make.top.equalTo(0);
        make.width.height.equalTo(12);
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shopCarBtn];
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
    
    _price = 0.00;
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.text = [NSString stringWithFormat:@" 总计：¥%.2f",_price];
    _priceLabel.textColor = [UIColor whiteColor];
    [_priceLabel setFont:systemFont(18)];
    _priceLabel.backgroundColor = RGB(67, 67, 67);
    [self.view addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(0);
        make.height.equalTo(50);
        make.right.equalTo(-120);
    }];
    
    _verbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_verbBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [_verbBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _verbBtn.backgroundColor = RGB(155, 200, 29);
    [_verbBtn.titleLabel setFont:systemFont(18)];
    [_verbBtn addTarget:self action:@selector(verBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verbBtn];
    [_verbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(0);
        make.height.equalTo(50);
        make.width.equalTo(120);
    }];
    
    
}

- (void)onTouchShopCar {
    ShopCarView *shopCarView = [[ShopCarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    shopCarView.shopCarArr = _shopCarArr;
    //shopCarView.
    [[UIApplication sharedApplication].keyWindow addSubview:shopCarView];
}

- (void)verBtnClicked {
    NSLog(@"%@",_shopCarArr);
    
//    ReservationInfoVC *vc = [[ReservationInfoVC alloc] init];
//    
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    //状态栏颜色
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor clearColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttrs];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

//状态栏颜色
//一定要在viewWillDisappear里面写，如果写在viewDidDisappear里面会出问题！！！！
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //为了不影响其他页面在viewDidDisappear做以下设置
    self.navigationController.navigationBar.translucent = YES;//透明
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
}

/**
 *  存放用户添加到购物车的商品数组
 *
 */
-(NSMutableArray *)ordersArray
{
    if (!_ordersArray) {
        _ordersArray = [NSMutableArray new];
    }
    return _ordersArray;
}

#pragma mark - Getters

- (NSMutableArray *)categoryData
{
    if (!_categoryData)
    {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

- (NSMutableArray *)foodData
{
    if (!_foodData)
    {
        _foodData = [NSMutableArray array];
    }
    return _foodData;
}

- (NSMutableArray *)photoArr
{
    if (!_photoArr)
    {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, SCREEN_HEIGHT - 50)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 55;
        _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kLeftTableViewWidth, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 80;
        _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Right];
    }
    return _rightTableView;
}

- (void)getMenuDic:(NSDictionary *)jsonDic {
    self.menuModel = [[MenuModel alloc] initWithDictionary:jsonDic error:nil];
    
    _foodCount = 0;
    OSSManager *manager = [OSSManager new];
    
    for(int i=0; i<[_menuModel.item_list count]; i++) {
        ItemListModel *listModel = _menuModel.item_list[i];
        
        for (int i=0; i<listModel.item.count; i++) {
            NSArray<ItemModel> *itemList = listModel.item;
            ItemModel *itemModel = itemList[i];
            [manager downloadImageWithName:itemModel.photo];
            WEAKSELF;
            manager.downloadBlock = ^(NSData *data) {
                [weakSelf.photoArr addObject:data];
                BOOL isEqual = (int)[_photoArr count] == _foodCount;
                if (isEqual) {
                    [self performSelectorOnMainThread:@selector(showCell) withObject:nil waitUntilDone:NO];
                }
            };
            _foodCount++;
        }
    }
}

- (void)showCell{
        for (ItemListModel *model in _menuModel.item_list) {
            [self.categoryData addObject:model];
        }
        int k = 0;
        for(int i=0; i<self.categoryData.count; i++) {
            ItemListModel *listModel = self.categoryData[i];
            NSMutableArray *listArr = [NSMutableArray array];
            for (int j=0; j<listModel.item.count; j++) {
                NSArray<ItemModel> *itemList = listModel.item;
                ItemModel *itemModel = itemList[j];
                itemModel.photoData = _photoArr[k];
                itemModel.count = [[NSNumber alloc] initWithInt:0];
                [listArr addObject:itemModel];
                k++;
            }
            [self.foodData addObject:listArr];
        }

        [_leftTableView reloadData];
        [_rightTableView reloadData];
    
        NSIndexPath * selIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        [_leftTableView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
        NSIndexPath * path = [NSIndexPath indexPathForItem:0 inSection:0];
        [self tableView:self.leftTableView didSelectRowAtIndexPath:path];
    
}

#pragma mark - TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_leftTableView == tableView)
    {
        return 1;
    }
    else
    {
        return [self.categoryData count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_leftTableView == tableView)
    {
        return [self.categoryData count];
    }
    else
    {
        NSMutableArray *arr = self.foodData[section];
        return arr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
        ItemListModel *itemListModel = self.categoryData[indexPath.row];
        cell.name.text = itemListModel.name;
        
        return cell;
    }
    else
    {
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Right forIndexPath:indexPath];
        
        ItemModel *itemModel = self.foodData[indexPath.section][indexPath.row];
        
        cell.model = itemModel;
        
        WEAKSELF;
        cell.operationBlock = ^(NSInteger number, BOOL plus) {
            
            ItemModel *itemModel = weakSelf.foodData[indexPath.section][indexPath.row];
            itemModel.count = [NSNumber numberWithInteger:number];
            
            [weakSelf.foodData[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:itemModel];
            
            [self.rightTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
            if (plus) {
                _price += itemModel.univalence;
                _priceLabel.text = [NSString stringWithFormat:@" 总计：¥%.2f",_price];
                if (number == 1) {
                    ShopCarModel *shopModal = [ShopCarModel new];
                    shopModal.orderid = itemModel.item_id;
                    shopModal.name = itemModel.name;
                    shopModal.min_price = itemModel.univalence;
                    shopModal.count = number;
                    [_shopCarArr addObject:shopModal];
                    _countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[_shopCarArr count]];
                }
                else {
                    for (NSInteger i=0; i<_shopCarArr.count; i++) {
                        ShopCarModel *shopModal = _shopCarArr[i];
                        if (shopModal.orderid == itemModel.item_id) {
                            shopModal.count = number;
                            [_shopCarArr replaceObjectAtIndex:i withObject:shopModal];
                            _countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[_shopCarArr count]];
                        }
                    }
                }
            }
            else {
                _price -= itemModel.univalence;
                _priceLabel.text = [NSString stringWithFormat:@" 总计：¥%.2f",_price];
                if (number == 0) {
                    for (NSInteger i=0; i<_shopCarArr.count; i++) {
                        ShopCarModel *shopModal = _shopCarArr[i];
                        if (shopModal.orderid == itemModel.item_id) {
                            [_shopCarArr removeObjectAtIndex:i];
                            _countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[_shopCarArr count]];
                        }
                    }
                }
                else {
                    for (NSInteger i=0; i<_shopCarArr.count; i++) {
                        ShopCarModel *shopModal = _shopCarArr[i];
                        if (shopModal.orderid == itemModel.item_id) {
                            shopModal.count = number;
                            [_shopCarArr replaceObjectAtIndex:i withObject:shopModal];
                            _countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[_shopCarArr count]];
                        }
                    }
                }
            }
        };
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        return 20;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_rightTableView == tableView)
    {
        TableViewHeaderView *view = [[TableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        ItemListModel *model = self.categoryData[section];
        view.name.text = model.name;
        return view;
    }
    return nil;
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && !_isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && _isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section + 1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        _selectIndex = indexPath.row;
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }
    
    if (_rightTableView == tableView) {
        
    }
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;

    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
