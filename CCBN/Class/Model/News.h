//
//  News.h
//  CCBN
//
//  Created by 马 宏亮 on 13-5-31.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject{
    NSString  *NewsTitle;
    double    NewsDate;
    NSString  *NewsContent;
}

@property (nonatomic, retain) NSString  *NewsTitle;
@property (nonatomic, assign) double NewsDate;
@property (nonatomic, retain) NSString  *NewsContent;

@end
