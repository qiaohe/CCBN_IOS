//
//  EventSchedules.m
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "EventSchedule.h"

@implementation EventSchedule
@synthesize name = _name;
@synthesize description = _description;
@synthesize place = _place;
@synthesize dateFrom = _dateFrom;
@synthesize dateTo = _dateTo;

- (id)initWithJSONData:(NSDictionary *)data
{
    if ((self = [super init]))
    {
        _name = [[data objectForKey:@"name"] retain];
        _description = [[data objectForKey:@"description"] retain];
        _place = [[data objectForKey:@"place"] retain];
        _dateFrom = [[NSDate dateWithTimeIntervalSince1970:[[data objectForKey:@"dateFrom"] doubleValue]/1000] retain];
        _dateTo = [[NSDate dateWithTimeIntervalSince1970:[[data objectForKey:@"dateTo"] doubleValue]/1000] retain];
    }
    
    return self;
}
@end
