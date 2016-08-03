//
//  ViewController.m
//  XDAlertView
//
//  Created by miaoxiaodong on 16/8/3.
//  Copyright © 2016年 miaoxiaodong. All rights reserved.
//

#import "ViewController.h"
#import "XDAlertView.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, XDAlertViewDelegate>
{
    NSArray *_datas;
    XDAlertView *_addselectAlertView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datas = @[@"纯文字警示框",@"选择按钮警示框",@"输入框式警示框",@"选择按钮和输入框同时存在",@"选择按钮触发结果"];
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            XDAlertView *alertView = [[XDAlertView alloc] init];
            alertView.delegate = self;
            [alertView setupText:@"显示弹出内容" btns:@[@"取消",@"确认"] isClose:NO];
            [self.view.window addSubview:alertView];

            
            break;
        }
        case 1:
        {
            XDAlertView *selectAlertView = [[XDAlertView alloc] init];
            selectAlertView.delegate = self;
            [selectAlertView setupText:nil btns:nil isClose:YES];
            [selectAlertView setupSelectBtns:@[@"第一条",@"第二条",@"第三条",@"第四条",@"第五条",@"第六条",@"第七条"] btns:@[@"添加",@"确认"]];
            [self.view.window addSubview:selectAlertView];
            
            break;
        }
        case 2:
        {
            XDAlertView *inputAlertView = [[XDAlertView alloc] init];
            inputAlertView.delegate = self;
            [inputAlertView setupText:nil btns:nil isClose:YES];
            [inputAlertView setupInputView:@"名字" place:@"请输入您的名字" btns:@[@"添加",@"确认"]];
            [self.view.window addSubview:inputAlertView];
            
            break;
        }
        case 3:
        {
            XDAlertView *addAlertView = [[XDAlertView alloc] init];
            addAlertView.delegate = self;
            [addAlertView setupText:nil btns:nil isClose:YES];
            [addAlertView setupSelectBtnsInputView:@[@"组织",@"公司"] titleText:@"请输入组织机构名字" place:@"在此输入" btns:@[@"确认修改"]];
            [self.view.window addSubview:addAlertView];
            break;
        }
        case 4:
        {
            _addselectAlertView = [[XDAlertView alloc] init];
            _addselectAlertView.delegate = self;
            [_addselectAlertView setupText:nil btns:nil isClose:NO];
            [_addselectAlertView setupSelectBtns:@[@"第一条",@"第二条",@"第三条",@"第四条",@"第五条",@"第六条",@"第七条"] btns:@[@"取消"]];
            [self.view.window addSubview:_addselectAlertView];
            
            break;
        }
    
        default:
            break;
    }
}

- (void)alertViewDelegate:(XDAlertView *)alertView btnTag:(NSInteger)btnTag
{
    NSLog(@"点击按钮=%ld 选中的内容=%@  输入的内容 = %@", btnTag, alertView.selectBtnInn.titleLabel.text, alertView.field.text);
}

- (void)alertViewSelectBtnClickDelegate:(XDAlertView *)alertView selectBtn:(XDSelectBtn *)selectBtn
{
    if (_addselectAlertView == alertView) {
        [alertView removeFromSuperview];
        NSLog(@"选中的内容 = %@", selectBtn.titleLabel.text);
    }
}
@end
