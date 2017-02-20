//
//  BUNavigationControllerDelegate.h
//  myCustomTransitions
//
//  Created by BLUE on 17/2/11.
//  Copyright © 2017年 BLUE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUSlideAnimationController.h"

@interface BUNavigationControllerDelegate : NSObject <UINavigationControllerDelegate>

@property (nonatomic,  assign) BOOL interactive;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;

@end
