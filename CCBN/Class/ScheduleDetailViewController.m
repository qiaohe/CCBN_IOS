//
//  ScheduleDetailViewController.m
//  CCBN
//
//  Created by Jack Wang on 4/7/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "ScheduleDetailViewController.h"

@interface ScheduleDetailViewController ()

@end

@implementation ScheduleDetailViewController
@synthesize eventSchedule = _eventSchedule;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _eventName.text = _eventSchedule.name;
    _location.text = _eventSchedule.place;
    _description.text = _eventSchedule.description;
    NSDateFormatter *timeFormat = [[[NSDateFormatter alloc] init] autorelease];
    [timeFormat setDateFormat:@"hh:mm"];
    _timeDuring.text = [NSString stringWithFormat:@"%@ - %@", [timeFormat stringFromDate:_eventSchedule.dateFrom], [timeFormat stringFromDate:_eventSchedule.dateTo]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_eventName release];
    [_timeDuring release];
    [_location release];
    [_description release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setEventName:nil];
    [self setTimeDuring:nil];
    [self setLocation:nil];
    [self setDescription:nil];
    [super viewDidUnload];
}
@end
