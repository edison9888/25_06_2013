//
//  XmlParser.h
//  XMLParsing1
//
//  Created by Abraham Varghese on 6/24/10.
//  Copyright 2010 ClearPoint Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XmlParser : NSObject <NSXMLParserDelegate> {
	NSMutableArray *result;
	NSString *currentElementName;
	NSString *currentElementValue;
	NSMutableArray *parentArray;
	NSXMLParser *parser;
	NSDictionary *attributeList;
}

@property (nonatomic, retain) NSMutableArray *result;
@property (nonatomic, retain) NSString *currentElementName;
@property (nonatomic, retain) NSString *currentElementValue;
@property (nonatomic, retain) NSMutableArray *parentArray;
@property (nonatomic, retain) NSDictionary *attributeList;

- (NSMutableArray *)loadXMLByURL:(NSString *)xmlName;
- (void)parserDidStartDocument:(NSXMLParser *)parser;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

@end
