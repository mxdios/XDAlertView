//
//  XDAlertView.h
//  XDAlertView
//
//  Created by miaoxiaodong on 16/8/3.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDSelectBtn.h"

@class XDAlertView;

@protocol XDAlertViewDelegate <NSObject>
/** 警示框的代理方法 */
- (void)alertViewDelegate:(XDAlertView *)alertView btnTag:(NSInteger)btnTag;

@optional
/** 选择按钮点击 */
- (void)alertViewSelectBtnClickDelegate:(XDAlertView *)alertView selectBtn:(XDSelectBtn *)selectBtn;
@end


@interface XDAlertView : UIView
/** 初始化view 并设置文字 必须写*/
- (void)setupText:(NSString *)text btns:(NSArray *)btns isClose:(BOOL)isClose;
/** 设置选择按钮式警示框 选择写*/
- (void)setupSelectBtns:(NSArray *)selectBtns btns:(NSArray *)btns;
/** 设置输入框式警示框  选择写 */
- (void)setupInputView:(NSString *)titleText place:(NSString *)place btns:(NSArray *)btns;
/** 设置 选择按钮和输入框 同时存在式警示框  选择写 */
- (void)setupSelectBtnsInputView:(NSArray *)selectBtns titleText:(NSString *)titleText place:(NSString *)place btns:(NSArray *)btns;

@property (nonatomic, weak) id<XDAlertViewDelegate> delegate;

@property (nonatomic, weak) XDSelectBtn *selectBtnInn;

@property (nonatomic, weak) UITextField *field;

@end
