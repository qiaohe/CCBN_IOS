//
//  News.h
//  CCBN
//
//  Created by 马 宏亮 on 13-5-31.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject{
    NSString *NewsTitle;
    NSString *NewsDate;
    NSString *NewsContent;
}

@property (nonatomic, retain) NSString *NewsTitle;
@property (nonatomic, retain) NSString *NewsDate;
@property (nonatomic, retain) NSString *NewsContent;

@end
