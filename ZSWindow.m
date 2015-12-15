//
//  ZSWindow.m
//  ZSCustomWindow
//
//  Created by 张森 on 15/12/15.
//  Copyright © 2015年 张森. All rights reserved.
//

#import "ZSWindow.h"

@interface ZSWindow()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *spaceView;
@end

@implementation ZSWindow
static ZSWindow * manager = nil;
+ (instancetype)windowManager{
    if([manager isKindOfClass:self])
        return manager;
    manager = [[self alloc]init];
    return manager;
}

// 背景遮盖
- (void)setDrawerDefualtSpaceView:(UIViewController *)controller
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    self.spaceView = [self createSpaceViewWithController:controller];
    self.spaceView.frame = CGRectMake(0, _windowY, KSCREENWIDTH, KSCREENHEIGHT - _windowY - _windowBottom);
    [self.spaceView addGestureRecognizer:pan];
    [self.spaceView addGestureRecognizer:tap];
}

- (UIWindow *)createWindowWithController:(UIViewController *)controller
{
    UIWindow *window = [[UIWindow alloc]init];
    window.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:_alpha];
    window.hidden = NO;
    controller.view.frame = window.bounds;
    window.rootViewController = controller;
    return window;
}

- (UIView *)createSpaceViewWithController:(UIViewController *)controller{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = _alpha;
    [controller.view addSubview:view];
    return view;
}

- (void)setDrawerAlterSpaceView:(UIViewController *)controller{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alterBack)];
    self.spaceView = [self createSpaceViewWithController:controller];
    self.spaceView.frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT);
    [self.spaceView addGestureRecognizer:tap];
}

#pragma mark --- 退出
- (void)back
{
    if (!self.window) {
        [self.spaceView removeFromSuperview];
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.window.frame = CGRectMake(KSCREENWIDTH, _windowY, KSCREENWIDTH - _space, KSCREENHEIGHT - _windowY - _windowBottom);
    } completion:^(BOOL finished) {
        self.window  = nil;
        [self.spaceView removeFromSuperview];
    }];
    
}

- (void)seetAlterBack{
    [UIView animateWithDuration:0.2 animations:^{
        self.window.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, _height);
    } completion:^(BOOL finished) {
        self.window  = nil;
        [self.spaceView removeFromSuperview];
        
    }];

}

- (void)alterBack
{
    if (!self.window) {
        [self.spaceView removeFromSuperview];
        return;
    }
    [self.window resignKeyWindow];
    self.window  = nil;
    [self.spaceView removeFromSuperview];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.spaceView];
    CGRect rect = self.window.frame;
    if (point.x + _space > _space) {
        rect.origin.x = point.x + _space;
        self.window.frame = rect;
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (point.x + _space > self.spaceView.frame.size.width / 2) {
            rect.origin.x = self.spaceView.frame.size.width;
        }else{
            rect.origin.x = _space;
        }
        [UIView animateWithDuration:self.window.frame.origin.x / self.window.frame.size.width * 0.25 animations:^{
            self.window.frame = rect;
        } completion:^(BOOL finished) {
            if (rect.origin.x > _space) {
                [self back];
            }
        }];
    }
}


@end
