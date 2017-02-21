//
//  BUNavigationControllerDelegate.m
//  myCustomTransitions
//
//  Created by BLUE on 17/2/11.
//  Copyright © 2017年 BLUE. All rights reserved.
//

#import "BUNavigationControllerDelegate.h"

@implementation BUNavigationControllerDelegate

-(instancetype)init{
    if (self = [super init]) {
        _interactive = NO;
        _interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    BUTransitionType type = operation == UINavigationControllerOperationPush?Transition_Navigation_Push:Transition_Navigation_Pop;
    return [[BUSlideAnimationController alloc] initWithTransitionType:type];
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.interactive? self.interactionController:nil;
}

@end
