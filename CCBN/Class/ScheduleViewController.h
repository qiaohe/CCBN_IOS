//
//  EventsViewController.h
//  CCBN
//
//  Created by Jack Wang on 4/6/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBNViewController.h"

@interface ScheduleViewController : CCBNViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *typeGroup;
    NSMutableDictionary *typeVSExhibitors;
    NSDateFormatter *dayFormat;
    NSDateFormatter *timeFormat;
}

@end