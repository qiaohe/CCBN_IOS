//
//  ExhibitorViewController.m
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "ExhibitorViewController.h"
#import "Exhibitor.h"
#import "Model.h"
#import "CCBN.h"
#import "ExhibitorDetailViewController.h"

@interface ExhibitorViewController ()

@end

@implementation ExhibitorViewController

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
        typeGroup = [[NSMutableArray alloc] init];
        typeVSExhibitors = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [typeGroup removeAllObjects];
	[typeVSExhibitors removeAllObjects];
    NSString *location;
    NSMutableArray *array;
    for (Exhibitor *e in [Model sharedModel].ccbn.exhibitors) {
        location = [e getExhibitorLocation];
        array = [typeVSExhibitors objectForKey:location];
        if (array == nil)
        {
            array = [NSMutableArray array];
            [typeVSExhibitors setObject:array forKey:location];
            [typeGroup addObject:location];
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
	return [NSString stringWithFormat:@"%@ 区", [typeGroup objectAtIndex:section]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"date_bar.png"]];
    bg.frame = headerView.frame;
    //UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake (0,0,320,25)];
    [headerView addSubview:bg];
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake (10,0,320,25)];
    header.textColor = [UIColor whiteColor];
    header.text = [NSString stringWithFormat:@"%@ 区", [typeGroup objectAtIndex:section]];
    [headerView addSubview:header];
    [header setBackgroundColor:[UIColor clearColor]];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *Title_ID = @"Title_ID";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Title_ID];
	UILabel *theTitle = nil;
	UILabel *theLocation = nil;
	
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
        
        theLocation = [[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 22)] autorelease];
        theLocation.minimumFontSize = 14;
        theLocation.tag = 2;
        [cell.contentView addSubview:theLocation];
		
	}
    else
    {
        theTitle = (UILabel *)[cell.contentView viewWithTag:1];
        theLocation = (UILabel *)[cell.contentView viewWithTag:2];
    }
	
    NSMutableArray *array = [typeVSExhibitors objectForKey:[typeGroup objectAtIndex:indexPath.section]];
    Exhibitor *exhibitor = (Exhibitor *)[array objectAtIndex:indexPath.row];
    theTitle.text = exhibitor.company;
    theLocation.text = exhibitor.location;
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = [typeVSExhibitors objectForKey:[typeGroup objectAtIndex:indexPath.section]];
    Exhibitor *exhibitor = (Exhibitor *)[array objectAtIndex:indexPath.row];
    ExhibitorDetailViewController *edvc = [[[ExhibitorDetailViewController alloc] init] autorelease];
    [edvc setHeader:exhibitor.company];
    edvc.exhibitor = exhibitor;
    //[edvc setExhibitor:exhibitor];
    [[Model sharedModel] gotoPage:edvc option:UIViewAnimationOptionCurveLinear];
    
}

@end
