//
//  AboutUsViewController.m
//  CCBN
//
//  Created by Jack Wang on 4/5/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Model.h"
#import "CCBN.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

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
    [_aboutUsDescriptioin loadHTMLString:[Model sharedModel].ccbn.description baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_aboutUsDescriptioin release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setAboutUsDescriptioin:nil];
    [super viewDidUnload];
}
@end
