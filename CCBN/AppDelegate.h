//
//  AppDelegate.h
//  CCBN
//
//  Created by Jack Wang on 3/14/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "BMapKit.h"

@class HomePageViewController;
@class TransitionController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, ASIHTTPRequestDelegate, BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) IBOutlet TransitionController *transitionController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
