//
//  PopViewController.m
//  myCustomTransitions
//
//  Created by BLUE on 17/2/11.
//  Copyright © 2017年 BLUE. All rights reserved.
//

#import "PopViewController.h"
#import "BUNavigationControllerDelegate.h"

@interface PopViewController ()

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *edgePanGesture;
@property (nonatomic, strong)  BUNavigationControllerDelegate *navigationDelegate;

@end

@implementation PopViewController

- (void)dealloc {
    [_edgePanGesture removeTarget:self action:@selector(handleEdgePanGesture:)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePanGesture:)];
    _edgePanGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_edgePanGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)gesture{
    
    CGFloat translationX = [gesture translationInView:self.view].x;
    CGFloat translationBase = self.view.frame.size.width / 3;
    CGFloat translationAbs = translationX > 0 ? translationX : -translationX;
    CGFloat percent = translationAbs > translationBase ? 1.0 : translationAbs / translationBase;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            _navigationDelegate =(BUNavigationControllerDelegate *) self.navigationController.delegate;
            _navigationDelegate.interactive = YES;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            [_navigationDelegate.interactionController updateInteractiveTransition:percent];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            if (percent > 0.5) {
                [_navigationDelegate.interactionController finishInteractiveTransition];
            }else{
                [_navigationDelegate.interactionController cancelInteractiveTransition];
            }
            _navigationDelegate.interactive = NO;
            break;
        }
            
        default:
            break;
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
