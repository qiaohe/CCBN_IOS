//
//  TwoDimensionCodeViewController.m
//  CCBN
//
//  Created by 马 宏亮 on 13-5-31.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "TwoDimensionCodeViewController.h"

@interface TwoDimensionCodeViewController ()

@end

@implementation TwoDimensionCodeViewController

@synthesize UserName;
@synthesize PassWord;
@synthesize SignInBtn;
@synthesize ImageView;

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
    winSize = [[UIScreen mainScreen]bounds];
    [self initViewData];
    // Do any additional setup after loading the view from its nib.
}

- (void)initViewData{
    UserName.frame = CGRectMake(winSize.size.width/2, 35 + _NAVIGATIONBAR_HIGH_, winSize.size.width*2/3, 30);
    UserName.layer.anchorPoint = CGPointMake(1.0, 1.0);
    UserName.placeholder = @"请输入您的账号";
    
    PassWord.frame = CGRectMake(winSize.size.width/2, UserName.frame.origin.y + 80, UserName.frame.size.width, UserName.frame.size.height);
    PassWord.layer.anchorPoint = CGPointMake(1.0, 1.0);
    PassWord.placeholder = @"请输入您的密码";
    
    
    self.SignInBtn = [[[CustomButton alloc]initWithTextAndHSB:@"" target:self selector:@selector(LogIn:) hue:0.6f saturation:0.05f brightness:0.8f]autorelease];
    self.SignInBtn.frame = CGRectMake(winSize.size.width/2, 200, 180, 60);
    [self.SignInBtn setLabelWithText:@"Sign In" andSize:24.0f andVerticalShift:0.0f];
    self.SignInBtn.label.textColor = [UIColor grayColor];
    self.SignInBtn.layer.anchorPoint = CGPointMake(1.0, 1.0);
    [self.view addSubview:SignInBtn];
}

-(void)LogIn:(UIButton*)sender{
    NSURL *RequestURL = [NSURL URLWithString:[_BASE_URL_ stringByAppendingFormat:@"?login=%@&password=%@",self.UserName.text,self.PassWord.text]];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc]initWithURL:RequestURL];
    request.delegate = self;
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    //NSLog(@"request = %@",[request responseData]);
    [self.ImageView setImage:[UIImage imageWithData:[request responseData]]];
}

-(IBAction)ClearFirstResponder:(id)sender{
    if ([self.UserName isFirstResponder]) {
        [self.UserName resignFirstResponder];
    }else if([self.PassWord isFirstResponder]){
        [self.PassWord resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.UserName  release];
    [self.PassWord  release];
    [self.SignInBtn release];
    [self.ImageView release];
    [super dealloc];
}

@end
