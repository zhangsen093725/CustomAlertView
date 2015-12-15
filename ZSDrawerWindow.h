//
//  ZSDrawerWindow.h
//  
//
//  Created by 张森 on 15/10/18.
//  Copyright (c) 2015年 张森. All rights reserved.
//

#import "ZSWindow.h"

@interface ZSDrawerWindow : ZSWindow
/**
 *  创建需要弹出的控制器,space为需要留出的空隙宽度
 *
 *  @param controller <#controller description#>
 *  @param space      <#space description#>
 */
- (void)setDrawerWindowDefualtWithTopController:(UIViewController *)controller backgroundController:(UIViewController *)backController space:(CGFloat)leftSpace;
/**
 *  创建需要弹出的控制器,space为需要留出的空隙宽度
 *
 *  @param controller <#controller description#>
 *  @param space      <#space description#>
 */
- (void)setDrawerWindowCustomWithTopController:(UIViewController *)controller backgroundController:(UIViewController *)backController space:(CGFloat)leftSpace windowY:(CGFloat)y windowSpaceToBottoom:(CGFloat)bottom  backgroundAlpha:(CGFloat)backAlpha;
- (void)back;
@end
