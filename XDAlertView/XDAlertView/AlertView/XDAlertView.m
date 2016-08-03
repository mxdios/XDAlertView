//
//  XDAlertView.m
//  XDAlertView
//
//  Created by miaoxiaodong on 16/8/3.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "XDAlertView.h"
#import "UIView+Frame.h"
#import "XDSelectBtn.h"
#import "XDButton.h"

@implementation XDAlertView
{
    UIView *_alertView;
    UIButton *_closeBtn;
    UILabel *_titleText;
    UIScrollView *_scrollView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSelfView];
    }
    return self;
}
- (void)setupSelfView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _alertView = [[UIView alloc] init];
    _alertView.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00];
    _alertView.layer.cornerRadius = 8;
    _alertView.clipsToBounds = YES;
    [self addSubview:_alertView];
    _closeBtn = [[UIButton alloc] init];
    [_closeBtn setBackgroundImage:[UIImage imageNamed:@"nobtn"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_closeBtn];
    
    _titleText = [[UILabel alloc] init];
    _titleText.textColor = [UIColor blackColor];
    _titleText.font = [UIFont systemFontOfSize:18];
    _titleText.numberOfLines = 0;
    _titleText.textAlignment = NSTextAlignmentCenter;
    [_alertView addSubview:_titleText];
}
/** 初始化view 并设置文字 必须写*/
- (void)setupText:(NSString *)text btns:(NSArray *)btns isClose:(BOOL)isClose
{
    _alertView.width = self.width - 80;
    _alertView.centerX = self.width * 0.5;
    
    _titleText.text = text;
    _titleText.y = 40;
    _titleText.width = _alertView.width - 20;
    [_titleText sizeToFit];
    _titleText.centerX = _alertView.width * 0.5;
    
    if (isClose) {
        _closeBtn.hidden = NO;
        _closeBtn.frame = CGRectMake(_alertView.width - 30, 5, 25, 25);
    } else {
        _closeBtn.hidden = YES;
    }
    
    _alertView.height = _titleText.bottom + 80;
    _alertView.centerY = self.height * 0.5;
    [self setupBtns:btns];
}
/** 设置选择按钮式警示框 选择写*/
- (void)setupSelectBtns:(NSArray *)selectBtns btns:(NSArray *)btns
{
    _titleText.hidden = YES;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 40, _alertView.width - 40, 0)];
    for (NSInteger i = 0; i < selectBtns.count; i ++) {
        XDSelectBtn *selectBtn = [XDSelectBtn setupTitle:selectBtns[i] target:self action:@selector(selectBtnClick:) frame:CGRectMake(0, i * 25, _scrollView.width, 25)];
        [_scrollView addSubview:selectBtn];
        if (i == 0) {
            selectBtn.selected = YES;
            _selectBtnInn = selectBtn;
        }
    }
    _scrollView.height = selectBtns.count * 25;
    if (_scrollView.height > self.height * 0.3) {
        _scrollView.height = self.height * 0.3;
    }
    _scrollView.contentSize = CGSizeMake(0, selectBtns.count * 25);
    _scrollView.showsVerticalScrollIndicator = NO;
    [_alertView addSubview:_scrollView];
    _alertView.height = _scrollView.bottom + 80;
    _alertView.centerY = self.height * 0.5;
    [self setupBtns:btns];
}
/** 设置输入框式警示框  选择写 */
- (void)setupInputView:(NSString *)titleText place:(NSString *)place btns:(NSArray *)btns
{
    _titleText.hidden = YES;
    UILabel *titl = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, _alertView.width - 20, 20)];
    titl.font = [UIFont systemFontOfSize:15];
    titl.textColor = [UIColor blackColor];
    titl.text = titleText;
    [_alertView addSubview:titl];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(titl.x, titl.bottom + 30, titl.width, 30)];
    field.font = [UIFont systemFontOfSize:15];
    field.placeholder = place;
    self.field = field;
    [_alertView addSubview:field];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(titl.x, field.bottom, titl.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_alertView addSubview:line];
    
    _alertView.height = line.bottom + 80;
    _alertView.centerY = self.height * 0.5;
    [self setupBtns:btns];
}
/** 设置 选择按钮和输入框 同时存在式警示框  选择写 */
- (void)setupSelectBtnsInputView:(NSArray *)selectBtns titleText:(NSString *)titleText place:(NSString *)place btns:(NSArray *)btns
{
    _titleText.hidden = YES;
    UILabel *titl = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, _alertView.width - 20, 20)];
    titl.font = [UIFont systemFontOfSize:15];
    titl.textColor = [UIColor blackColor];
    titl.text = titleText;
    [_alertView addSubview:titl];
    
    CGFloat btnW = _alertView.width / selectBtns.count;
    for (NSInteger i = 0; i < selectBtns.count; i ++) {
        XDSelectBtn *selectBtn = [XDSelectBtn setupTitle:selectBtns[i] target:self action:@selector(selectBtnClick:) frame:CGRectMake(btnW * i, titl.bottom + 20, btnW, 25)];
        selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_alertView addSubview:selectBtn];
    }
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(titl.x, titl.bottom + 65, titl.width, 30)];
    field.font = [UIFont systemFontOfSize:15];
    field.placeholder = place;
    self.field = field;
    [_alertView addSubview:field];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(titl.x, field.bottom, titl.width, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_alertView addSubview:line];
    
    _alertView.height = line.bottom + 80;
    _alertView.centerY = self.height * 0.5;
    [self setupBtns:btns];
    
}
//view底下按钮被点击
- (void)btnsClick:(XDButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(alertViewDelegate:btnTag:)]) {
        [self.delegate alertViewDelegate:self btnTag:btn.tag];
    }
    [self closeBtnClick];
}
//选择按钮被点击
- (void)selectBtnClick:(XDSelectBtn *)selectBtn
{
    if ([self.delegate respondsToSelector:@selector(alertViewSelectBtnClickDelegate:selectBtn:)]) {
        [self.delegate alertViewSelectBtnClickDelegate:self selectBtn:selectBtn];
    }
    if (selectBtn.selected) return;
    _selectBtnInn.selected = NO;
    selectBtn.selected = YES;
    _selectBtnInn = selectBtn;
}

