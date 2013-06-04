//
//  SettingViewController.h
//  CCBN
//
//  Created by Jack Wang on 4/15/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "CCBNViewController.h"

@interface SettingViewController : CCBNViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *typeGroup;
    NSMutableDictionary *typeVSExhibitors;
}

@end
