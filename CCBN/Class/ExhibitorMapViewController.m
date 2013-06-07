//
//  ExhibitorMapViewController.m
//  CCBN
//
//  Created by Jack Wang on 4/15/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "ExhibitorMapViewController.h"

@interface ExhibitorMapViewController ()

@end

@implementation ExhibitorMapViewController


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
    
    
    [self ReloadData];
}

-(void)ReloadData{
    winSize = [[UIScreen mainScreen]bounds];
    SearchViewIsShow = NO;
    IsFirstUpdate    = YES;
    IsSearch         = NO;
    BMCustomButton *searchBtn = [[[BMCustomButton alloc]initWithWidth:winSize.size.width/10 andOrigin:CGPointMake(winSize.size.width*9/10, winSize.size.height - (winSize.size.width/10 + winSize.size.width/10*3)/2)]autorelease];
    searchBtn.winSize = winSize;
    [searchBtn.titleButton setBackgroundImage:[UIImage imageNamed:@"icon_route_search_button_normal@2x.png"] forState:UIControlStateNormal];
    [searchBtn.titleButton setBackgroundImage:[UIImage imageNamed:@"icon_route_search_button_pressed@2x.png"]  forState:UIControlStateHighlighted];
    searchBtn.titleLabel.text = @"路线";
    [searchBtn.titleButton addTarget:self action:@selector(Searchs:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn.Btn addTarget:self action:@selector(Searchs:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn addSubview:searchBtn.Btn];
    [self.view addSubview:searchBtn];
    
    UIView   *view       = [[[UIView alloc]init]autorelease];
    view.backgroundColor = [UIColor whiteColor];
    view.frame           = CGRectMake(10, winSize.size.height - 20 - 30 - 20, 25, 25);
    [self SetType:view];
    UIButton *userLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    userLocation.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    [userLocation setBackgroundImage:[UIImage imageNamed:@"icon_location_button.png"] forState:UIControlStateNormal];
    [userLocation addTarget:self action:@selector(ShowUser:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:userLocation];
    [self.view addSubview:view];
    
    mapView.delegate = self;
    // Do any additional setup after loading the view from its nib.
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
	CCBNLocation.latitude = 40.000829413871;
	CCBNLocation.longitude = 116.412857290094;
	annotation.coordinate = CCBNLocation;
	
	annotation.title = @"北京国际会议中心";
	annotation.subtitle = @"中国北京市朝阳区北辰东路8号";
	[mapView addAnnotation:annotation];
    BMKCoordinateRegion range = BMKCoordinateRegionMake(CCBNLocation, BMKCoordinateSpanMake(0.02, 0.02));
    [mapView setRegion:range animated:YES];
    
    search = [[BMKSearch alloc]init];
    search.delegate = self;
    mapView.showsUserLocation = YES;
}

-(void)mapView:(BMKMapView *)mapViews didUpdateUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"update");
    [search reverseGeocode:mapView.userLocation.coordinate];
    if (IsFirstUpdate) {
        
    }
}

- (void)SetType:(UIView*)view{
    view.layer.cornerRadius  = 5;
    view.backgroundColor     = [UIColor whiteColor];
    view.layer.shadowColor   = [[UIColor grayColor]CGColor];
    view.layer.shadowOffset  = CGSizeMake(5, 5);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius  = 5;
    view.alpha               = 0.8;
}

- (void)ShowUser:(UIButton*)sender{
    BMKCoordinateRegion region = BMKCoordinateRegionMake(mapView.userLocation.location.coordinate, BMKCoordinateSpanMake(0.02, 0.02));
    NSLog(@"center lati = %f,center long = %f",region.center.latitude,region.center.longitude);
    BMKCoordinateRegion kitRegion = [mapView regionThatFits:region];
    //[mapView setRegion:kitRegion animated:YES];
    mapView.region = kitRegion;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:mapView.userLocation.title delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)Searchs:(UIButton*)sender{
    SearchViewIsShow = SearchViewIsShow?NO:YES;
    [self SearchViewShow:SearchViewIsShow];
}

- (void)SearchViewShow:(BOOL)isShow{
    UIView *viewForTag = [self.view viewWithTag:102];
    if (isShow) {
        if (![self.view viewWithTag:102]) {
            UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(30, 120, 260, 40)]autorelease];
            OldFrame = view.frame;
            view.backgroundColor = [UIColor whiteColor];
            view.tag = 102;
            view.layer.cornerRadius = 5.0;
            BMCustomButton *busBtn = [[[BMCustomButton alloc]initWithWidth:30 andOrigin:CGPointMake(50, 20)]autorelease];
            busBtn.backgroundColor = [UIColor clearColor];
            [busBtn.titleButton setBackgroundImage:[UIImage imageNamed:@"icon_routesearch_seg_bus@2x.png"] forState:UIControlStateNormal];
            [busBtn.titleButton setBackgroundImage:[UIImage imageNamed:@"icon_routesearch_seg_bus_selected@2x.png"] forState:UIControlStateHighlighted];
            [busBtn.titleButton addTarget:self action:@selector(ShowRoute:) forControlEvents:UIControlEventTouchUpInside];
            [busBtn addTarget:self action:@selector(ShowRoute:) forControlEvents:UIControlEventTouchUpInside];
            busBtn.titleLabel.text = @"公交";
            busBtn.titleButton.tag = _BY_BUS_;
            busBtn.tag             = _BY_BUS_;
            busBtn.Btn.tag             = _BY_BUS_;
            [view addSubview:busBtn];

            BMCustomButton *carBtn = [[[BMCustomButton alloc]initWithWidth:30 andOrigin:CGPointMake(130, 20)]autorelease];
            carBtn.backgroundColor = [UIColor clearColor];
            [carBtn.titleButton setBackgroundImage:[UIImage imageNamed:@"icon_routesearch_seg_car@2x"] forState:UIControlStateNormal];
            [carBtn.titleButton setBackgroundImage:[UIImage imageNamed:@"icon_routesearch_seg_car_selected@2x"] forState:UIControlStateHighlighted];
            [carBtn.titleButton addTarget:self action:@selector(ShowRoute:) forControlEvents:UIControlEventTouchUpInside];
            //[carBtn addTarget:self action:@selector(ShowRoute:) forControlEvents:UIControlEventTouchUpInside];
            carBtn.titleLabel.text = @"驾车";
            carBtn.titleButton.tag = _BY_CAR_;
            carBtn.tag             = _BY_CAR_;
            [view addSubview:carBtn];
            
            BMCustomButton *footBtn = [[[BMCustomButton alloc]initWithWidth:30 andOrigin:CGPointMake(210, 20)]autorelease];
            footBtn.backgroundColor = [UIColor clearColor];
            [footBtn.titleButton setBackgroundImage:[UIImage imageNamed:@"icon_routesearch_seg_foot@2x.png"] forState:UIControlStateNormal];
            [footBtn.titleButton setBackgroundImage:[UIImage imageNamed:@"icon_routesearch_seg_foot_selected@2x.png"] forState:UIControlStateHighlighted];
            [footBtn.titleButton addTarget:self action:@selector(ShowRoute:) forControlEvents:UIControlEventTouchUpInside];
            [footBtn addTarget:self action:@selector(ShowRoute:) forControlEvents:UIControlEventTouchUpInside];
            footBtn.titleLabel.text = @"步行";
            footBtn.titleButton.tag = _BY_FOOT_;
            footBtn.tag             = _BY_FOOT_;
            [view addSubview:footBtn];
            [self.view addSubview:view];
            
            CGAffineTransform newTransform = CGAffineTransformMakeScale(0, 0);
            [view setTransform:newTransform];
            
            NSLog(@"setObject");
        }else{
            [viewForTag retain];
        }
        [UIView beginAnimations:@"magnify" context:nil];
        [UIView setAnimationDuration:0.5];
        CGAffineTransform oldTransform = CGAffineTransformMakeScale(1.0, 1.0);
        [[self.view viewWithTag:102] setTransform:oldTransform];
        [UIView commitAnimations];
        
        NSLog(@"count = %u",[viewForTag retainCount]);
    }else{
        if (viewForTag) {
            [UIView beginAnimations:@"narrow" context:nil];
            [UIView setAnimationDuration:0.5];
            CGAffineTransform disappearTransform = CGAffineTransformMakeScale(0, 0);
            [viewForTag setTransform:disappearTransform];
            [UIView commitAnimations];
            [viewForTag performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
            NSLog(@"releasing");
        }else{
            NSLog(@"end release");
        }
    }
}

