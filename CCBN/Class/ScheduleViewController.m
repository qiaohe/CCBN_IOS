//
//  EventsViewController.m
//  CCBN
//
//  Created by Jack Wang on 4/6/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "ScheduleViewController.h"
#import "EventSchedule.h"
#import "Model.h"
#import "CCBN.h"
#import "ScheduleDetailViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    NSLog(@"INIT %p", self);
    
    if ((self = [super init]))
    {
        dayFormat = [[NSDateFormatter alloc] init];
        [dayFormat setDateFormat:@"MM月dd日"];
        timeFormat = [[NSDateFormatter alloc] init];
        [timeFormat setDateFormat:@"hh:mm"];
        typeGroup = [[NSMutableArray alloc] init];
        typeVSExhibitors = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)dealloc{
    [dayFormat release];
    [timeFormat release];
    [typeGroup release];
    [typeVSExhibitors release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [typeGroup removeAllObjects];
	[typeVSExhibitors removeAllObjects];
    NSString *category;
    NSMutableArray *array;
    for (EventSchedule *e in [Model sharedModel].ccbn.eventSchedules) {
        category = [dayFormat stringFromDate:e.dateFrom];
        array = [typeVSExhibitors objectForKey:category];
        if (array == nil)
        {
            array = [NSMutableArray array];
            [typeVSExhibitors setObject:array forKey:category];
            [typeGroup addObject:category];
        }
        [array addObject:e];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *array = [typeVSExhibitors objectForKey:[typeGroup objectAtIndex:section]];
	return [array count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [typeGroup count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [NSString stringWithFormat:@"%@", [typeGroup objectAtIndex:section]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"date_bar.png"]];
    bg.frame = headerView.frame;
    //UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake (0,0,320,25)];
    [headerView addSubview:bg];
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake (10,0,320,25)];
    header.textColor = [UIColor whiteColor];
    header.text = [NSString stringWithFormat:@"%@", [typeGroup objectAtIndex:section]];
    [headerView addSubview:header];
    [header setBackgroundColor:[UIColor clearColor]];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *Title_ID = @"Title_ID";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Title_ID];
	UILabel *theTitle = nil;
	UILabel *theDate = nil;
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:Title_ID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		
		theTitle = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 22)] autorelease];
        theTitle.minimumFontSize = 18;
		theTitle.tag = 1;
        
		[cell.contentView addSubview:theTitle];
        
        theDate = [[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 22)] autorelease];
        theDate.minimumFontSize = 14;
        theDate.tag = 2;
        [cell.contentView addSubview:theDate];
		
	}
    else
    {
        theTitle = (UILabel *)[cell.contentView viewWithTag:1];
        theDate = (UILabel *)[cell.contentView viewWithTag:2];
    }
	
    NSMutableArray *array = [typeVSExhibitors objectForKey:[typeGroup objectAtIndex:indexPath.section]];
    EventSchedule *eventSchedule = (EventSchedule *)[array objectAtIndex:indexPath.row];
    theTitle.text = eventSchedule.name;
    theDate.text = [NSString stringWithFormat:@"%@ - %@", [timeFormat stringFromDate:eventSchedule.dateFrom], [timeFormat stringFromDate:eventSchedule.dateTo]];
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = [typeVSExhibitors objectForKey:[typeGroup objectAtIndex:indexPath.section]];
    EventSchedule *eventSchedule = (EventSchedule *)[array objectAtIndex:indexPath.row];
    ScheduleDetailViewController *sdvc = [[[ScheduleDetailViewController alloc] init] autorelease];
    [sdvc setHeader:_headingText];
    sdvc.eventSchedule = eventSchedule;
    [[Model sharedModel] gotoPage:sdvc option:UIViewAnimationOptionCurveLinear];
    
}

@end
