//
//  SpeakerDetailViewControlle.h
//  CCBN
//
//  Created by Jack Wang on 4/5/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "CCBNViewController.h"
#import "Speaker.h"

@interface SpeakerDetailViewControlle : CCBNViewController
@property (retain, nonatomic) IBOutlet UIImageView *thePhoto;
@property (retain, nonatomic) IBOutlet UILabel *theNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *thePositionLabel;
@property (retain, nonatomic) IBOutlet UILabel *theCompanyLabel;
@property (retain, nonatomic) IBOutlet UITextView *theDescrition;

@property (retain, nonatomic) Speaker *speaker;
@end