-(void)ShowRoute:(UIControl*)sender{
    Vehicle  = sender.tag;
    switch (sender.tag) {
        case _BY_BUS_:{
            IsSearch = YES;
            BMKPlanNode *start = [[BMKPlanNode alloc]init];
            //start.pt           = CCBNLocation;
            start.name         = @"天安门";
            BMKPlanNode *end   = [[BMKPlanNode alloc]init];
            end.pt             = CCBNLocation;
            end.name           = @"国际会议中心";
            NSLog(@"%f  %f",mapView.userLocation.coordinate.latitude,mapView.userLocation.coordinate.longitude);
            [search transitSearch:@"北京" startNode:start endNode:end];
            
            [start release];
            [end   release];
            break;
        }
        case _BY_CAR_:{
            IsSearch = YES;
            NSLog(@"lati = %f,long = %f",mapView.userLocation.coordinate.latitude,mapView.userLocation.coordinate.longitude);
            [search reverseGeocode:mapView.userLocation.coordinate];
            break;
        }
        case _BY_FOOT_:{
            IsSearch = YES;
            NSLog(@"lati = %f,long = %f",mapView.userLocation.coordinate.latitude,mapView.userLocation.coordinate.longitude);
            [search reverseGeocode:mapView.userLocation.coordinate];
            break;
        }
        default:
            break;
    }
}

