//
//  Model.h
//  CCBN
//
//  Created by Jack Wang on 2/28/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ASIHTTPRequest.h"

@class HomePageViewController;
@class CCBNViewController;
@class CCBN;

@interface Model : NSObject<ASIHTTPRequestDelegate> {
    BOOL sendingContent;
}

+ (Model *)sharedModel;
@property (nonatomic, retain) NSMutableArray *homeIconList;
@property (nonatomic, retain) HomePageViewController *homePageViewController;
@property (nonatomic, retain) NSString *documentDirectory;
@property (nonatomic, retain) NSMutableArray *icons;
@property (nonatomic, retain) CCBN *ccbn;
@property (nonatomic, retain) NSMutableArray *unreadMSG;
@property (nonatomic, retain) NSMutableArray *messages;
- (void)createFolder:(NSArray *)pathComponents;
- (NSString *)createPath:(NSArray *)pathComponents;
- (void)initWithPlist;
- (void)displayTip:(NSString *)tip modal:(BOOL)modal;
- (void)gotoHomePage;
- (void)gotoPage:(CCBNViewController *)view option:(UIViewAnimationOptions)options;
- (void)addNewMessage:(NSDictionary *)newMsg;
- (void)updateContent;
@end
