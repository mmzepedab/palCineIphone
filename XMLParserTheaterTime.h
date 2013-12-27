//
//  XMLParserTheaterTime.h
//  palCineIphone
//
//  Created by Mario Zepeda on 12/27/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface XMLParserTheaterTime : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate>{
    NSMutableString *currentNodeContent;
    NSMutableArray *times;
    NSXMLParser *parser;
    Time *currentTime;
    
}

@property(readonly, retain) NSMutableArray *times;

-(id)loadXMLwithData:(NSData *)data;
-(id)loadXMLByURL:(NSString *)urlString;

@end
