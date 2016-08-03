//
//  XDButton.h
//  gasstation
//
//  Created by inspiry on 16/3/23.
//  Copyright © 2016年 inspiry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDButton : UIButton
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (UIColor *)backgroundColorForState:(UIControlState)state;
@end
