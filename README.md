# XDAlertView
自定义警示框

## 纯文本警示框

纯文本警示框，指定下面按钮(按钮只支持1-2个)，还可以指定右上角是否有关闭按钮，方法中的`isClose`设置为`YES`显示，设置为`NO`不显示

![image](http://oalg33nuc.bkt.clouddn.com/image/Simulator%20Screen%20Shot%202016%E5%B9%B48%E6%9C%883%E6%97%A5%20%E4%B8%8B%E5%8D%885.01.19.png)

```Objective-C
XDAlertView *alertView = [[XDAlertView alloc] init];
alertView.delegate = self;
[alertView setupText:@"显示弹出内容" btns:@[@"取消",@"确认"] isClose:NO];
[self.view.window addSubview:alertView];
```

## 选择按钮警示框

选择按钮警示框，选中之后点击确认触发后续操作。选项支持多个，多个滑动显示。

![image](http://oalg33nuc.bkt.clouddn.com/image/Simulator%20Screen%20Shot%202016%E5%B9%B48%E6%9C%883%E6%97%A5%20%E4%B8%8B%E5%8D%885.02.48.png)

```Objective-C
XDAlertView *selectAlertView = [[XDAlertView alloc] init];
selectAlertView.delegate = self;
[selectAlertView setupText:nil btns:nil isClose:YES];
[selectAlertView setupSelectBtns:@[@"第一条",@"第二条",@"第三条",@"第四条",@"第五条",@"第六条",@"第七条"] btns:@[@"添加",@"确认"]];
[self.view.window addSubview:selectAlertView];
```

## 输入框式警示框

可以设置一个输入框标题+一个输入框。

![image](http://oalg33nuc.bkt.clouddn.com/image/Simulator%20Screen%20Shot%202016%E5%B9%B48%E6%9C%883%E6%97%A5%20%E4%B8%8B%E5%8D%885.01.35.png)

```Objective-C
XDAlertView *inputAlertView = [[XDAlertView alloc] init];
inputAlertView.delegate = self;
[inputAlertView setupText:nil btns:nil isClose:YES];
[inputAlertView setupInputView:@"名字" place:@"请输入您的名字" btns:@[@"添加",@"确认"]];
[self.view.window addSubview:inputAlertView];
```

## 选择按钮和警示框同时存在

支持多个选择按钮，但是`y`值相同，呈一行排列，按钮过多会拥挤。

![image](http://oalg33nuc.bkt.clouddn.com/image/Simulator%20Screen%20Shot%202016%E5%B9%B48%E6%9C%883%E6%97%A5%20%E4%B8%8B%E5%8D%885.02.34.png)

```Objective-C
XDAlertView *addAlertView = [[XDAlertView alloc] init];
addAlertView.delegate = self;
[addAlertView setupText:nil btns:nil isClose:YES];
[addAlertView setupSelectBtnsInputView:@[@"组织",@"公司"] titleText:@"请输入组织机构名字" place:@"在此输入" btns:@[@"确认修改"]];
[self.view.window addSubview:addAlertView];
```

**以上几个方法对应下面代理方法**

```Objective-C
- (void)alertViewDelegate:(XDAlertView *)alertView btnTag:(NSInteger)btnTag
{
NSLog(@"点击按钮=%ld 选中的内容=%@  输入的内容 = %@", btnTag, alertView.selectBtnInn.titleLabel.text, alertView.field.text);
}
```

## 选择按钮触发结果

选择按钮触发结果的用法和选择按钮警示框是一样的，只是实现了另一个代理方法，如果与其他带选择按钮的警示框处于同一个控制器，需要判断警示框

![image](http://oalg33nuc.bkt.clouddn.com/image/Simulator%20Screen%20Shot%202016%E5%B9%B48%E6%9C%883%E6%97%A5%20%E4%B8%8B%E5%8D%885.02.40.png)

```Objective-C
_addselectAlertView = [[XDAlertView alloc] init];
_addselectAlertView.delegate = self;
[_addselectAlertView setupText:nil btns:nil isClose:NO];
[_addselectAlertView setupSelectBtns:@[@"第一条",@"第二条",@"第三条",@"第四条",@"第五条",@"第六条",@"第七条"] btns:@[@"取消"]];
[self.view.window addSubview:_addselectAlertView];
```

实现代理方法

```Objective-C
- (void)alertViewSelectBtnClickDelegate:(XDAlertView *)alertView selectBtn:(XDSelectBtn *)selectBtn
{
    if (_addselectAlertView == alertView) {
        [alertView removeFromSuperview];
        NSLog(@"选中的内容 = %@", selectBtn.titleLabel.text);
    }
}
```