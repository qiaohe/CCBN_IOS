//
//  BMCustomButton.h
//  CCBN
//
//  Created by 马 宏亮 on 13-6-2.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface BMCustomButton : UIControl{
    CGRect   winSize;
    UILabel  *titleLabel;
    UIButton *titleButton;
    CGFloat  viewWidth;
    UIButton *Btn;
}

@property (nonatomic, assign) CGRect   winSize;
@property (nonatomic, retain) UILabel  *titleLabel;
@property (nonatomic, retain) UIButton *titleButton;
@property (nonatomic, retain) UIButton *Btn;

- (id)initWithWidth:(CGFloat)Width andOrigin:(CGPoint)Origin;

@end

