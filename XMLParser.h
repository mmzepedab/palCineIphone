//
//  XMLParser.h
//  Nav
//
//  Created by Mario Zepeda on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"

@interface XMLParser : NSObject <NSXMLParserDelegate, NSURLConnectionDelegate>{
    NSMutableString *currentNodeContent;
    NSMutableArray *movies;
    NSXMLParser *parser;
    Movie *currentMovie;
}

@property(readonly, retain) NSMutableArray *movies;

-(id)loadXMLwithData:(NSData *)data;
-(id)loadXMLByURL:(NSString *)urlString;

@end
