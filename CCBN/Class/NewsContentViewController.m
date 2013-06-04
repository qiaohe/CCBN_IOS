//
//  NewsContentViewController.m
//  CCBN
//
//  Created by 马 宏亮 on 13-5-31.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "NewsContentViewController.h"

@interface NewsContentViewController ()

@end

@implementation NewsContentViewController

@synthesize webView;
@synthesize aNew;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void) loadData{
    [self.webView loadHTMLString:self.aNew.NewsContent baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [webView release];
    [super   dealloc];
}

@end
