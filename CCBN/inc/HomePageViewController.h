//
//  HomePageViewController.h
//  CCBN
//
//  Created by Jack Wang on 3/24/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBNViewController.h"
#import "IconViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ASIFormDataRequest.h"
#import "BMapKit.h"

@interface HomePageViewController : CCBNViewController<UIScrollViewDelegate, IconViewControllerDelegate, CLLocationManagerDelegate, ASIHTTPRequestDelegate, BMKSearchDelegate> {
    NSTimer *timer;
    CGPoint lastPosition;
    CGPoint lastScrollOffset;
    NSMutableArray *iconViewControllers;
    IconViewController *currentIconViewController;
    CLLocationManager *locationManager;
    BMKSearch* _search;
}
@property (retain, nonatomic) IBOutlet UIImageView *theADImage;
@property (retain, nonatomic) IBOutlet UIScrollView *appIconsContainer;
@property (retain, nonatomic) IBOutlet UIPageControl *thePageControl;
@property (nonatomic, retain) CLLocation *bestEffortAtLocation;

@end
