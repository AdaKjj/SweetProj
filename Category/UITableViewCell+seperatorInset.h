//
//  UITableViewCell+seperatorInset.h
//  Bwuni
//
//  Created by mhm on 3/10/16.
//
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (seperatorInset)

- (void)removeSeperatorInset;

- (void)addTarget:(id)target action:(SEL)action forControl:(UIControl *)control;

- (void)showCheckMark:(BOOL)show;

- (void)showCustomAccessoryView;

- (void)setSelectedBackgroundColor:(UIColor *)color;

@end
