//
//  BMCustomButton.m
//  CCBN
//
//  Created by 马 宏亮 on 13-6-2.
//  Copyright (c) 2013年 MobileDaily. All rights reserved.
//

#import "BMCustomButton.h"

@implementation BMCustomButton


@synthesize winSize;
@synthesize titleLabel;
@synthesize titleButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithWidth:(CGFloat)Width andOrigin:(CGPoint)Origin{
    /*
    if (Width < winSize.size.width/6) {
        Width  = winSize.size.width/6;
    }*/
    CGRect frame = CGRectMake(Origin.x - Width/2, Origin.y - (Width + Width/3)/2, Width, Width + Width/3);
    self = [super initWithFrame:frame];
    if (self) {
        self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.titleLabel  = [[UILabel alloc]init];
        self.titleButton.frame = CGRectMake(Width/(3*2), Width/(3*2), Width*2/3, Width*2/3);
        self.titleLabel.frame  = CGRectMake(0, self.titleButton.frame.origin.y + self.titleButton.frame.size.height, Width, frame.size.height - self.titleButton.frame.origin.y - self.titleButton.frame.size.height);
        self.titleButton.backgroundColor = [UIColor clearColor];
        self.titleLabel.backgroundColor  = [UIColor clearColor];
        self.titleLabel.textAlignment    = 1;
        self.titleLabel.font             = [UIFont systemFontOfSize:10.0f];
        [self addSubview:self.titleButton];
        [self addSubview:self.titleLabel];
    }
    self.layer.cornerRadius  = 5;
    self.backgroundColor     = [UIColor whiteColor];
    self.layer.shadowColor   = [[UIColor grayColor]CGColor];
    self.layer.shadowOffset  = CGSizeMake(5, 5);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius  = 5;
    self.alpha               = 0.8;
    return self;
}

- (void)dealloc{
    [self.titleButton release];
    [self.titleLabel  release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
