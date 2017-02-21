//
//  BUTabBarVCDelegate.h
//  myCustomTransitions
//
//  Created by guopu on 2017/2/21.
//  Copyright © 2017年 BLUE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUTabBarVCDelegate : NSObject <UITabBarControllerDelegate>

@property (nonatomic, assign) BOOL interactive;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end
