//
//  TwoDimensionCodeViewController.h
//  CCBN
//
//  Created by 马 宏亮 on 13-5-31.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "CCBNViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Model.h"
#import "ASIHTTPRequest.h"
#import "CustomButton.h"

#define _NAVIGATIONBAR_HIGH_ 40
#define _BASE_URL_           @"http://180.168.35.37:8080/exhibition/api/qrcode/get"

@interface TwoDimensionCodeViewController : CCBNViewController<UITextFieldDelegate,ASIHTTPRequestDelegate>{
    CGRect       winSize;
    UITextField  *UserName;
    UITextField  *PassWord;
    CustomButton *SignInBtn;
    UIImageView  *ImageView;
}

@property (nonatomic, retain) IBOutlet UITextField  *UserName;
@property (nonatomic, retain) IBOutlet UITextField  *PassWord;
@property (nonatomic, retain) IBOutlet CustomButton *SignInBtn;
@property (nonatomic, retain) IBOutlet UIImageView  *ImageView;

-(IBAction)ClearFirstResponder:(id)sender;

@end
