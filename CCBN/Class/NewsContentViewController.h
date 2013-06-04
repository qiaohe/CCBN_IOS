//
//  NewsContentViewController.h
//  CCBN
//
//  Created by 马 宏亮 on 13-5-31.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "CCBNViewController.h"
#import "News.h"
#import "Model.h"

@interface NewsContentViewController : CCBNViewController{
    UIWebView *webView;
    News      *aNew;
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, retain) News  *aNew;

@end
