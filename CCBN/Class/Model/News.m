//
//  News.m
//  CCBN
//
//  Created by 马 宏亮 on 13-5-31.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "News.h"

@implementation News

@synthesize NewsTitle;
@synthesize NewsDate;
@synthesize NewsContent;


-(void) dealloc{
    [self.NewsTitle   release];
    [self.NewsContent release];
    [super            dealloc];
}

@end
