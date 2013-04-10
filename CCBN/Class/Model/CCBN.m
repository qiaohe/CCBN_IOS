//
//  CCBN.m
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "CCBN.h"
#import "Speaker.h"
#import "Exhibitor.h"
#import "EventSchedule.h"

@implementation CCBN
@synthesize updatedAt = _updatedAt;
@synthesize name = _name;
@synthesize description = _description;
@synthesize address = _address;
@synthesize startDate = _startDate;
@synthesize endDate = _endDate;
@synthesize organizer = _organizer;
@synthesize speakers = _speakers;
@synthesize exhibitors = _exhibitors;
@synthesize eventSchedules = _eventSchedules;
@synthesize latestUpdateTime = _latestUpdateTime;

- (id)initWithJSONData:(NSDictionary *)data
{
    if ((self = [super init]))
    {
        _updatedAt = [[NSDate dateWithTimeIntervalSince1970:[[data objectForKey:@"updatedAt"] doubleValue]/1000] retain];
        _name = [[data objectForKey:@"name"] retain];
        _description = [[data objectForKey:@"description"] retain];
        _address = [[data objectForKey:@"address"] retain];
        _organizer = [[data objectForKey:@"organizer"] retain];
        
        _speakers = [[NSMutableArray alloc] init];
        Speaker *speaker;
        for (NSDictionary *speakerJson in [data objectForKey:@"speakers"]) {
            speaker = [[Speaker alloc] initWithJSONData:speakerJson];
            [_speakers addObject:speaker];
            [speaker release];
        }
        
        _exhibitors = [[NSMutableArray alloc] init];
        Exhibitor *exhibitor;
        for (NSDictionary *exhibitorJson in [data objectForKey:@"exhibitors"]) {
            exhibitor = [[Exhibitor alloc] initWithJSONData:exhibitorJson];
            [_exhibitors addObject:exhibitor];
            [exhibitor release];
        }
        
        _eventSchedules = [[NSMutableArray alloc] init];
        EventSchedule *eventSchedule;
        for (NSDictionary *exhibitorJson in [data objectForKey:@"eventSchedules"]) {
            eventSchedule = [[EventSchedule alloc] initWithJSONData:exhibitorJson];
            [_eventSchedules addObject:eventSchedule];
            [eventSchedule release];
        }
        
        [_eventSchedules sortUsingComparator:^ NSComparisonResult(EventSchedule *e1, EventSchedule *e2)
         {
             if([e1.dateFrom compare:e2.dateFrom] == 0)
                 return [e1.dateTo compare:e2.dateTo];
             else
                 return [e1.dateFrom compare:e2.dateFrom];
         }];
    }

    return self;
}

@end
