//
//  Exhibitor.m
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "Exhibitor.h"

@implementation Exhibitor
@synthesize company = _company;
@synthesize address = _address;
@synthesize website = _website;
@synthesize location = _location;
@synthesize phone = _phone;
@synthesize description = _description;


- (id)initWithJSONData:(NSDictionary *)data
{
    if ((self = [super init]))
    {
        _company = [[data objectForKey:@"company"] retain];
        _address = [[data objectForKey:@"address"] retain];
        _website = [[data objectForKey:@"website"] retain];
        _location = [[data objectForKey:@"location"] retain];
        _phone = [[data objectForKey:@"phone"] retain];
        _description = [[data objectForKey:@"description"] retain];
    }
    
    return self;
}

-(NSString *)getExhibitorLocation {
    return [_location substringWithRange:NSMakeRange(1, 1)];
}
@end
