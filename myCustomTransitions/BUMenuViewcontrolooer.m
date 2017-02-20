//
//  BUMenuViewcontrolooer.m
//  myCustomTransitions
//
//  Created by BLUE on 17/2/11.
//  Copyright © 2017年 BLUE. All rights reserved.
//

#import "BUMenuViewcontrolooer.h"

@implementation BUMenuViewcontrolooer

//| ----------------------------------------------------------------------------
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    // Certain examples are only supported on iOS 8 and later.
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.f)
    {
        NSArray *iOS7Examples = @[@"CrossDissolve", @"Dynamics", @"Swipe", @"NavigationSlide", @"Slide"];
        
        if ([iOS7Examples containsObject:identifier] == NO) {
            [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can not load example." message:@"This example requires iOS 8 or later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return NO;
        }
    }
    
    return YES;
}


//| ----------------------------------------------------------------------------
- (IBAction)unwindToMenuViewController:(UIStoryboardSegue*)sender
{ }

@end
