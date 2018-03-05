//
//  LocalSearchController.m
//  SweetProj
//
//  Created by 殷婕 on 2017/11/29.
//  Copyright © 2017年 AdaKjj. All rights reserved.
//

#import "LocalSearchController.h"
#import "UIImage+Addition.h"
@interface LocalSearchController () <UISearchBarDelegate>

@end

@implementation LocalSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.placeholder = @"在Sweet上搜索…";
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1] size:CGSizeMake(self.view.frame.size.width, 44)] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
