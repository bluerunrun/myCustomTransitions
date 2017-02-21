//
//  BUTabBarVCDelegate.m
//  myCustomTransitions
//
//  Created by guopu on 2017/2/21.
//  Copyright © 2017年 BLUE. All rights reserved.
//

#import "BUTabBarVCDelegate.h"
#import "BUSlideAnimationController.h"
#import "AAPLSlideTransitionAnimator.h"

@implementation BUTabBarVCDelegate

-(instancetype)init{
    if (self = [super init]) {
        _interactive = NO;
        _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
//    NSUInteger fromIndex = [[tabBarController viewControllers] indexOfObject:fromVC];
//    NSUInteger toIndex = [[tabBarController viewControllers] indexOfObject:toVC];
//    BUTransitionType transitionType = toIndex < fromIndex ? Transition_Tab_Left : Transition_Tab_Right;
//    BUSlideAnimationController *slideAnimationController = [[BUSlideAnimationController alloc] initWithTransitionType:transitionType];
//    return slideAnimationController;
    
    NSArray *viewControllers = tabBarController.viewControllers;
    if ([viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC]) {
        // The incoming view controller succeeds the outgoing view controller,
        // slide towards the left.
        return [[AAPLSlideTransitionAnimator alloc] initWithTargetEdge:UIRectEdgeLeft];
    } else {
        // The incoming view controller precedes the outgoing view controller,
        // slide towards the right.
        return [[AAPLSlideTransitionAnimator alloc] initWithTargetEdge:UIRectEdgeRight];
    }
}


-(id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.interactive? self.interactionController:nil;
}

@end
