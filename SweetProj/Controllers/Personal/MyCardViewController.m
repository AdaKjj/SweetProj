//
//  MyCardViewController.m
//  SweetProj
//
//  Created by 殷婕 on 2018/1/15.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "MyCardViewController.h"
#import "MyCardCell.h"
#import "MyCardDetailVC.h"

@interface MyCardViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout> {
    NSArray *_moduleNameArr;
    NSMutableArray *_moduleImageArr;
}

@property (nonatomic) UICollectionView *cardCollectionView;

@end

@implementation MyCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的会员卡";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configCollectionView];
    [self setModuleName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configCollectionView {
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _cardCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    [self.view addSubview:_cardCollectionView];
    
    _cardCollectionView.backgroundColor = [UIColor whiteColor];
    
    //3.注册collectionViewCell
    [_cardCollectionView registerClass:[MyCardCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //4.设置代理
    _cardCollectionView.delegate = self;
    _cardCollectionView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO];
    
    //导航栏颜色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

}

- (void)setModuleName {
    _moduleNameArr = [[NSArray alloc]initWithObjects:@"第一家店", @"第二家店", @"第三家店", @"第四家店", nil];
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(SCREEN_WIDTH - 20, 80);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *backgroundColor;
    int i = (indexPath.row % 5);
    switch (i) {
        case 0:
            backgroundColor = RGB(193, 207, 124);
            break;
        case 1:
            backgroundColor = RGB(59, 62, 35);
            break;
        case 2:
            backgroundColor = RGB(126, 147, 63);
            break;
        case 3:
            backgroundColor = RGB(73, 78, 37);
            break;
        case 4:
            backgroundColor = RGB(38, 37, 50);
            break;
        default:
            break;
    }
    MyCardCell *cell = (MyCardCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.backgroundImageView.backgroundColor = backgroundColor;
    cell.shopImageView.image = [UIImage imageNamed:@"text2"];
    cell.shopNameLabel.text = [_moduleNameArr objectAtIndex:indexPath.row];
    cell.cardNameLabel.text = [_moduleNameArr objectAtIndex:indexPath.row];
    return cell;
}

// 左右边距
- (CGFloat)collectionView: (UICollectionView *)collectionView layout: (UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex: (NSInteger)section{
    return  10.0f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCardCell *cell = (MyCardCell *)[collectionView cellForItemAtIndexPath:indexPath];
    MyCardDetailVC *cardlVC = [[MyCardDetailVC alloc] init];
    cardlVC.hidesBottomBarWhenPushed = YES;
    cardlVC.color = cell.backgroundImageView.backgroundColor;
    cardlVC.shopImage = cell.shopImageView.image;
    cardlVC.shopNameText = cell.shopNameLabel.text;
    [self.navigationController pushViewController:cardlVC animated:YES];
}

@end
