//
//  SGView.h
//  01_Mac_RGBConvert
//
//  Created by beyond on 2018/1/5.
//  Copyright © 2018年 beyond. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// 自定义NSView是为了 监听事件
@interface SGView : NSView

// 重写的目的是鼠标单击空白区域时,发出通知,让控制器进行计算
-(void)mouseDown:(NSEvent *)theEvent;
@end
