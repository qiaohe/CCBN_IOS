//
//  NewsViewController.h
//  CCBN
//
//  Created by 马 宏亮 on 13-5-31.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "CCBNViewController.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "NewsContentViewController.h"

#define _REQUEST_URL_ @"http://180.168.35.37:8080/exhibition/api/web/CCBN/news"

@interface NewsViewController : CCBNViewController<UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>{
    UITableView    *NewsList;
    NSMutableArray *NewsArray;
}

@property (nonatomic, strong) IBOutlet UITableView    *NewsList;
@property (nonatomic, strong) NSMutableArray *NewsArray;

@end
