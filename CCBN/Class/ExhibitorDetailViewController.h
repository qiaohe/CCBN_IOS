//
//  ExhibitorDetailViewController.h
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "CCBNViewController.h"
@class Exhibitor;

@interface ExhibitorDetailViewController : CCBNViewController

@property (retain, nonatomic) IBOutlet UILabel *theCompanyLabel;
@property (retain, nonatomic) IBOutlet UILabel *theLocationLabel;
@property (retain, nonatomic) IBOutlet UILabel *theAddressLabel;
@property (retain, nonatomic) IBOutlet UILabel *thePhoneLabel;
@property (retain, nonatomic) IBOutlet UILabel *theWebSiteLabel;
@property (retain, nonatomic) IBOutlet UITextView *theDescriptionLabel;

@property (retain, nonatomic) Exhibitor *exhibitor;
@end
