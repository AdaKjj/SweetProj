//
//  SelectionVC.m
//  SweetProj
//
//  Created by 殷婕 on 2018/3/5.
//  Copyright © 2018年 AdaKjj. All rights reserved.
//

#import "SelectionVC.h"
#import "UIButton+EdgeInsets.h"
#import "UIView+DDAddition.h"
#import <pop/POP.h>
#import "ReservationInfoVC.h"

#define kDuration 0.2
#define kPopMenuItemWidth 40
#define kPopMenuItemHeight kPopMenuItemWidth
#define kInterval (0.195 / _btnArray.count)

@interface SelectionVC ()
{
    UIView   *_contentView;
    NSArray  *_btnArray;
}
@property UIButton *closebtn;

@end

@implementation SelectionVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    CGFloat contentHeight = 170;
    
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(0);
        make.height.equalTo(contentHeight);
    }];
    
    UIButton *doubleRes = [UIButton buttonWithType:UIButtonTypeCustom];
    doubleRes.titleLabel.font = systemFont(12);
    [doubleRes setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doubleRes setImage:[UIImage imageNamed:@"order_double"] forState:UIControlStateNormal];
    [doubleRes setTitle:@"多人订餐" forState:UIControlStateNormal];
    [doubleRes addTarget:self action:@selector(onTouchDouble) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:doubleRes];
    doubleRes.viewWidth = kPopMenuItemWidth;
    doubleRes.viewHeight = kPopMenuItemHeight;
    
    UIButton *seatRes = [UIButton buttonWithType:UIButtonTypeCustom];
    seatRes.titleLabel.font = systemFont(12);
    [seatRes setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [seatRes setImage:[UIImage imageNamed:@"order_seat"] forState:UIControlStateNormal];
    [seatRes setTitle:@"预定座位" forState:UIControlStateNormal];
    [seatRes addTarget:self action:@selector(onTouchSeat) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:seatRes];
    seatRes.viewWidth = kPopMenuItemWidth;
    seatRes.viewHeight = kPopMenuItemHeight;
    
    UIButton *singleRes = [UIButton buttonWithType:UIButtonTypeCustom];
    singleRes.titleLabel.font = systemFont(12);
    [singleRes setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [singleRes setImage:[UIImage imageNamed:@"order_single"] forState:UIControlStateNormal];
    [singleRes setTitle:@"单人订餐" forState:UIControlStateNormal];
    [singleRes addTarget:self action:@selector(onTouchSingle) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:singleRes];
    singleRes.viewWidth = kPopMenuItemWidth;
    singleRes.viewHeight = kPopMenuItemHeight;
    
    _closebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closebtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [_contentView addSubview:_closebtn];
    [_closebtn addTarget:self action:@selector(onTouchDismiss) forControlEvents:UIControlEventTouchUpInside];
    [_closebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.equalTo(-10);
        make.width.equalTo(40);
        make.height.equalTo(40);
    }];
    
    _btnArray = @[seatRes, doubleRes, singleRes];
    
    [_contentView layoutIfNeeded];
    [doubleRes layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:5];
    [seatRes layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:5];
    [singleRes layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:5];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:kDuration animations:^{
            self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.2];
        }];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchDismiss)];
    [self.view addGestureRecognizer:tap];
    
    [self performSelector:@selector(calculatingItems) withObject:nil afterDelay:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  计算按钮的位置
 */
- (void)calculatingItems {
    
    WEAKSELF
    [UIView animateWithDuration:kDuration animations:^{
        weakSelf.closebtn.transform = CGAffineTransformMakeRotation(M_PI_2);
    }];
    
    NSInteger index = 0;
    NSInteger count = _btnArray.count;
    
    CGFloat span = (self.view.viewWidth - count*kPopMenuItemWidth)/(count+1);
    
    for (UIButton *button in _btnArray) {
        CGFloat buttonX,buttonY;
        
        buttonX = index * kPopMenuItemWidth + (index+1) * span;
        buttonY = kPopMenuItemWidth;
        
        CGRect fromValue = CGRectMake(buttonX, _contentView.viewBottom-20, kPopMenuItemWidth, kPopMenuItemHeight);
        CGRect toValue = CGRectMake(buttonX, buttonY, kPopMenuItemWidth, kPopMenuItemHeight);
        
        [button setFrame:fromValue];
        
        double delayInSeconds = index * kInterval;
        CFTimeInterval delay = delayInSeconds + CACurrentMediaTime();
        
        [self startTheAnimationFromValue:fromValue toValue:toValue delay:delay object:button completionBlock:^(BOOL complete) {
            
        } hideDisplay:false];
        
        index ++;
    }
}

/**
 *  隐藏动画
 *
 *  @param completionBlock 完成回调
 */
-(void)dismissCompletionBlock:(void(^) (BOOL complete)) completionBlock{
    
    //动画旋转
    typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.38 animations:^{
        weakSelf.closebtn.transform = CGAffineTransformMakeRotation(M_PI_2/2);
    }];
    
    NSInteger index = 0;
    
    NSInteger count = _btnArray.count;
    CGFloat span = (self.view.viewWidth - count*kPopMenuItemWidth)/(count+1);
    
    for (UIButton *button in _btnArray) {
        
        CGFloat buttonX,buttonY;
        buttonX = index * kPopMenuItemWidth + (index+1) * span;
        buttonY = kPopMenuItemWidth;
        
        CGRect toValue = CGRectMake(buttonX, _contentView.viewHeight, kPopMenuItemWidth, kPopMenuItemHeight);
        CGRect fromValue = CGRectMake(buttonX, buttonY, kPopMenuItemWidth, kPopMenuItemHeight);
        
        double delayInSeconds = (_btnArray.count - index) * kInterval;
        CFTimeInterval delay = delayInSeconds + CACurrentMediaTime();
        
        //        [UIView animateWithDuration:0.2 animations:^{
        //            [bottomView setBackgroundColor:[UIColor clearColor]];
        //        }];
        
        [self startTheAnimationFromValue:fromValue toValue:toValue delay:delay object:button completionBlock:^(BOOL complete) {
            
        } hideDisplay:true];
        index ++;
    }
    
    [UIView animateKeyframesWithDuration:kDuration delay:0.38 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        
        [weakSelf.view setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        if (completionBlock) {
            completionBlock(finished);
        }
    }];
    
    //    [self hideDelay:0.38f completionBlock:^(BOOL completion) {
    //
    //    }];
}

