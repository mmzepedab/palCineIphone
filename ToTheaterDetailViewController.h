//
//  ToTheaterDetailViewController.h
//  palCineIphone
//
//  Created by Mario Zepeda on 12/27/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToTheaterDetailViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) NSString  *roomName;
@property (weak, nonatomic) NSString  *time;
@property (weak, nonatomic) NSString  *movieName;

- (IBAction)yesButtonAction:(id)sender;
- (IBAction)noButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *movieNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *roomNameLbl;


@end
