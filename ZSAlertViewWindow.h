//
//  ZSAlertViewWindow.h
//  ZSCustomWindow
//
//  Created by 张森 on 15/12/15.
//  Copyright © 2015年 张森. All rights reserved.
//

#import "ZSWindow.h"

@interface ZSAlertViewWindow : ZSWindow

- (void)setdrawerWindowSheetAlertWithTopControler:(UIViewController *)controller backgroundController:(UIViewController *)backController height:(CGFloat)height;

- (void)setdrawerWindowAlterWithTopControler:(UIViewController *)controller backgroundController:(UIViewController *)backController height:(CGFloat)height;

- (void)alterBack;
@end
