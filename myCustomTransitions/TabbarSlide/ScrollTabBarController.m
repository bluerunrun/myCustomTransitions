//
//  ScrollTabBarController.m
//  myCustomTransitions
//
//  Created by guopu on 2017/2/21.
//  Copyright © 2017年 BLUE. All rights reserved.
//

#import "ScrollTabBarController.h"
#import "BUTabBarVCDelegate.h"
#import "AAPLSlideTransitionInteractionController.h"

@interface ScrollTabBarController ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong)  BUTabBarVCDelegate *tabBarVCDelegate;
@property (nonatomic, assign) int subViewControllerCount;

@end

@implementation ScrollTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBarVCDelegate = [[BUTabBarVCDelegate alloc] init];
    self.delegate = self.tabBarVCDelegate;
//    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerDidPan:)];
    [self.view addGestureRecognizer:self.panGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 原生交互控制器
-(int)subViewControllerCount{
    return self.viewControllers != nil ? (int)self.viewControllers.count : 0;
}

- (void)handlePan:(UIPanGestureRecognizer*)panGesture {
    
    CGFloat translationX = [_panGesture translationInView:self.view].x;
    CGFloat translationAbs = translationX > 0 ? translationX : -translationX;
    CGFloat progress = translationAbs / self.view.frame.size.width;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.tabBarVCDelegate.interactive = YES;
            CGFloat velocityX = [panGesture velocityInView:self.view].x;
            if (velocityX < 0) {
                if (self.selectedIndex < self.subViewControllerCount -1) {
                        self.selectedIndex += 1;
                }
            }else {
                if (self.selectedIndex > 0){
                    self.selectedIndex -= 1;
                }
            }
            break;
        case UIGestureRecognizerStateChanged:
            [self.tabBarVCDelegate.interactionController updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            /*这里有个小问题，转场结束或是取消时有很大几率出现动画不正常的问题。在8.1以上版本的模拟器中都有发现，7.x 由于缺乏条件尚未测试，
             但在我的 iOS 9.2 的真机设备上没有发现，而且似乎只在 UITabBarController 的交互转场中发现了这个问题。在 NavigationController 暂且没发现这个问题，
             Modal 转场尚未测试，因为我在 Demo 里没给它添加交互控制功能。
    
             测试不完整，具体原因也未知，不过解决手段找到了。多谢 @llwenDeng 发现这个 Bug 并且找到了解决手段。
             解决手段是修改交互控制器的 completionSpeed 为1以下的数值，这个属性用来控制动画速度，我猜测是内部实现在边界判断上有问题。
             这里其修改为0.99，既解决了 Bug 同时尽可能贴近原来的动画设定。
             */
            if (progress > 0.3){
                self.tabBarVCDelegate.interactionController.completionSpeed = 0.99;
                [self.tabBarVCDelegate.interactionController finishInteractiveTransition];
            }else{
                //转场取消后，UITabBarController 自动恢复了 selectedIndex 的值，不需要我们手动恢复。
                self.tabBarVCDelegate.interactionController.completionSpeed = 0.99;
                [self.tabBarVCDelegate.interactionController cancelInteractiveTransition];
            }
            self.tabBarVCDelegate.interactive = NO;
            break;
            
        default:
            break;
    }

}


#pragma mark - 自定义交互控制器
//| ----------------------------------------------------------------------------
//! Action method for the panGestureRecognizer.
//
- (IBAction)panGestureRecognizerDidPan:(UIPanGestureRecognizer*)sender
{
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            self.tabBarVCDelegate.interactionController = [[AAPLSlideTransitionInteractionController alloc] initWithGestureRecognizer:self.panGesture];
             self.tabBarVCDelegate.interactive = YES;
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            
            self.tabBarVCDelegate.interactive = NO;
            break;
        default:
            break;
    }
    
    // Do not attempt to begin an interactive transition if one is already
    // ongoing
    if (self.transitionCoordinator)
        return;
    
    if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged)
        [self beginInteractiveTransitionIfPossible:sender];
    
    // Remaining cases are handled by the vended
    // AAPLSlideTransitionInteractionController.
}


//| ----------------------------------------------------------------------------
//! Begins an interactive transition with the provided gesture recognizer, if
//! there is a view controller to transition to.
//
- (void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.view];
    
    if (translation.x > 0.f && self.selectedIndex > 0) {
        // Panning right, transition to the left view controller.
        self.selectedIndex--;
    } else if (translation.x < 0.f && self.selectedIndex + 1 < self.viewControllers.count) {
        // Panning left, transition to the right view controller.
        self.selectedIndex++;
    } else {
        // Don't reset the gesture recognizer if we skipped starting the
        // transition because we don't have a translation yet (and thus, could
        // not determine the transition direction).
        if (!CGPointEqualToPoint(translation, CGPointZero)) {
            // There is not a view controller to transition to, force the
            // gesture recognizer to fail.
            sender.enabled = NO;
            sender.enabled = YES;
        }
    }
    
    // We must handle the case in which the user begins panning but then
    // reverses direction without lifting their finger.  The transition
    // should seamlessly switch to revealing the correct view controller
    // for the new direction.
    //
    // The approach presented in this demonstration relies on coordination
    // between this object and the AAPLSlideTransitionInteractionController
    // it vends.  If the AAPLSlideTransitionInteractionController detects
    // that the current position of the user's touch along the horizontal
    // axis has crossed over the initial position, it cancels the
    // transition.  A completion block is attached to the tab bar
    // controller's transition coordinator.  This block will be called when
    // the transition completes or is cancelled.  If the transition was
    // cancelled but the gesture recgonzier has not transitioned to the
    // ended or failed state, a new transition to the proper view controller
    // is started, and new animation + interaction controllers are created.
    //
    [self.transitionCoordinator animateAlongsideTransition:NULL completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if ([context isCancelled] && sender.state == UIGestureRecognizerStateChanged)
            [self beginInteractiveTransitionIfPossible:sender];
    }];
}

@end
