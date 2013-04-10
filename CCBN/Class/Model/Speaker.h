//
//  Speaker.h
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "IData.h"

@interface Speaker : IData
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *profile;
@property (nonatomic, retain) NSString *position;
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *photo;
@property (nonatomic, retain) UIImage *image;

-(NSString *)getAcronym;
-(UIImage *)getSpeakerPhotoImage;
@end
