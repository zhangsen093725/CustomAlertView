//
//  ZSWindow.h
//  ZSCustomWindow
//
//  Created by 张森 on 15/12/15.
//  Copyright © 2015年 张森. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define KSCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

static CGFloat _windowBottom = 0;
static CGFloat _space = 100;
static CGFloat _windowY = 20;
static CGFloat _alpha = 0.1;
static CGFloat _height = 0;

@interface ZSWindow : NSObject
@property (nonatomic, strong) UIWindow *window;
+ (instancetype)windowManager;
- (void)setDrawerDefualtSpaceView:(UIViewController *)controller;
- (void)setDrawerAlterSpaceView:(UIViewController *)controller;
- (UIWindow *)createWindowWithController:(UIViewController *)controller;
- (void)back;
- (void)alterBack;
- (void)seetAlterBack;
@end
