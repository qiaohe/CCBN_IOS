//
//  VideoViewController.h
//  CCBN
//
//  Created by 马 宏亮 on 13-6-4.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "CCBNViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ASIHTTPRequest.h"


@interface VideoViewController : CCBNViewController<MPMediaPickerControllerDelegate,ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>{
    MPMoviePlayerController     *moviePlayer;
    MPMoviePlayerViewController *moviePlayers;
    UITableView                 *tableViewController;
    CGRect                      winSize;
}

@property (nonatomic, strong) IBOutlet MPMoviePlayerController     *moviePlayer;
@property (nonatomic, strong) IBOutlet MPMoviePlayerViewController *moviePlayers;
@property (nonatomic, strong) IBOutlet UITableView                 *tableViewController;

@end
