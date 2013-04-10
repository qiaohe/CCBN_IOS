//
//  ExhibitorViewController.h
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBNViewController.h"

@interface ExhibitorViewController : CCBNViewController<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *typeGroup;
    NSMutableDictionary *typeVSExhibitors;
}

@end
