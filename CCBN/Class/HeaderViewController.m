//
//  HeaderViewController.m
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "HeaderViewController.h"
#import "Model.h"

@interface HeaderViewController ()

@end

@implementation HeaderViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_headingText release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setHeadingText:nil];
    [super viewDidUnload];
}
- (IBAction)homeTapped:(id)sender {
    [[Model sharedModel] gotoHomePage];
}
@end
