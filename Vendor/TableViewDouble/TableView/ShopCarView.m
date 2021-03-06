//
//  ShopCarView.m
//  SweetProj
//
//  Created by 殷婕 on 2018/3/28.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "ShopCarView.h"
#import "ShopCarCell.h"

@interface ShopCarView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UITableView *tableView;

@end

@implementation ShopCarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.3];
        
        UIControl *baseControl = [[UIControl alloc] initWithFrame:self.bounds];
        baseControl.backgroundColor = [UIColor clearColor];
        [baseControl addTarget:self action:@selector(onTouchDismiss) forControlEvents:UIControlEventTouchUpInside];
        
        [self insertSubview:baseControl atIndex:0];
    }
    return self;
}

- (void)layoutSubviews {
    if (_shopCarArr.count > 0) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        self.tableView.separatorColor = [UIColor grayColor];
        self.tableView.separatorInset = UIEdgeInsetsMake(0,15, 0, 15);// 设置端距，这里表示separator离左边和右边均80像素
        [self addSubview: self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(90);
            make.left.equalTo(15);
            make.right.equalTo(-15);
            make.height.equalTo(300);
        }];
    }
}

- (void)onTouchDismiss {
    [UIView animateWithDuration:0.3 animations:^{
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
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
    return _shopCarArr.count;
}


//配置特定行中的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        //单元格样式设置为UITableViewCellStyleDefault
        cell = [[ShopCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.model = [_shopCarArr objectAtIndex:indexPath.row];
        cell.name.text = [_shopCarArr objectAtIndex:indexPath.row].name;
        cell.countLabel.text = [NSString stringWithFormat:@"%ld",[_shopCarArr objectAtIndex:indexPath.row].count];
        cell.price.text = [NSString stringWithFormat:@"%.2f",[_shopCarArr objectAtIndex:indexPath.row].min_price];
        cell.indexPath = [_shopCarArr objectAtIndex:indexPath.row].indexPath;
        
        WEAKSELF;
        __block ShopCarCell *blockCell = cell;
        cell.operationBlock = ^(NSIndexPath *oriIndexPath, BOOL plus) {
            if (!plus) {
                if ([cell.countLabel.text intValue] == 0) {
                    ShopCarModel *deleteModel = blockCell.model;
                    for (int i = 0; i<[self.shopCarArr count]; i++) {
                        ShopCarModel *model = self.shopCarArr[i];
                        if ([model.name isEqualToString:deleteModel.name]) {
                            [weakSelf.shopCarArr removeObject:model];
                            [weakSelf.tableView beginUpdates];
                            [weakSelf.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                            [weakSelf.tableView endUpdates];
                            
                            if ([_shopCarArr count] == 0) {
                                [weakSelf onTouchDismiss];
                            }
                        }
                    }
                }
            }
            
            if (self.operationBlock) {
                self.operationBlock(oriIndexPath, plus);
            }
        };
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 60;
}

@end
