//
//  ZSDrawerWindow.h
//  
//
//  Created by 张森 on 15/10/18.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZSDrawerWindow : NSObject
+ (instancetype)drawerWindowManager;
/**
 *  创建需要弹出的控制器,space为需要留出的空隙宽度
 *
 *  @param controller <#controller description#>
 *  @param space      <#space description#>
 */
- (void)setDrawerWindowDefualtWithTopController:(UIViewController *)controller andSpace:(CGFloat)leftSpace;
/**
 *  创建需要弹出的控制器,space为需要留出的空隙宽度
 *
 *  @param controller <#controller description#>
 *  @param space      <#space description#>
 */
- (void)setDrawerWindowCustomWithTopController:(UIViewController *)controller space:(CGFloat)leftSpace windowY:(CGFloat)y windowSpaceToBottoom:(CGFloat)bottom  backWindowAlpha:(CGFloat)backWindowAlpha;

- (void)setdrawerWindowAlterWithTopControler:(UIViewController *)controller height:(CGFloat)height;
/**
 *   返回
 */
- (void)back;
- (void)alterBack;
@end
