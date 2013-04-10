//
//  ExhibitorDetailViewController.m
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "ExhibitorDetailViewController.h"
#import "Exhibitor.h"

@interface ExhibitorDetailViewController ()

@end

@implementation ExhibitorDetailViewController
@synthesize exhibitor = _exhibitor;

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
    _theCompanyLabel.text = _exhibitor.company;
    _theLocationLabel.text = _exhibitor.location;
    _theAddressLabel.text = _exhibitor.address;
    _theDescriptionLabel.text = _exhibitor.description;
    _thePhoneLabel.text = _exhibitor.phone;
    _theWebSiteLabel.text = _exhibitor.website;
    _theAddressLabel.numberOfLines = 0;
    [_theAddressLabel sizeToFit];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) hasHeader{
    return YES;
}

- (void)dealloc {
    [_theCompanyLabel release];
    [_theLocationLabel release];
    [_theAddressLabel release];
    [_thePhoneLabel release];
    [_theWebSiteLabel release];
    [_theDescriptionLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTheCompanyLabel:nil];
    [self setTheLocationLabel:nil];
    [self setTheAddressLabel:nil];
    [self setThePhoneLabel:nil];
    [self setTheWebSiteLabel:nil];
    [self setTheDescriptionLabel:nil];
    [super viewDidUnload];
}
@end
