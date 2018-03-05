//
//  UITableViewCell+seperatorInset.m
//  Bwuni
//
//  Created by mhm on 3/10/16.
//
//

#import "UITableViewCell+seperatorInset.h"

@implementation UITableViewCell (seperatorInset)

- (void)removeSeperatorInset
{
    [self setSeparatorInset:UIEdgeInsetsZero];
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)addTarget:(id)target action:(SEL)action forControl:(UIControl *)control
{
    NSArray *actions = [control actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
    if (!actions) {
        [control addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer forSubview:(UIView *)subView
{
    NSArray *actions = [subView gestureRecognizers];
    if (actions.count == 0) {
        [subView addGestureRecognizer:gestureRecognizer];
    }
}

- (void)showCheckMark:(BOOL)show
{
    if (show) {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBlueSelected"]];
    }
    else {
        self.accessoryView = nil;
    }
}

- (void)showCustomAccessoryView
{
    self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next_arrow_icon"]];
}

- (void)setSelectedBackgroundColor:(UIColor *)color
{
    UIView *bgView = [UIView new];
    bgView.backgroundColor = color;
    self.selectedBackgroundView = bgView;
}
@end
