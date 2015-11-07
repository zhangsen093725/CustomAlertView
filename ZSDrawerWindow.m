//
//  ZSDrawerWindow.m
//  
//
//  Created by 张森 on 15/10/18.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import "ZSDrawerWindow.h"

#define KSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZSDrawerWindow ()<UIGestureRecognizerDelegate>
@property (nonatomic ,weak) UIView * leftView;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIWindow *spaceWindow;
@end

@implementation ZSDrawerWindow
+ (instancetype)drawerWindowManager
{
    static ZSDrawerWindow * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}
static CGFloat windowY = 20;
static CGFloat windowBottom = 0;
static CGFloat alpha = 0.1;
static CGFloat space = 100;
- (UIWindow *)createWindowWithController:(UIViewController *)controller
{
    UIWindow *window = [[UIWindow alloc]init];
    window.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:alpha];
    window.hidden = NO;
    window.rootViewController = controller;
    controller.view.frame = window.bounds;
    return window;
}

- (void)setDrawerWindowDefualtWithTopController:(UIViewController *)controller andSpace:(CGFloat)leftSpace
{
    space = leftSpace;
    [self setDrawerDefualtSpaceView];
    self.window = [self createWindowWithController:controller];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.frame = CGRectMake(KSCREENWIDTH, windowY, KSCREENWIDTH - space, KSCREENHEIGHT);
    [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.window.frame = CGRectMake(space, windowY, KSCREENWIDTH - space, KSCREENHEIGHT);
    } completion:nil];
}

- (void)setDrawerWindowCustomWithTopController:(UIViewController *)controller space:(CGFloat)leftSpace windowY:(CGFloat)y windowSpaceToBottoom:(CGFloat)bottom  backWindowAlpha:(CGFloat)backWindowAlpha;
{
    windowBottom = bottom;
    windowY = y;
    alpha = backWindowAlpha;
    space = leftSpace;
    [self setDrawerDefualtSpaceView];
    self.window = [self createWindowWithController:controller];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.frame = CGRectMake(KSCREENWIDTH, windowY, KSCREENWIDTH - space, KSCREENHEIGHT - windowY - windowBottom );
    [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.window.frame = CGRectMake(space, windowY, KSCREENWIDTH - space, KSCREENHEIGHT - windowY - windowBottom);
    } completion:nil];
}

- (void)setDrawerDefualtSpaceView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    self.spaceWindow = [self createWindowWithController:nil];
    self.spaceWindow.windowLevel = UIWindowLevelStatusBar;
    self.spaceWindow.frame = CGRectMake(0, windowY, KSCREENWIDTH, KSCREENHEIGHT - windowY - windowBottom);
    [self.spaceWindow addGestureRecognizer:pan];
    [self.spaceWindow addGestureRecognizer:tap];
}

static CGFloat height = 0;
- (void)setdrawerWindowAlterWithTopControler:(UIViewController *)controller height:(CGFloat)height
{
    height = height;
    [self setDrawerAlterSpaceView];
     self.window = [self createWindowWithController:controller];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, height);
    [UIView animateWithDuration:0.3 animations:^{
        self.window.frame = CGRectMake(0, KSCREENHEIGHT - height, KSCREENWIDTH, height);
    }];
}
- (void)setDrawerAlterSpaceView
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alterBack)];
    self.spaceWindow = [self createWindowWithController:nil];
    self.spaceWindow.windowLevel = UIWindowLevelStatusBar;
    self.spaceWindow.frame = CGRectMake(0, 0, KSCREENWIDTH, KSCREENHEIGHT);
    [self.spaceWindow addGestureRecognizer:tap];
}

- (void)alterBack
{
    if (!self.window) {
        self.spaceWindow = nil;
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.window.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, height);
    } completion:^(BOOL finished) {
        self.spaceWindow = nil;
        self.window  = nil;
    }];
}

- (void)back
{
    if (!self.window) {
        self.spaceWindow = nil;
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
         self.window.frame = CGRectMake(KSCREENWIDTH, windowY, KSCREENWIDTH - space, KSCREENHEIGHT - windowY - windowBottom);
    } completion:^(BOOL finished) {
        self.spaceWindow = nil;
        self.window  = nil;
    }];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.spaceWindow];
     CGRect rect = self.window.frame;
    if (point.x + space > space) {
        rect.origin.x = point.x + space;
        self.window.frame = rect;
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (point.x + space > self.spaceWindow.frame.size.width / 2) {
            rect.origin.x = self.spaceWindow.frame.size.width;
        }else{
            rect.origin.x = space;
        }
        [UIView animateWithDuration:self.window.frame.origin.x / self.window.frame.size.width * 0.25 animations:^{
            self.window.frame = rect;
        } completion:^(BOOL finished) {
            if (rect.origin.x > space) {
                [self back];
            }
        }];
    }
}

@end
