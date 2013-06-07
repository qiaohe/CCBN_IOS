//
//  NewsViewController.m
//  CCBN
//
//  Created by 马 宏亮 on 13-5-31.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

@synthesize NewsList;
@synthesize NewsArray;

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
    NSLog(@"URL = %@",_REQUEST_URL_);
    self.NewsArray = [[NSMutableArray alloc]init];
    [self loadData];
	// Do any additional setup after loading the view.
}

- (void)loadData{
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:_REQUEST_URL_]];
    request.delegate = self;
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    [self.NewsArray removeAllObjects];
    NSString *requestStr = [request responseString];
    
    NSArray *JsonStr = [requestStr JSONValue];
    for (NSDictionary *e in JsonStr) {
        News *aNew = [[News alloc]init];
        aNew.NewsTitle   = [e objectForKey:@"title"];
        aNew.NewsDate    =  [[e objectForKey:@"date"]doubleValue];
        aNew.NewsContent = [e objectForKey:@"content"];
        [self.NewsArray addObject:aNew];
    }
    [self.NewsList reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.NewsArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Title_ID = @"Title_ID";
    UITableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:Title_ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Title_ID];
    }
    News *aNew = [self.NewsArray objectAtIndex:indexPath.row];
    NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
    cell.textLabel.font       = [UIFont systemFontOfSize:16];
    cell.textLabel.text       = aNew.NewsTitle;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:aNew.NewsDate/1000];

    NSString *NowDate = [dateFormat stringFromDate:date];
    date = [date dateByAddingTimeInterval:timeZoneOffset];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"发布时间:%@",NowDate];
    [dateFormat release];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row);
    NewsContentViewController *contentViewController = [[NewsContentViewController alloc]initWithNibName:@"NewsContentViewController" bundle:nil];
    contentViewController.aNew = [self.NewsArray objectAtIndex:indexPath.row];
    [[Model sharedModel] gotoPage:contentViewController option:UIViewAnimationOptionCurveLinear];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.NewsList  release];
    [self.NewsArray release];
    [super          dealloc];
}

@end
