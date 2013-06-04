//
//  SpeakerViewController.m
//  CCBN
//
//  Created by Jack Wang on 4/5/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "SpeakerViewController.h"
#import "SpeakerDetailViewControlle.h"
#import "Speaker.h"
#import "Model.h"
#import "CCBN.h"

@interface SpeakerViewController ()

@end

@implementation SpeakerViewController

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
    // Do any additional setup after loading the view from its nib.
    [typeGroup removeAllObjects];
	[typeVSExhibitors removeAllObjects];
    NSString *acronym;
    NSMutableArray *array;
    for (Speaker *s in [Model sharedModel].ccbn.speakers) {
        acronym = [s getAcronym];
        array = [typeVSExhibitors objectForKey:acronym];
        if (array == nil)
        {
            array = [NSMutableArray array];
            [typeVSExhibitors setObject:array forKey:acronym];
            [typeGroup addObject:acronym];
        }
        [array addObject:s];
    }
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
	UILabel *theLocation = nil;
    UIImageView *theImage = nil;
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:Title_ID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		
		theTitle = [[[UILabel alloc] initWithFrame:CGRectMake(45, 10, 270, 22)] autorelease];
        theTitle.minimumFontSize = 18;
		theTitle.tag = 1;
        
		[cell.contentView addSubview:theTitle];
        
        theLocation = [[[UILabel alloc] initWithFrame:CGRectMake(45, 30, 270, 22)] autorelease];
        theLocation.minimumFontSize = 14;
        theLocation.tag = 2;
        [cell.contentView addSubview:theLocation];
        
        theImage = [[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 27, 40)] autorelease];
        theImage.tag = 3;
        [cell.contentView addSubview:theImage];
		
	}
    else
    {
        theTitle = (UILabel *)[cell.contentView viewWithTag:1];
        theLocation = (UILabel *)[cell.contentView viewWithTag:2];
        theImage = (UIImageView *)[cell.contentView viewWithTag:3];
    }
	
    NSMutableArray *array = [typeVSExhibitors objectForKey:[typeGroup objectAtIndex:indexPath.section]];
    Speaker *speaker = (Speaker *)[array objectAtIndex:indexPath.row];
    theTitle.text = speaker.name;
    theLocation.text = speaker.company;
    theImage.image = [speaker getSpeakerPhotoImage];;
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = [typeVSExhibitors objectForKey:[typeGroup objectAtIndex:indexPath.section]];
    Speaker *speaker = (Speaker *)[array objectAtIndex:indexPath.row];
    SpeakerDetailViewControlle *sdvc = [[[SpeakerDetailViewControlle alloc] init] autorelease];
    [sdvc setHeader:_headingText];
    sdvc.speaker = speaker;
    [[Model sharedModel] gotoPage:sdvc option:UIViewAnimationOptionCurveLinear];
    
}

@end
