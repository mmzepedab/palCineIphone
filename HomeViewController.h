//
//  HomeViewController.h
//  palCineIphone
//
//  Created by Mario Zepeda on 11/4/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "XMLParser.h"

@interface HomeViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>{
    XMLParser *xmlParser;

}
@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@property (strong, nonatomic) NSArray *list;
@property (weak, nonatomic) IBOutlet UIButton *toMovieTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *toMovieTheaterBtn;

//-(void)loadXMLParser;

@end
