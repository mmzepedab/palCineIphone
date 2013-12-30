//
//  ToTheaterTimeViewController.h
//  palCineIphone
//
//  Created by Mario Zepeda on 12/26/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParserTheaterTime.h"

@interface ToTheaterTimeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    XMLParserTheaterTime *xmlParser;
    NSMutableData *receivedData;
}

@property (weak, nonatomic) NSString  *time;
@property (weak, nonatomic) NSString  *roomName;
@property (weak, nonatomic) NSString  *theaterId;
@property (weak, nonatomic) NSString  *theaterName;
@property (weak, nonatomic) NSString  *movieId;
@property (weak, nonatomic) NSString  *movieName;


@property (weak, nonatomic) IBOutlet UITableView *timeTableView;

@end
