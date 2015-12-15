//
//  ZSDrawerWindow.m
//  
//
//  Created by 张森 on 15/10/18.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import "ZSDrawerWindow.h"
@interface ZSDrawerWindow ()
@property (nonatomic ,weak) UIView * leftView;
@end

@implementation ZSDrawerWindow

// 默认的状态
- (void)setDrawerWindowDefualtWithTopController:(UIViewController *)controller backgroundController:(UIViewController *)backController space:(CGFloat)leftSpace{
    _space = leftSpace;
    [self setDrawerDefualtSpaceView:backController];
    self.window = [self createWindowWithController:controller];
    self.window.frame = CGRectMake(KSCREENWIDTH, _windowY, KSCREENWIDTH - _space, KSCREENHEIGHT);
    [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.window.frame = CGRectMake(_space, _windowY, KSCREENWIDTH - _space, KSCREENHEIGHT);
    } completion:nil];
}

// 自定义的状态
- (void)setDrawerWindowCustomWithTopController:(UIViewController *)controller backgroundController:(UIViewController *)backController space:(CGFloat)leftSpace windowY:(CGFloat)y windowSpaceToBottoom:(CGFloat)bottom  backgroundAlpha:(CGFloat)backAlpha{
    _windowBottom = bottom;
    _windowY = y;
    _alpha = backAlpha;
    _space = leftSpace;
    [self setDrawerDefualtSpaceView:backController];
    self.window = [self createWindowWithController:controller];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.frame = CGRectMake(KSCREENWIDTH, _windowY, KSCREENWIDTH - _space, KSCREENHEIGHT - _windowY - _windowBottom );
    [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.window.frame = CGRectMake(_space, _windowY, KSCREENWIDTH - _space, KSCREENHEIGHT - _windowY - _windowBottom);
    } completion:nil];
}

- (void)back{
    [super back];
}

@end
