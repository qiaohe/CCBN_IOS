//
//  Speaker.m
//  CCBN
//
//  Created by Jack Wang on 3/31/13.
//  Copyright (c) 2013 MobileDaily. All rights reserved.
//

#import "Speaker.h"

@implementation Speaker
@synthesize name = _name;
@synthesize profile = _profile;
@synthesize position = _position;
@synthesize company = _company;
@synthesize photo = _photo;
@synthesize image = _image;

- (id)initWithJSONData:(NSDictionary *)data
{
    if ((self = [super init]))
    {
        _name = [[data objectForKey:@"name"] retain];
        _profile = [[data objectForKey:@"profile"] retain];
        _position = [[data objectForKey:@"position"] retain];
        _company = [[data objectForKey:@"company"] retain];
        _photo = [[data objectForKey:@"photo"] retain];
    }
    
    return self;
}

-(NSString *)getAcronym {
    return [[_name substringWithRange:NSMakeRange(0, 1)] uppercaseString];
}

-(UIImage *)getSpeakerPhotoImage{
    if(_image == nil){
        NSURL *imageURL = [NSURL URLWithString:[ServerURL stringByAppendingFormat:@"/exhibition/upload/image/%@", _photo]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        _image = [[UIImage imageWithData:imageData] retain];
    }
    return _image;
}
@end
