//
//  ToTheaterViewController.h
//  palCineIphone
//
//  Created by Mario Zepeda on 12/26/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParserTheater.h"

@interface ToTheaterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    XMLParserTheater *xmlParser;
    NSMutableData *receivedData;
}
@property (weak, nonatomic) IBOutlet UITableView *theaterTableView;
@property (weak, nonatomic) NSString  *movieId;
@property (weak, nonatomic) NSString  *movieName;

@end