/**
 *  开始弹出动画
 *
 *  @param fromValue       起始位置
 *  @param toValue         结束位置
 *  @param delay           延迟
 *  @param obj             执行动画对象
 *  @param completionBlock 完成回调
 *  @param hideDisplay     hideDisplay YES or NO
 */
-(void)startTheAnimationFromValue:(CGRect)fromValue
                          toValue:(CGRect)toValue
                            delay:(CFTimeInterval)delay
                           object:(id)obj
                  completionBlock:(void(^) (BOOL complete))completionBlock
                      hideDisplay:(BOOL)hideDisplay{
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    springAnimation.removedOnCompletion = YES;
    springAnimation.beginTime = delay;
    CGFloat springBounciness = 10.f;
    springAnimation.springBounciness = springBounciness;    // value between 0-20
    CGFloat springSpeed = 20.f;
    springAnimation.springSpeed = springSpeed;     // value between 0-20
    springAnimation.toValue = [NSValue valueWithCGRect:toValue];
    springAnimation.fromValue = [NSValue valueWithCGRect:fromValue];
    
    POPSpringAnimation *springAnimationAlpha = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
    springAnimationAlpha.removedOnCompletion = YES;
    springAnimationAlpha.beginTime = delay;
    springAnimationAlpha.springBounciness = springBounciness;    // value between 0-20
    
    CGFloat toV,fromV;
    if (hideDisplay) {
        fromV = 1.0f;
        toV = 0.0f;
    }else{
        fromV = 0.0f;
        toV = 1.0f;
    }
    
    springAnimationAlpha.springSpeed = springSpeed;     // value between 0-20
    springAnimationAlpha.toValue = @(toV);
    springAnimationAlpha.fromValue = @(fromV);
    
    [obj pop_addAnimation:springAnimationAlpha forKey:springAnimationAlpha.name];
    [obj pop_addAnimation:springAnimation forKey:springAnimation.name];
    [springAnimation setCompletionBlock:^(POPAnimation *spring, BOOL completion) {
        if (!completionBlock) {
            return ;
        }
        completionBlock(completion);
    }];
    
}

- (void)setTapBackgroundToDismiss
{
    UIControl *baseControl = [[UIControl alloc] initWithFrame:self.view.bounds];
    baseControl.backgroundColor = [UIColor clearColor];
    [baseControl addTarget:self action:@selector(onTouchDismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view insertSubview:baseControl atIndex:0];
}

- (void)onTouchDismiss
{
    typeof(self) weakSelf = self;
    
    [self dismissCompletionBlock:^(BOOL complete) {
        [weakSelf dismissViewControllerAnimated:NO completion:^{
            
        }];
    }];
}

- (void)onTouchDouble {
    typeof(self) weakSelf = self;
    [self dismissCompletionBlock:^(BOOL complete) {
        [weakSelf dismissViewControllerAnimated:NO completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"doubleRes" object:self];
        }];
    }];
}

- (void)onTouchSeat {
    typeof(self) weakSelf = self;
    [self dismissCompletionBlock:^(BOOL complete) {
        [weakSelf dismissViewControllerAnimated:NO completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"seatRes" object:self];
        }];
    }];
}

- (void)onTouchSingle {
    typeof(self) weakSelf = self;
    [self dismissCompletionBlock:^(BOOL complete) {
        [weakSelf dismissViewControllerAnimated:NO completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"singleRes" object:self];
        }];
    }];
//    
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    UINavigationController *nav0 = (UINavigationController *)window.rootViewController;
//    UIViewController *viewController = [nav0.viewControllers objectAtIndex:1];
//    [viewController.navigationController pushViewController:reVC animated:YES];
}

@end
