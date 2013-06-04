//
//  SettingViewController.m
//  CCBN
//
//  Created by Jack Wang on 4/15/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "SettingViewController.h"
#import "CCBNUISwitch.h"
#import "Model.h"
#import "PlistProxy.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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


-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [typeGroup removeAllObjects];
	[typeVSExhibitors removeAllObjects];
    
    NSMutableArray *array;
    NSString *group;
    group = @"消息设置";
    [typeGroup addObject:group];
    array = [NSMutableArray array];
    [typeVSExhibitors setObject:array forKey:group];
    [array addObject:@"接收新消息通知"];
    [array addObject:@"消息声音提示"];
    [array addObject:@"清空消息"];
    
    
    group = @"其他设置";
    [typeGroup addObject:group];
    array = [NSMutableArray array];
    [typeVSExhibitors setObject:array forKey:group];
    [array addObject:@"每次启动时自动check-in"];
    [array addObject:@"每次启动时更新数据"];
    
    group = @"系统版本";
    [typeGroup addObject:group];
    array = [NSMutableArray array];
    [typeVSExhibitors setObject:array forKey:group];
    [array addObject:@"v1.0"];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *Title_ID = @"Title_ID";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Title_ID];
	UILabel *theTitle = nil;
    CCBNUISwitch *theSwitch;
    
	
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:Title_ID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		
		theTitle = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 270, 22)] autorelease];
        theTitle.minimumFontSize = 18;
        theTitle.backgroundColor = [UIColor clearColor];
		theTitle.tag = 1;
        
		[cell.contentView addSubview:theTitle];
        
        
        theSwitch = [[[CCBNUISwitch alloc] initWithFrame:CGRectMake(210, 10, 77, 27)] autorelease];
        [theSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
        theSwitch.tag = 2;
		[cell.contentView addSubview:theSwitch];
    }
    else
    {
        theTitle = (UILabel *)[cell.contentView viewWithTag:1];
        theSwitch = (CCBNUISwitch *)[cell.contentView viewWithTag:2];
    }
	
    
    NSMutableArray *array = [typeVSExhibitors objectForKey:[typeGroup objectAtIndex:indexPath.section]];
    NSString *title = (NSString *)[array objectAtIndex:indexPath.row];
    theSwitch.fieldData = title;
    if([title isEqualToString:@"清空消息"] || [title isEqualToString:@"v1.0"]){
        if([title isEqualToString:@"清空消息"])
            theTitle.textAlignment = NSTextAlignmentCenter;
        else
            theTitle.textAlignment = NSTextAlignmentLeft;
        theSwitch.hidden = YES;
    } else {
        theTitle.textAlignment = NSTextAlignmentLeft;
        theSwitch.hidden = NO;
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        
        //NSLog(@"%@:%@", title, [userInfo boolForKey:title] ? @"YES" : @"NO");
        [theSwitch setOn:[userInfo boolForKey:title]];
    }
    
    
    theTitle.text = title;
	return cell;
}


- (IBAction)switchAction:(id)sender {
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    CCBNUISwitch *switchButton = (CCBNUISwitch*)sender;
    BOOL onOff = [switchButton isOn];
    [userInfo setBool:onOff forKey:switchButton.fieldData];
    [userInfo synchronize];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array = [typeVSExhibitors objectForKey:[typeGroup objectAtIndex:indexPath.section]];
    NSString *title = (NSString *)[array objectAtIndex:indexPath.row];
    if([title isEqualToString:@"清空消息"]){
        [[Model sharedModel].unreadMSG removeAllObjects];
        [[Model sharedModel].messages removeAllObjects];
        [[PlistProxy sharedPlistProxy] updateMessages];
        [[Model sharedModel] displayTip:@"推送消息已清空" modal:YES];
    }
    
}

@end
