//
//  AppDelegate.m
//  CCBN
//
//  Created by Jack Wang on 3/14/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "TransitionController.h"
#import "Model.h"
#import "ASIFormDataRequest.h"

BMKMapManager* _mapManager;
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [_transitionController release];
    [super dealloc];
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize transitionController = _transitionController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if !TARGET_IPHONE_SIMULATOR
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
#endif
    
    _mapManager = [[BMKMapManager alloc]init];
	BOOL ret = [_mapManager start:@"10BEF7303406E979C0C22322FD0976E683EAA83D" generalDelegate:self];
	if (!ret) {
		NSLog(@"manager start failed!");
	}
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [Model sharedModel].homePageViewController = [[[HomePageViewController alloc] init] autorelease];
    self.transitionController = [[[TransitionController alloc] initWithViewController:[Model sharedModel].homePageViewController] autorelease];
    
    
    NSDictionary *pushNotificationPayload = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(pushNotificationPayload) {
        for (id key in pushNotificationPayload) {
            NSLog(@"key: %@, value: %@ \n", key, [pushNotificationPayload objectForKey:key]);
        }
        //[[Model sharedModel] addNewMessage:pushNotificationPayload];
        [self application:application didReceiveRemoteNotification:pushNotificationPayload];
    }
    
    self.window.rootViewController = self.transitionController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[Model sharedModel] addNewMessage:userInfo];
    [[Model sharedModel] playMessageSound];
}

#pragma mark -
#pragma mark Remote notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // You can send here, for example, an asynchronous HTTP request to your web-server to store this deviceToken remotely.
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *currentDeviceToken = [[token stringByReplacingOccurrencesOfString:@" " withString:@""] retain];
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if(![userInfo boolForKey:@"registerTokenSucc"] || ![currentDeviceToken isEqualToString:[userInfo objectForKey:@"deviceToken"]])
    {
        NSLog(@"Did register for remote notifications: %@", currentDeviceToken);
        [userInfo setValue:currentDeviceToken forKey:@"deviceToken"];
        [userInfo synchronize];
        //send token and nick name to push server
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/exhibition/api/attendees/", ServerURL]];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        //[request setPostFormat:ASIMultipartFormDataPostFormat];
        //[request setPostValue:deviceToken forKey:@"serviceToken"];
        //[request setPostValue:@"CCBN" forKey:@"exhibitionCode"];
        //[request setPostValue:@"IOS" forKey:@"mobilePlatform"];
        [request addRequestHeader:@"Content-Type" value:@"application/json"];
        [request addRequestHeader:@"Accept" value:@"application/json"];
        NSString *postJson = [NSString stringWithFormat:@"{\"serviceToken\":\"%@\", \"exhibitionCode\":\"CCBN\", \"mobilePlatform\":\"IOS\"}", currentDeviceToken];
        [request appendPostData:[postJson  dataUsingEncoding:NSUTF8StringEncoding]];
        [request setRequestMethod:@"POST"];
        [request setTimeOutSeconds:60];
        request.delegate = self;
        [request startAsynchronous];
    }
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Fail to register for remote notifications: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CCBN" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CCBN.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    if([responseString isEqualToString:@""]){
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        [userInfo setBool:YES forKey:@"registerTokenSucc"];
        [userInfo synchronize];
    }
    NSLog(@"result:%@", responseString);
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Registration push token failed.");
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setBool:NO forKey:@"registerTokenSucc"];
    [userInfo synchronize];
}

#pragma mark - BMKGeneralDelegate
- (void)onGetNetworkState:(int)iError
{
}

- (void)onGetPermissionState:(int)iError
{
}
@end
