//
//  SpeakerDetailViewControlle.m
//  CCBN
//
//  Created by Jack Wang on 4/5/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "SpeakerDetailViewControlle.h"

@interface SpeakerDetailViewControlle ()

@end

@implementation SpeakerDetailViewControlle
@synthesize speaker = _speaker;

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
    _thePhoto.image = [_speaker getSpeakerPhotoImage];
    _theNameLabel.text = _speaker.name;
    _thePositionLabel.text = _speaker.position;
    _theCompanyLabel.text = _speaker.company;
    _theDescrition.text = _speaker.profile;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_thePhoto release];
    [_theNameLabel release];
    [_thePositionLabel release];
    [_theCompanyLabel release];
    [_theDescrition release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setThePhoto:nil];
    [self setTheNameLabel:nil];
    [self setThePositionLabel:nil];
    [self setTheCompanyLabel:nil];
    [self setTheDescrition:nil];
    [super viewDidUnload];
}
@end
