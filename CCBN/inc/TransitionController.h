//
//  TransitionController.h
//
//  Created by XJones on 11/25/11.
//

#import <UIKit/UIKit.h>
#import "TipViewController.h"
#import "CCBNViewController.h"

@interface TransitionController : CCBNViewController {
    TipViewController *tipViewController;
}

@property (nonatomic, retain) IBOutlet UIView *                containerView;
@property (nonatomic, retain) IBOutlet UIViewController *      viewController;

- (id)initWithViewController:(UIViewController *)viewController;
- (void)transitionToViewController:(UIViewController *)viewController
                       withOptions:(UIViewAnimationOptions)options;

- (void)displayTip:(NSString *)tip modal:(BOOL)modal;

@end
