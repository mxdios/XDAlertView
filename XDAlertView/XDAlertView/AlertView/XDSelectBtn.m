//
//  XDSelectBtn.m
//  XDAlertView
//
//  Created by miaoxiaodong on 16/8/3.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "XDSelectBtn.h"

#define setColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation XDSelectBtn

+ (XDSelectBtn *)setupTitle:(NSString *)title target:(id)target action:(SEL)action frame:(CGRect)frame
{
    XDSelectBtn *btn = [[XDSelectBtn alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        [self setTitleColor:setColor(62, 62, 62) forState:UIControlStateNormal];
        [self setTitleColor:setColor(62, 62, 62) forState:UIControlStateSelected];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [self setImage:[UIImage imageNamed:@"Rounded-Rectangle"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"RoundedRectangle"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"Rounded-Rectangle"] forState:UIControlStateDisabled];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    }
    return self;
}

@end
