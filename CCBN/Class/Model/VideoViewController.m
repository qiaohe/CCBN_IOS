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
@synthesize movieList;
@synthesize movieArray;
@synthesize MovieBackButton;

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
    self.movieArray = [[NSBundle mainBundle]pathsForResourcesOfType:@"mp4" inDirectory:nil];
    
    //UIImage *i = [UIImage imageWithData:<#(NSData *)#> scale:<#(CGFloat)#>]

    /*
    moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:nil ofType:@"mp4"]]];
    //moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"http://main.gslb.ku6.com/s1/-uB39mRMNlp3tpY8/1362461153451/4eb2c9116f00dcc264b487994b7931bb/1369820627493/v592/18/51/4dc3b3185738d179ca6c8d38feb998d2-f4v-h264-aac-1040-32-97757.0-13160040-1362461085794-640fd2c9f33af87e08c318f147426f32-1-00-00-00.f4v?stype=mp4"]];
    moviePlayer.view.frame = CGRectMake(winSize.origin.x, winSize.origin.y, winSize.size.width, winSize.size.height - 20);
    NSLog(@"frame.height = %f",winSize.size.height);
    moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    moviePlayer.controlStyle    = MPMovieControlStyleDefault;
    moviePlayer.scalingMode     = MPMovieScalingModeAspectFit;
    moviePlayer.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:moviePlayer.view];
    [moviePlayer play];*/
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count = %u",[self.movieArray count]);
    return [self.movieArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IdentifierStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierStr];
    }
    NSString *str = [self.movieArray objectAtIndex:indexPath.row];
    NSMutableString *mutableStr = [NSMutableString stringWithString:[str lastPathComponent]];
    NSRange subRange;
    subRange.location = 0;
    subRange.length   = [mutableStr rangeOfString:@".mp4"].location;
    NSString *titleStr = [mutableStr substringWithRange:subRange] ;
    cell.textLabel.text = titleStr;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    moviePlayers = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:[self.movieArray objectAtIndex:indexPath.row]]];
    moviePlayers.view.frame = CGRectMake(winSize.origin.x, winSize.origin.y, winSize.size.width, winSize.size.height - 20);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidChangeNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    
    moviePlayers.moviePlayer.movieSourceType      = MPMovieSourceTypeFile;
    moviePlayers.moviePlayer.controlStyle         = MPMovieControlStyleDefault;
    moviePlayers.moviePlayer.scalingMode          = MPMovieScalingModeAspectFit;
    moviePlayers.moviePlayer.view.backgroundColor = [UIColor grayColor];
    
    self.MovieBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.MovieBackButton setBackgroundImage:[UIImage imageNamed:@"home_btn@2x.png"] forState:UIControlStateNormal];
    [self.MovieBackButton setBackgroundImage:[UIImage imageNamed:@"home_active_btn@2x.png"] forState:UIControlStateHighlighted];
    [self.MovieBackButton addTarget:self.moviePlayers action:@selector(dismissModalViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    self.MovieBackButton.backgroundColor = [UIColor clearColor];
    self.MovieBackButton.hidden          = YES;
    self.MovieBackButton.frame = CGRectMake(winSize.size.width/2 - 25, winSize.size.height/2 - 25, 50, 50);
    [self.moviePlayers.view addSubview:self.MovieBackButton];
    
    [self presentViewController:self.moviePlayers animated:YES completion:nil];
    [moviePlayers.moviePlayer play];
}

- (void)playDidChangeNotification:(NSNotification *)notification {
    MPMoviePlayerController *moviePlay = notification.object;
    MPMoviePlaybackState playState = moviePlay.playbackState;
    if (playState == MPMoviePlaybackStateStopped) {
        NSLog(@"停止");
    } else if(playState == MPMoviePlaybackStatePlaying) {
        NSLog(@"播放");
        self.MovieBackButton.hidden = YES;
    } else if(playState == MPMoviePlaybackStatePaused) {
        NSLog(@"暂停");
        self.MovieBackButton.hidden = NO;
    }
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
/*
- (BOOL)shouldAutorotate{
    //NSLog(@"heihei");
    //return YES;
}
- (NSUInteger)supportedInterfaceOrientations{
    //NSLog(@"huhu");
    //return 4;
}*/

- (void)requestFailed:(ASIHTTPRequest *)request{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.moviePlayer     release];
    [self.moviePlayers    release];
    [self.movieList       release];
    [self.movieArray      release];
    [self.MovieBackButton release];
    [super                dealloc];
}

@end
