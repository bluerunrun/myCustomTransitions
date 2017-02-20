//
//  BUExternalStoryboardSegue.m
//  myCustomTransitions
//
//  Created by BLUE on 17/2/11.
//  Copyright © 2017年 BLUE. All rights reserved.
//

#import "BUExternalStoryboardSegue.h"

@implementation BUExternalStoryboardSegue

//| ----------------------------------------------------------------------------
- (instancetype)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    // Load the storyboard named by this segue's identifier.
    UIStoryboard *externalStoryboard = [UIStoryboard storyboardWithName:identifier bundle:[NSBundle bundleForClass:self.class]];
    
    // Instantiate the storyboard's initial view controller.
    id initialViewController = [externalStoryboard instantiateInitialViewController];
    
    return [super initWithIdentifier:identifier source:source destination:initialViewController];
}


//| ----------------------------------------------------------------------------
- (void)perform
{
    [self.sourceViewController presentViewController:self.destinationViewController animated:YES completion:NULL];
}


@end
