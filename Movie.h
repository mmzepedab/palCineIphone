//
//  Movie.h
//  Nav
//
//  Created by Mario Zepeda on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject{
    NSString *id;
    NSString *name;
    NSString *name_english;
    NSString *description;
    NSString *release_date;
    NSString *length;
    NSString *genre;
    NSString *imageURL;
    UIImage *image;
    NSString *image_thumbnail;
    NSString *trailer_link;    
    UIImage *imageThumbnail;
    NSString *raiting;
    NSString *restriction;
}

@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *name_english;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *release_date;
@property (nonatomic, retain) NSString *length;
@property (nonatomic, retain) NSString *genre;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *image_thumbnail;
@property (nonatomic, retain) UIImage *imageThumbnail;
@property (nonatomic, retain) NSString *trailer_link;
@property (nonatomic, retain) NSString *raiting;
@property (nonatomic, retain) NSString *restriction;


@end
