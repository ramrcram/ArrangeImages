//
//  Slide.h
//  ArrangeImages
//
//  Created by Ramesh on 09/08/16.
//  Copyright © 2016 rubixtechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Slide : NSObject

//Slide Type
typedef enum SlideType : NSUInteger {
    NORMAL,
    WIDE
} SlideType;

@property(nonatomic,strong) NSString* imageName;
@property(nonatomic,assign) SlideType slideType;

@end