-(void)onGetAddrResult:(BMKAddrInfo *)result errorCode:(int)error{
    if (IsSearch) {
        if (![result.addressComponent.city isEqualToString:@"北京"]) {
            NSLog(@"city = %@",[NSString stringWithFormat:@"您的位置:%@,%@,%@",result.addressComponent.city,result.addressComponent.streetName,result.addressComponent.streetNumber]);
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"百度地图暂不支持城市之间查询" message:[NSString stringWithFormat:@"您的位置:%@,%@,%@",result.addressComponent.city,result.addressComponent.streetName,result.addressComponent.streetNumber] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            IsSearch = NO;
            Vehicle = LastVehicle;
        }else{
            switch (Vehicle) {
                case _BY_BUS_:{
                    BMKPlanNode *start = [[BMKPlanNode alloc]init];
                    //start.pt           = CCBNLocation;
                    start.name         = @"天安门";
                    BMKPlanNode *end   = [[BMKPlanNode alloc]init];
                    end.pt             = CCBNLocation;
                    end.name           = @"北京国际会议中心";
                    NSLog(@"%f  %f",mapView.userLocation.coordinate.latitude,mapView.userLocation.coordinate.longitude);
                    [search transitSearch:@"北京" startNode:start endNode:end];
                    
                    [start release];
                    [end   release];
                    LastVehicle = Vehicle;
                    break;
                }case _BY_CAR_:{
                    LastVehicle = Vehicle;
                    break;
                }case _BY_FOOT_:{
                    LastVehicle = Vehicle;
                    break;
                }
                default:
                    break;
            }
            IsSearch = NO;
        }
    }else {
        NSString *title = [NSString stringWithFormat:@"您的位置:%@,%@,%@",result.addressComponent.city,result.addressComponent.streetName,result.addressComponent.streetNumber];
        mapView.userLocation.title = title;
    }
    NSLog(@"vehicle = %d",LastVehicle);
}

