//
//  ZSWindow.h
//  ZSCustomWindow
//
//  Created by 张森 on 15/12/15.
//  Copyright © 2015年 张森. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CustomerWindowType){
    CustomerWindowDrawer,
    CustomerWindowSheet,
    CustomerWindowAlert
};

@interface ZSWindow : NSObject
@property (nonatomic ,assign) BOOL isNeedTapGesture;

+ (instancetype)windowManager;
/**
 *  创建需要弹出的控制器,在对应的控制器中需要调用prefersStatusBarHidden方法为返回为NO
 */
- (void)setDrawerWindowDefualtShowController:(UIViewController *)controller space:(CGFloat)space;
/**
 *  创建需要弹出的自定义控制器，在对应的控制器中需要调用prefersStatusBarHidden方法为返回为NO
 */
- (void)setDrawerWindowCustomType:(CustomerWindowType)CustomerWindowType ShowController:(UIViewController *)controller left:(CGFloat)left right:(CGFloat)right top:(CGFloat)top bottoom:(CGFloat)bottom  alpha:(CGFloat)alpha;

- (void)back;
@end
