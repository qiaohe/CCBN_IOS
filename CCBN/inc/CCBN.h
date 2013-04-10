//
//  CCBN.h
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "IData.h"

@interface CCBN : IData
@property (nonatomic, retain) NSDate *updatedAt;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSString *organizer;
@property (nonatomic, retain) NSMutableArray *speakers;
@property (nonatomic, retain) NSMutableArray *exhibitors;
@property (nonatomic, retain) NSMutableArray *eventSchedules;
@property (nonatomic, retain) NSDate *latestUpdateTime;

@end
