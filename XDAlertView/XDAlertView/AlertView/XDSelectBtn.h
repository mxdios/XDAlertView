//
//  XDSelectBtn.h
//  XDAlertView
//
//  Created by miaoxiaodong on 16/8/3.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDSelectBtn : UIButton
+ (XDSelectBtn *)setupTitle:(NSString *)title target:(id)target action:(SEL)action frame:(CGRect)frame;

@end
