//
//  CCBNViewController.h
//  CCBN
//
//  Created by Jack Wang on 3/24/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderViewController.h"

@interface CCBNViewController : UIViewController {
    NSString *_headingText;
}

@property (nonatomic, retain) HeaderViewController *headerViewController;

- (BOOL) hasHeader;
- (void) setHeader:(NSString *)header;
- (NSString *) getHeader;
@end