- (void)closeBtnClick
{
    [self removeFromSuperview];
}
/** 设置view底下的按钮 */
- (void)setupBtns:(NSArray *)btns
{
    if (btns.count == 1) {
        [self setupTitle:btns[0] frame:CGRectMake(0, _alertView.height - 40, _alertView.width, 40) tag:0 color:1];
    } else if(btns.count == 2) {
        [self setupTitle:btns[0] frame:CGRectMake(0, _alertView.height - 40, _alertView.width * 0.5, 40) tag:0 color:0];
        [self setupTitle:btns[1] frame:CGRectMake(_alertView.width * 0.5, _alertView.height - 40, _alertView.width * 0.5, 40) tag:1 color:1];
    }
}
/** 创建按钮 color 0是灰色 1是橙色 */
- (void)setupTitle:(NSString *)title frame:(CGRect)frame tag:(NSInteger)tag color:(NSInteger)color
{
    XDButton *btn = [[XDButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [btn setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    if (color) {//橙色
        [btn setBackgroundColor:[UIColor colorWithRed:1.00 green:0.38 blue:0.13 alpha:1.00] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:1.00 green:0.38 blue:0.13 alpha:0.50] forState:UIControlStateHighlighted];
    } else {
        [btn setBackgroundColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.00] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:0.50] forState:UIControlStateHighlighted];
    }
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnsClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:btn];
}
- (void)keyboardWillShow:(NSNotification *)not
{
    CGFloat keyboardH = [not.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //    _addGasMapTv.height = self.view.height - keyboardH;
    //    _addGasMapTv.scrollEnabled = YES;
    [UIView animateWithDuration:0.5 animations:^{
        _alertView.centerY = (self.height - keyboardH) * 0.5;
    }];
    
}
- (void)keyboardWillHide:(NSNotification *)not
{
    [UIView animateWithDuration:0.5 animations:^{
        _alertView.centerY = self.height * 0.5;
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.delegate = nil;
}

@end
