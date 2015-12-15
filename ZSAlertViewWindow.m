//
//  ZSAlertViewWindow.m
//  ZSCustomWindow
//
//  Created by 张森 on 15/12/15.
//  Copyright © 2015年 张森. All rights reserved.
//

#import "ZSAlertViewWindow.h"

@implementation ZSAlertViewWindow
#pragma mark --- 自定义的SheetAlert

- (void)setdrawerWindowSheetAlertWithTopControler:(UIViewController *)controller backgroundController:(UIViewController *)backController height:(CGFloat)height{
    _height = height;
    [self setDrawerAlterSpaceView:backController];
    self.window = [self createWindowWithController:controller];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, height);
    [UIView animateWithDuration:0.3 animations:^{
        self.window.frame = CGRectMake(0, KSCREENHEIGHT - height, KSCREENWIDTH, height);
    }];
}

// AlertView
- (void)setdrawerWindowAlterWithTopControler:(UIViewController *)controller backgroundController:(UIViewController *)backController height:(CGFloat)height{
    [self setDrawerAlterSpaceView:backController];
    self.window = [self createWindowWithController:controller];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.frame = CGRectMake(60, KSCREENHEIGHT *0.5 - height*0.5, KSCREENWIDTH - 120, height);
    self.window.layer.cornerRadius = 20;
    self.window.clipsToBounds = YES;
}

- (void)alterBack{
    [super alterBack];
}

@end
