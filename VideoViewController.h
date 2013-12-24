//
//  VideoViewController.h
//  palCineIphone
//
//  Created by Mario Zepeda on 12/23/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController{
    NSString *videoURL;
    NSString *videoHTML;
}


@property (weak, nonatomic) IBOutlet UIWebView *videoView;
@property(nonatomic, retain) NSString *videoURL;
@property(nonatomic, retain) NSString *videoHTML;
@property(nonatomic, retain) NSString *movieNameString;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLbl;

- (void) embedYouTube;
- (IBAction) closeModal;

@end
