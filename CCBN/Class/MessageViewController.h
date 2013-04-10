//
//  MessageViewController.h
//  CCBN
//
//  Created by Jack Wang on 4/1/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "CCBNViewController.h"

@interface MessageViewController : CCBNViewController<UITableViewDataSource, UITableViewDelegate>{
    NSDateFormatter *format;
}
@property (retain, nonatomic) IBOutlet UITableView *messageTable;

@end
