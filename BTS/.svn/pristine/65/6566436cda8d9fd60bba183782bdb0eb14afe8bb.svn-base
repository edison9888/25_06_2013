//
//  PostData.m
//  Otsuka_BTS_Simulation
//
//  Created by administrator on 6/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PostData.h"
#import "ShellViewController.h"
#import "Config.h"

@interface PostData ()

- (NSString *) createPostString;

@end

@implementation PostData

@synthesize serverResponse;

static PostData *_instance = nil;

+ (PostData *) getInstance {
	if(_instance == nil) {
		_instance = [[self allocWithZone:NULL] init];
	}
	return _instance;
}

- (void) sendDataToServerForRound:(int) roundNum {
    //if (![ShellViewController userDataExists]) {
        //return;
    //}
    round = roundNum;
    
    NSLog(@"IN sendDataToServerForRound");
    
	NSString *postString = [NSString stringWithString:[self createPostString]];
	//NSString *postString = [NSString stringWithString:@"appID=BED7548A-7B29-5B74-AE2D-010B3C0AEBD8&data=(({AttemptID = 'CB3F55E8-8D6B-40B2-9E8F-802A31F853C3';Bookmark = '';FinishedAttempt = NO;KPIData =             {'Customer Results Score' = 0;'Trusted Advisor Relationship Score' = 0;};PageCount = 0;Status = 'Not Started';TotalScore = 0;}),({}))&nickname=dino"];
    
    //NSLog(@"postString >>> %@", postString);
	NSData *postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
    NSString *postPath = [[[Config getInstance] getConfig] objectForKey:@"dataPostPath"];
    //NSLog(@"postPath >>> %@", postPath);
	NSURL *url = [NSURL URLWithString:postPath];
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPBody:postData];	
	
	NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if(theConnection)
	{
        serverResponse = [[NSMutableData data] retain];
        NSLog(@"Connection On");
	}
	else {
        NSLog(@"Connection Failed");
	}
}


- (NSString *) createPostString {
    NSMutableDictionary *userData = [ShellViewController getUserData];
    
    NSString * loginId = [NSString stringWithFormat:@"LoginId=%@%@%@", [[UIDevice currentDevice] uniqueIdentifier], [userData objectForKey:@"firstName"], [userData objectForKey:@"lastName"]];
    NSString *firstName = [NSString stringWithFormat:@"FirstName=%@", [userData objectForKey:@"firstName"]];
    NSString *lastName = [NSString stringWithFormat:@"LastName=%@", [userData objectForKey:@"lastName"]];
    NSString * cliID = [NSString stringWithFormat:@"cliID=%@", [[[Config getInstance] getConfig] objectForKey:@"cliID"]];
	NSString *roundName = [NSString stringWithFormat:@"%@", [ShellViewController getNameForRound:round]];
    NSString * appID = [NSString stringWithFormat:@"%@", [[[[[Config getInstance] getConfig] objectForKey:@"rounds"] objectAtIndex:[ShellViewController getCurrentRound]] objectForKey:@"appID"]];
	
    NSMutableArray *attemptsData = [[[[userData objectForKey:@"Rounds"] objectAtIndex:[ShellViewController getCurrentRound]] mutableCopy] autorelease];
    
    for (int i=0; i<[attemptsData count]; i++) {
        if ([[[[attemptsData objectAtIndex:i] objectForKey:@"DataPosted"] uppercaseString] isEqualToString:@"YES"]) {
            [attemptsData removeObjectAtIndex:i];
        } else {
            [[attemptsData objectAtIndex:i] removeObjectForKey:@"KPIData"];
            [[attemptsData objectAtIndex:i] removeObjectForKey:@"isFeedbackHighlighted"];
            [[attemptsData objectAtIndex:i] removeObjectForKey:@"isInboxHighlighted"];
            [[attemptsData objectAtIndex:i] removeObjectForKey:@"isMetricsHighlighted"];
            [[attemptsData objectAtIndex:i] removeObjectForKey:@"PageCount"];
            [[attemptsData objectAtIndex:i] setValue:appID forKey:@"AppID"];
            [[attemptsData objectAtIndex:i] setValue:roundName forKey:@"RoundID"];
        }
    }
    //NSLog(@"attemptsData >>> %@", attemptsData);
    
	NSString *roundData = [NSString stringWithFormat:@"RoundData=%@", attemptsData];
    NSMutableString *postString = [NSString stringWithFormat:@"%@&%@&%@&%@&%@", loginId, firstName, lastName, cliID, roundData];
    
    //NSLog(@"postString >>> %@", postString);
    
    return postString;
}

-(void) connection: (NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [serverResponse setLength: 0];
    NSLog(@"Response Received");
}

-(void) connection: (NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [serverResponse appendData: data];
    NSLog(@"check data Received");
}

-(void) connection: (NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error");
	[connection release];
    [serverResponse release];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString * loginStatus = [[NSString alloc] initWithBytes: [serverResponse mutableBytes] length:[serverResponse length] encoding:NSUTF8StringEncoding];
    
	NSLog(@"loginStatus >>> %@", loginStatus);
    /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RESPONSE" 
                                                        message:loginStatus
                                                       delegate:self
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles: nil];
    [alertView show];
    [alertView release];
    */
    //loginStatus = @"success=true";
     NSRange successRange = [loginStatus rangeOfString:@"&success=true"];
    if (successRange.location != NSNotFound) {
        NSMutableDictionary *userData = [ShellViewController getUserData];
        NSMutableArray *attemptsData = [[userData objectForKey:@"Rounds"] objectAtIndex:round];
        [attemptsData removeObjectsInRange:NSMakeRange(1, [attemptsData count] - 1)];
        if ([[[[attemptsData objectAtIndex:0] objectForKey:@"FinishedAttempt"] uppercaseString] isEqualToString:@"YES"]) {
            [[attemptsData objectAtIndex:0] setValue:@"YES" forKey:@"DataPosted"];
        }
        //NSLog(@"loginStatus >>> %@", attemptsData);
        [ShellViewController writeUserData:userData];
        userData = [ShellViewController getUserData];
        //NSLog(@"userData >>> %@", userData);

    } else {
        NSLog(@"DATA NOT POSTED");
    }
    NSLog(@"data recieved");
    [connection release];
}

- (void) dealloc {
    [serverResponse release];
	[super dealloc];
}

@end
