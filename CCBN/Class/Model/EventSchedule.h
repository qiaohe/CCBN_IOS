//
//  EventSchedules.h
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "IData.h"

@interface EventSchedule : IData
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *place;
@property (nonatomic, retain) NSDate *dateFrom;
@property (nonatomic, retain) NSDate *dateTo;
@end
