//
//  Message.m
//  CCBN
//
//  Created by Jack Wang on 4/5/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "Message.h"

@implementation Message
@synthesize msg = _msg;
@synthesize date = _date;


- (id)initWithPData:(NSObject *)data
{
    if ((self = [super init]))
    {
        _msg = [[(NSDictionary *)data objectForKey:@"message"] retain];
        _date = [[(NSDictionary *)data objectForKey:@"date"] retain];
    }
    
    return self;
}
- (NSObject *)getPData {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            _msg, @"message",
            _date, @"date",
            nil];
}

@end
