//
//  ZSWindow.m
//  ZSCustomWindow
//
//  Created by 张森 on 15/12/15.
//  Copyright © 2015年 张森. All rights reserved.
//

#import "ZSWindow.h"

#define KSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZSWindow()<UIGestureRecognizerDelegate>{
    CustomerWindowType _customerWindowType;
}
@property (nonatomic, strong) UIView *spaceView;
@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat alpha;
@end

@implementation ZSWindow

+ (instancetype)windowManager{
    static ZSWindow * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    [manager initSpace];
    return manager;
}

- (void)initSpace{
    _bottom = 0;
    _left = 100;
    _right = 0;
    _top = 20;
    _alpha = 0.1;
}

- (void)setIsNeedTapGesture:(BOOL)isNeedTapGesture{
    if (isNeedTapGesture) {
        [self tapGesture];
    }
}

// 默认的状态
- (void)setDrawerWindowDefualtShowController:(UIViewController *)controller space:(CGFloat)space{
    _customerWindowType = 0;
    _left = space;
    [self setDrawerBackView];
    [self drawerController:controller];
}

// 自定义的状态
- (void)setDrawerWindowCustomType:(CustomerWindowType)CustomerWindowType ShowController:(UIViewController *)controller left:(CGFloat)left right:(CGFloat)right top:(CGFloat)top bottoom:(CGFloat)bottom  alpha:(CGFloat)alpha{
    
    _top = top;
    _left = left;
    _right = right;
    _bottom = bottom;
    _alpha = alpha;
    _customerWindowType = CustomerWindowType;
    
    switch (CustomerWindowType) {
        case CustomerWindowDrawer:
            [self setDrawerBackView];
            [self drawerController:controller];
            break;
        case CustomerWindowSheet:
            [self createSpaceView];
            [self sheetController:controller];
            break;
        case CustomerWindowAlert:
            [self createSpaceView];
            [self alterController:controller];
            break;
        default:
            break;
    }
}

- (void)tapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [self.spaceView addGestureRecognizer:tap];

}

// 背景遮盖
- (void)setDrawerBackView{
    [self createSpaceView];
    [self tapGesture];
      UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.spaceView addGestureRecognizer:pan];
}

#pragma mark --- 不同的控制器
- (void)drawerController:(UIViewController *)controller{
    [self createWindowController:controller];
    self.window.frame = CGRectMake(KSCREENWIDTH, _top, KSCREENWIDTH - _left - _right, KSCREENHEIGHT- _top - _bottom);
    [self animationFrame:CGRectMake(_left, _top, KSCREENWIDTH - _left, KSCREENHEIGHT - _top - _bottom) Alpha:_alpha isBack:NO];
}

- (void)sheetController:(UIViewController *)controller{
    [self createWindowController:controller];
    self.window.frame = CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH, KSCREENHEIGHT - _top);
    [self animationFrame:CGRectMake(0, _top, KSCREENWIDTH, KSCREENHEIGHT - _top) Alpha:_alpha isBack:NO];
}

- (void)alterController:(UIViewController *)controller{
    [self createWindowController:controller];
    [UIView animateWithDuration:0.25 animations:^{
        self.spaceView.alpha = _alpha;
    }];
    self.window.frame = CGRectMake(_left , (_top+_bottom)*0.5, KSCREENWIDTH-_left-_right, KSCREENHEIGHT-_top-_bottom);
    self.window.layer.cornerRadius = 20;
    self.window.clipsToBounds = YES;
}

- (void)createWindowController:(UIViewController *)controller{
    UIWindow *window = [[UIWindow alloc]init];
    window.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:_alpha];
    window.hidden = NO;
    controller.view.frame = window.bounds;
    window.rootViewController = controller;
    self.window = window;
}

- (void)createSpaceView{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    self.spaceView = view;
    self.spaceView.frame = CGRectMake(0, 20, KSCREENWIDTH, KSCREENHEIGHT);
}

#pragma mark --- 退出
- (void)back
{
    if (!self.window) {
        [self.spaceView removeFromSuperview];
        return;
    }
    
    switch (_customerWindowType) {
        case CustomerWindowAlert:
            [self alterBack];
            break;
        case CustomerWindowSheet:
            [self sheetBack];
            break;
        case CustomerWindowDrawer:
            [self drawerBack];
            break;
        default:
            break;
    }
}

- (void)drawerBack{
    [self animationFrame:CGRectMake(KSCREENWIDTH, _top, KSCREENWIDTH - _left, KSCREENHEIGHT - _top - _bottom) Alpha:0 isBack:YES];
}

- (void)sheetBack{
    [self animationFrame:CGRectMake(0, KSCREENHEIGHT, KSCREENWIDTH , KSCREENHEIGHT - _top - _bottom) Alpha:0 isBack:YES];
}

- (void)alterBack{
    [UIView animateWithDuration:0.25 animations:^{
        self.spaceView.alpha = 0;
    } completion:^(BOOL finished) {
        [self destroy];
    }];
}

- (void)animationFrame:(CGRect)frame Alpha:(CGFloat)alpha isBack:(BOOL)isBack{
    [UIView animateWithDuration:0.25 animations:^{
        self.window.frame = frame;
        self.spaceView.alpha = alpha;
    } completion:^(BOOL finished) {
        if (isBack) {
            [self destroy];
        }
    }];
}

- (void)destroy{
    self.window.hidden = YES;
    self.window  = nil;
    [self.spaceView removeFromSuperview];
    self.spaceView = nil;
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self.spaceView];
    CGRect rect = self.window.frame;
    if (point.x + _left > _left) {
        rect.origin.x = point.x + _left;
        self.window.frame = rect;
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (point.x + _left > self.spaceView.frame.size.width / 2) {
            rect.origin.x = self.spaceView.frame.size.width;
        }else{
            rect.origin.x = _left;
        }
        [UIView animateWithDuration:self.window.frame.origin.x / self.window.frame.size.width * 0.25 animations:^{
            self.window.frame = rect;
        } completion:^(BOOL finished) {
            if (rect.origin.x > _left) {
                [self drawerBack];
            }
        }];
    }
}

@end
