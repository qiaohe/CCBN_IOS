//
//  Icon.h
//  CCBN
//
//   Created by Jack Wang on 2/28/13.
//

#import "IData.h"

@interface Icon : IData
{
    NSString *imageUrl;
    NSString *sectionName;
    NSString *title;
    int page;
    int index;
}

@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *sectionName;
@property (nonatomic, retain) NSString *title;
@property (nonatomic) int page;
@property (nonatomic) int index;



@end
