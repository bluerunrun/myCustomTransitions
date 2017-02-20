//
//  BUSlideAnimationController.h
//  myCustomTransitions
//
//  Created by BLUE on 17/2/11.
//  Copyright © 2017年 BLUE. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BUTransitionType) {
    Transition_Navigation_Push = 0,
    Transition_Navigation_Pop = 1,
    Transition_Tab_Left = 2,
    Transition_Tab_Right = 3,
    Transition_Modal_Presentation= 4,
    Transition_Modal_Dismissal = 5
};

@interface BUSlideAnimationController : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithTransitionType:(BUTransitionType)type;

@end
