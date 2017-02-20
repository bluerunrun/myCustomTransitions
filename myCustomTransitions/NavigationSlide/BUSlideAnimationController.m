//
//  BUSlideAnimationController.m
//  myCustomTransitions
//
//  Created by BLUE on 17/2/11.
//  Copyright © 2017年 BLUE. All rights reserved.
//

#import "BUSlideAnimationController.h"

@interface BUSlideAnimationController ()

@property (nonatomic, assign) BUTransitionType transitionType;

@end


@implementation BUSlideAnimationController

- (instancetype)initWithTransitionType:(BUTransitionType)type {
    
    if ( self = [super init]) {
        self.transitionType = type;
    }
    return self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.30;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    
    CGFloat translation = containerView.frame.size.width;
    CGAffineTransform toViewTransform = CGAffineTransformIdentity;
    CGAffineTransform fromViewTransform = CGAffineTransformIdentity;
    
    switch (self.transitionType) {
        case Transition_Navigation_Push:
        case Transition_Navigation_Pop:
        {
            translation =  self.transitionType==Transition_Navigation_Push? translation : -translation ;
            toViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            fromViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
        }
            
            break;
        case Transition_Tab_Left:
        case Transition_Tab_Right:
        {
            translation =  self.transitionType==Transition_Tab_Left? translation : -translation ;
            fromViewTransform = CGAffineTransformMakeTranslation(translation, 0);
            toViewTransform = CGAffineTransformMakeTranslation(-translation, 0);
        }
        
        case Transition_Modal_Presentation:
        case Transition_Modal_Dismissal:
        {
            translation =  containerView.frame.size.height;
            toViewTransform = CGAffineTransformMakeTranslation( 0, (self.transitionType == Transition_Modal_Presentation ? translation : 0));
            fromViewTransform = CGAffineTransformMakeTranslation( 0, (self.transitionType == Transition_Modal_Presentation ? 0 : translation));
        }
            
        default:
            break;
    }
    
    switch (self.transitionType) {
        case Transition_Modal_Dismissal:
            break;
        default:
            [containerView addSubview:toView];
            break;
    }
    
    toView.transform = toViewTransform;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
    
        fromView.transform = fromViewTransform;
        toView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
    
        fromView.transform = CGAffineTransformIdentity;
        toView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
    
}

@end
