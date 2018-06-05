//
//  ViewController.h
//  01_Mac_RGBConvert
//
//  Created by beyond on 2018/1/5.
//  Copyright © 2018年 beyond. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class SGView;
@interface ViewController : NSViewController

@property (strong) IBOutlet SGView *bgView;
@property (weak) IBOutlet NSTextField *textViewRed;
@property (weak) IBOutlet NSTextField *textViewGreen;
@property (weak) IBOutlet NSTextField *textViewBlue;
@property (weak) IBOutlet NSTextField *labelResult;

- (IBAction)textFieldEntered:(id)sender;
@property (weak) IBOutlet NSTextField *textViewError;

@end

