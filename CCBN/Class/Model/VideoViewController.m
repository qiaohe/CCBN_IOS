//
//  VideoViewController.m
//  CCBN
//
//  Created by 马 宏亮 on 13-6-4.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

@synthesize moviePlayer;
@synthesize moviePlayers;
@synthesize tableViewController;

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
    winSize = [[UIScreen mainScreen]bounds];
    moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:nil ofType:@"mp4"]]];
    //moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://main.gslb.ku6.com/s1/-uB39mRMNlp3tpY8/1362461153451/4eb2c9116f00dcc264b487994b7931bb/1369820627493/v592/18/51/4dc3b3185738d179ca6c8d38feb998d2-f4v-h264-aac-1040-32-97757.0-13160040-1362461085794-640fd2c9f33af87e08c318f147426f32-1-00-00-00.f4v?stype=mp4"]];
    moviePlayer.view.frame = CGRectMake(winSize.origin.x, winSize.origin.y, winSize.size.width, winSize.size.height - 20);
    NSLog(@"frame.height = %f",winSize.size.height);
    moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    moviePlayer.controlStyle    = MPMovieControlStyleDefault;
    moviePlayer.scalingMode     = MPMovieScalingModeAspectFit;
    moviePlayer.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:moviePlayer.view];
    [moviePlayer play];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSData *data = [request responseData];
    NSString *dbpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *videoPath = [dbpath stringByAppendingFormat:@"/movie.mp4"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:videoPath]) {
        [fm createFileAtPath:videoPath contents:data attributes:nil];
    }
    NSLog(@"requestFinished");
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [moviePlayer release];
    [super dealloc];
}

@end
