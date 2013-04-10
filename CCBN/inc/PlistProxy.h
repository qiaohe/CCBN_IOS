//
//  PlistProxy.h
//  CCBN
//
//  Created by Jack Wang on 3/24/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

@interface PlistProxy : NSObject
{
    NSString *iconsPlist;
    NSString *messagesPlist;
    
    NSMutableDictionary *paths;
	NSMutableDictionary *datas;
	NSMutableDictionary *dataObjects;
}

+ (PlistProxy *)sharedPlistProxy;

- (NSArray *)getIcons;
- (void)updateIcons;

- (NSArray *)getMessages;
- (void)updateMessages;
@end
