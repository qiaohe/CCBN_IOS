//
//  ExhibitorMapViewController.h
//  CCBN
//
//  Created by Jack Wang on 4/15/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "CCBNViewController.h"
#import "BMapKit.h"
#import "BMCustomButton.h"
#import <QuartzCore/QuartzCore.h>

#define _BY_BUS_  301
#define _BY_CAR_  302
#define _BY_FOOT_ 303


@interface ExhibitorMapViewController : CCBNViewController<BMKMapViewDelegate,BMKAnnotation,BMKSearchDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    IBOutlet BMKMapView    *mapView;
    CGRect                 winSize;
    BMKSearch              *search;
    CLLocationCoordinate2D CCBNLocation;
    NSInteger              Vehicle;
    NSInteger              LastVehicle;
    CGRect                 OldFrame;
    BMKPlanResult          *RoutesPlan;
    BOOL                   IsFirstUpdate;
    BOOL                   SearchViewIsShow;
    BOOL                   IsSearch;
}

@end
