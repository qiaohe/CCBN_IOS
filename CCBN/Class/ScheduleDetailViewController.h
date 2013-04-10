//
//  ScheduleDetailViewController.h
//  CCBN
//
//  Created by Jack Wang on 4/7/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventSchedule.h"
#import "CCBNViewController.h"

@interface ScheduleDetailViewController : CCBNViewController

@property (retain, nonatomic) IBOutlet UILabel *eventName;
@property (retain, nonatomic) IBOutlet UILabel *timeDuring;
@property (retain, nonatomic) IBOutlet UILabel *location;
@property (retain, nonatomic) IBOutlet UITextView *description;
@property (retain, nonatomic) EventSchedule *eventSchedule;
@end
