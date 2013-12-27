//
//  Time.h
//  palCineIphone
//
//  Created by Mario Zepeda on 12/26/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject{
    NSString *time;
    NSString *roomName;
}

@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *roomName;

@end
