//
//  Message.h
//  CCBN
//
//  Created by Jack Wang on 4/5/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "IData.h"

@interface Message : IData
@property (nonatomic, retain) NSString *msg;
@property (nonatomic, retain) NSDate *date;
@end
