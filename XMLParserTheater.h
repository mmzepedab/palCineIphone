//
//  XMLParserTheater.h
//  palCineIphone
//
//  Created by Mario Zepeda on 12/26/13.
//  Copyright (c) 2013 Mario Zepeda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Theater.h"

@interface XMLParserTheater : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate>{
    NSMutableString *currentNodeContent;
    NSMutableArray *theaters;
    NSXMLParser *parser;
    Theater *currentTheater;

}

@property(readonly, retain) NSMutableArray *theaters;

-(id)loadXMLwithData:(NSData *)data;
-(id)loadXMLByURL:(NSString *)urlString;

@end
