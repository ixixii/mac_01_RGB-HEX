//
//  ViewController.m
//  01_Mac_RGBConvert
//
//  Created by beyond on 2018/1/5.
//  Copyright © 2018年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "SGView.h"
@implementation ViewController
    
- (void)viewDidAppear
{
    [super viewDidAppear];
    
    [self.view.window setTitle:@"RGB转HEX"];
    // 设置背景色
    _bgView.layer.backgroundColor = [NSColor colorWithRed:204.0/255 green:232.0/255 blue:207.0/255 alpha:1].CGColor;
    [_bgView setNeedsDisplay:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mouseDownNotification:) name:@"sgview_mousedown" object:nil];
    
    // 一开始就获取光标
    [_textViewRed becomeFirstResponder];
}

- (void)mouseDownNotification:(NSNotification *)noti
{
    [self abstract_inputFinished];
}

- (IBAction)textFieldEntered:(id)sender {
    [self abstract_inputFinished];
}

#pragma mark - 计算
// 逻辑判断
- (void)abstract_inputFinished
{
    NSLog(@"sg__输入框发生事件");
    // 输入框是不是有内容
    BOOL isHasValue = ([[_textViewRed stringValue] length] > 0)  && ([[_textViewGreen stringValue] length] > 0) && [[_textViewBlue stringValue] length] > 0;
    
    // 判断是不是全是数字
    BOOL isNumber = [self isNumber:[_textViewRed stringValue]] && [self isNumber:[_textViewGreen stringValue]] && [self isNumber:[_textViewBlue stringValue]];
    
    // 输入框的数字是否合理
    BOOL isValueRangeOK = ([_textViewRed integerValue] <= 255 && [_textViewRed integerValue] >= 0)&&([_textViewGreen integerValue] <= 255 && [_textViewGreen integerValue] >= 0)&&([_textViewBlue integerValue] <= 255 && [_textViewBlue integerValue] >= 0);
    
    if (isHasValue && isValueRangeOK && isNumber) {
        _textViewError.hidden = YES;
        _labelResult.hidden = NO;
        [self calc_hex];
    }
    
    // 全输入了,但是值的范围不正确,或者 不全是数字的时候,提示错误信息
    if (isHasValue && (!isValueRangeOK || !isNumber)) {
        _textViewError.stringValue = @"输入有误";
        _textViewError.hidden = NO;
        
        _labelResult.hidden = YES;
    }
    
    // 没有输完全的时候,不显示
    if (!isHasValue) {
        _labelResult.hidden = YES;
    }
}

// 正则判断是不是数字
- (BOOL) isNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

// 将字符串转成十六进制
- (void)calc_hex
{
    NSString *redStr = [_textViewRed stringValue];
    NSString *hexRedStr = [ViewController ToHex:[redStr integerValue]];
    if (hexRedStr.length == 1) {
        hexRedStr = [@"0" stringByAppendingString:hexRedStr];
    }
    
    NSString *greenStr = [_textViewGreen stringValue];
    NSString *hexGreenStr = [ViewController ToHex:[greenStr integerValue]];
    if (hexGreenStr.length == 1) {
        hexGreenStr = [@"0" stringByAppendingString:hexGreenStr];
    }
    
    NSString *blueStr = [_textViewBlue stringValue];
    NSString *hexBlueStr = [ViewController ToHex:[blueStr integerValue]];
    if (hexBlueStr.length == 1) {
        hexBlueStr = [@"0" stringByAppendingString:hexBlueStr];
    }
    
    NSString *totalStr = [NSString stringWithFormat:@"0x %@%@%@",hexRedStr,hexGreenStr,hexBlueStr];
    _labelResult.stringValue = totalStr;
    _labelResult.hidden = NO;
    
    NSLog(@"sg__点击了屏幕:%@",[ViewController ToHex:[redStr integerValue]]);
    ;
}

//10进制转16进制
+(NSString *)ToHex:(long long int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i =0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc] initWithFormat:@"%lli",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    return str;
    
}
@end
