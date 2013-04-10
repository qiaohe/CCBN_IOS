//
//  MessageViewController.m
//  CCBN
//
//  Created by Jack Wang on 4/1/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "MessageViewController.h"
#import "Model.h"
#import "Message.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)init
{
	if ((self = [super init]))
	{
		[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateTable:)
                                                     name:NotificationReceiveNewMessage
                                                   object:nil];
        
        
	}
	
	return self;
}

- (void)updateTable:(NSNotification *)notification
{
    [_messageTable reloadData];
}

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
    [[Model sharedModel].messages sortUsingComparator:^ NSComparisonResult(Message *m1, Message *m2)
     {
         return [m2.date compare:m1.date];
     }];
    
    [super viewDidLoad];
    [[Model sharedModel].unreadMSG removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationReceiveNewMessage object:nil userInfo:nil];
    format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_messageTable release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[Model sharedModel].messages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *Title_ID = @"Title_ID";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Title_ID];
	UILabel *theTitle = nil;
	UILabel *timeTitle = nil;
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:Title_ID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		theTitle = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 22)] autorelease];
        theTitle.minimumFontSize = 18;
		theTitle.tag = 1;
        [cell.contentView addSubview:theTitle];
        
        timeTitle = [[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 22)] autorelease];
        timeTitle.minimumFontSize = 18;
		timeTitle.tag = 2;
        timeTitle.textColor = [UIColor grayColor];
        [cell.contentView addSubview:timeTitle];
	}
    else
    {
        theTitle = (UILabel *)[cell.contentView viewWithTag:1];
        timeTitle = (UILabel *)[cell.contentView viewWithTag:2];
    }
	
    Message *message = (Message *)[[Model sharedModel].messages objectAtIndex:indexPath.row];
    theTitle.text = message.msg;
    timeTitle.text = [format stringFromDate:message.date];
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}
- (void)viewDidUnload {
    [self setMessageTable:nil];
    [super viewDidUnload];
}
@end
