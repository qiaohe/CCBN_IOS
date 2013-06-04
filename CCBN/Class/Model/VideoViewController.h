//
//  VideoViewController.h
//  CCBN
//
//  Created by 马 宏亮 on 13-6-4.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "CCBNViewController.h"
#import <MediaPlayer/MediaPlayer.h>


@interface VideoViewController : CCBNViewController<MPMediaPickerControllerDelegate>{
    MPMoviePlayerController     *moviePlayer;
    UITableViewController       *tableViewController;
    
}

@property (nonatomic, strong) IBOutlet MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) UITableViewController            *tableViewController;

@end
