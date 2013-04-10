//
//  IconViewController.h
//  CCBN
//
//  Created by Jack Wang on 3/24/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

@protocol IconViewControllerDelegate;

@class Icon;
@class BadgeViewController;

@interface IconViewController : UIViewController
{
    id<IconViewControllerDelegate> delegate;
    UIImageView *cover;
    UILabel *theTitle;
    UILongPressGestureRecognizer *longPressGR;
    UITapGestureRecognizer *singleTap;
    
    BOOL isWiggling;
    CGPoint startPosition;
    Icon *icon;
    BadgeViewController *badgeViewController;
}

@property (nonatomic, assign) id<IconViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIImageView *cover;
@property (nonatomic, retain) IBOutlet UILabel *theTitle;
@property (nonatomic) BOOL isWiggling;
@property (nonatomic, assign) Icon *icon;
@property (nonatomic) CGPoint startPosition;
@property (nonatomic, retain) BadgeViewController *badgeViewController;

- (IBAction)iconTapped:(id)sender;
- (void)playWiggle;
- (void)stopWiggle;

@end

@protocol IconViewControllerDelegate <NSObject>

- (void)iconSelected:(Icon *)icon;
@optional
- (void)longPressBegan:(IconViewController *)sender;
- (void)longPressEnd:(IconViewController *)sender;
- (void)shouldMove:(IconViewController *)sender position:(CGPoint)position;

@end