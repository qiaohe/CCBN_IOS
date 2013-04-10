//
//  Exhibitor.h
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "IData.h"

@interface Exhibitor : IData
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *website;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *description;

-(NSString *)getExhibitorLocation;

@end