-(void)onGetTransitRouteResult:(BMKPlanResult *)result errorCode:(int)error{
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        switch (error) {
            case 2:{
                [alertView setMessage:@"网络连接错误"];
                break;
            }case 3:{
                [alertView setMessage:@"数据错误"];
                break;
            }case 4:{
                [alertView setMessage:@"起点或终点选择"];
                break;
            }case 100:{
                [alertView setMessage:@"搜索结果未找到"];
                break;
            }case 200:{
                [alertView setMessage:@"定位失败"];
                break;
            }case 300:{
                [alertView setMessage:@"百度地图API授权Key验证失败"];
                break;
            }case 310:{
                [alertView setMessage:@"数据解析失败"];
                break;
            }
            default:
                break;
        }
        [alertView show];
        [alertView release];
        IsSearch = NO;
        return;
    }
    if (![self.view viewWithTag:103]) {
        [UIView beginAnimations:@"DropDown" context:nil];
        [UIView setAnimationDuration:0.5];
        UIView *view = [self.view viewWithTag:102];
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, view.frame.size.height, view.frame.size.width - 40, OldFrame.size.height*5)];
        tableView.tag = 103;
        tableView.delegate   = self;
        tableView.dataSource = self;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator   = NO;
        view.frame = CGRectMake(OldFrame.origin.x, OldFrame.origin.y, OldFrame.size.width, OldFrame.size.height*6);
            [view performSelector:@selector(addSubview:) withObject:tableView afterDelay:0.5f];
        [UIView commitAnimations];
    }
    RoutesPlan = [result retain];
    NSArray *sortedArray = [RoutesPlan.plans sortedArrayUsingComparator:^NSComparisonResult(BMKTransitRoutePlan *obj1, BMKTransitRoutePlan *obj2){
        if (obj1.distance > obj2.distance){
            return NSOrderedDescending;
        }
        if (obj1.distance < obj2.distance){
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    RoutesPlan.plans = sortedArray;
    NSLog(@"count = %u",[RoutesPlan.plans count]);
    UITableView *reloadView = (UITableView *)[self.view viewWithTag:103];
    [reloadView reloadData];
    
    if (Vehicle == 301) {
        LastVehicle = Vehicle;
    }else if (Vehicle == 302){
        LastVehicle = Vehicle;
    }else if (Vehicle == 303){
        LastVehicle = Vehicle;
    }
    
    IsSearch = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    //[self ReloadData];
    NSLog(@"appear");
    mapView.showsUserLocation = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    mapView.showsUserLocation = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([RoutesPlan.plans count] > 4) {
        return 4;
    }else
        return [RoutesPlan.plans count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IdentifierStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IdentifierStr];
    }
    if (Vehicle == _BY_BUS_) {
        BMKTransitRoutePlan *RoutePlan = [RoutesPlan.plans objectAtIndex:indexPath.row];
        NSString *content;
        NSString *subTitle;
        if (RoutePlan.distance > 999) {
            content  = [NSString stringWithFormat:@"%@到%@",RoutesPlan.startNode.name,RoutesPlan.endNode.name];
            subTitle = [NSString stringWithFormat:@"距离%d千米",RoutePlan.distance/1000];
        }else{
            content  = [NSString stringWithFormat:@"%@到%@",RoutesPlan.startNode.name,RoutesPlan.endNode.name];
            subTitle = [NSString stringWithFormat:@"距离%d米",RoutePlan.distance];
        }
        NSLog(@"content = %@",content);
        cell.textLabel.font       = [UIFont systemFontOfSize:16];
        //NSLog(@"%@",[UIFont familyNames]);
        cell.textLabel.text       = content;
        cell.detailTextLabel.text = subTitle;
    }else if(Vehicle == _BY_CAR_ ||Vehicle == _BY_FOOT_){
        BMKRoutePlan *RoutePlan = [RoutesPlan.plans objectAtIndex:indexPath.row];
        NSString *content;
        if (RoutePlan.distance > 999) {
            content = [NSString stringWithFormat:@"%@到%@,距离%d千米",RoutesPlan.startNode.name,RoutesPlan.endNode.name,RoutePlan.distance/1000];
        }else{
            content = [NSString stringWithFormat:@"%@到%@,距离%d米",RoutesPlan.startNode.name,RoutesPlan.endNode.name,RoutePlan.distance];
        }
        NSLog(@"content = %@",content);
        cell.textLabel.text = content;
    }
    
    return cell;
}


// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
		BMKPinAnnotationView *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
		newAnnotation.pinColor = BMKPinAnnotationColorPurple;
		//newAnnotation.animatesDrop = YES;
		newAnnotation.draggable = YES;
		
		return newAnnotation;
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableString *routeStr  = [[[NSMutableString alloc]init]autorelease];
    UIAlertView *alertView     = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView.delegate         = self;
    switch (Vehicle) {
        case _BY_BUS_:{
            BMKTransitRoutePlan *route = [RoutesPlan.plans objectAtIndex:indexPath.row];
            for (BMKLine *line in route.lines) {
                NSString *str = [NSString stringWithFormat:@"%@,到%@下车",line.tip,line.getOffStopPoiInfo.name];
                [routeStr appendString:str];
                if ([route.lines indexOfObject:line] != 4) {
                    [routeStr appendFormat:@"\n"];
                }
                alertView.tag = indexPath.row + 200;
            }
            [alertView setMessage:routeStr];
            break;
        }case _BY_CAR_:{
            BMKRoutePlan *route = [RoutesPlan.plans objectAtIndex:indexPath.row];
            for (BMKLine *routeLine in route.routes) {
                NSString *str = routeLine.tip;
                [routeStr appendString:str];
                if ([route.routes indexOfObject:routeLine] != 4) {
                    [routeStr appendFormat:@"\n"];
                }
                alertView.tag = indexPath.row + 200;
            }
            [alertView setMessage:routeStr];
            break;
        }case _BY_FOOT_:{
            BMKRoutePlan *route = [RoutesPlan.plans objectAtIndex:indexPath.row];
            for (BMKLine *routeLine in route.routes) {
                NSString *str = routeLine.tip;
                [routeStr appendString:str];
                if ([route.routes indexOfObject:routeLine] != 4) {
                    [routeStr appendFormat:@"\n"];
                }
                alertView.tag = indexPath.row + 200;
            }
            [alertView setMessage:routeStr];
            
            break;
        }
        default:
            break;
    }
    NSLog(@"%@",routeStr);
   
    [alertView show];
    [alertView release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        switch (Vehicle) {
            case _BY_BUS_:{
                NSLog(@"By Bus");
                BMKTransitRoutePlan *route = [RoutesPlan.plans objectAtIndex:(alertView.tag - 200)];
                BMKLine *e = [route.routes objectAtIndex:0];
                for (int i = 0; i<5; i++) {
                    BMKMapPoint point = *([e points] + i);
                    NSLog(@"point x = %lf  y = %lf",point.x,point.y);
                        
                }
                
                break;
            }case _BY_CAR_:{
                NSLog(@"By Car");
                break;
            }case _BY_FOOT_:{
                NSLog(@"By Foot");
                break;
            }
            default:
                break;
        }
    }
}

-(void)dealloc{
    [mapView    release];
    [search     release];
    [RoutesPlan release];
    [super      dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
