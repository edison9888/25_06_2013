//
//  NSData+GVBlowfish.m
//  GreenVolts
//
//  Created by Jos Vandevelde on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSData+GVBlowfish.h"

@implementation NSData(GVBlowfish)

-(NSData *)encryptAsDES {
    NSData *key =  [[[UIDevice currentDevice] uniqueIdentifier] dataUsingEncoding:NSASCIIStringEncoding];       

    size_t outLength;
    NSMutableData *output = [NSMutableData dataWithLength:self.length + kCCBlockSizeDES];
    
    CCCryptorStatus res = CCCrypt(kCCEncrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding, key.bytes, kCCKeySizeDES, NULL, self.bytes, self.length, output.mutableBytes, output.length, &outLength);
    
    if (res == kCCSuccess)
        output.length = outLength;
    else {
        NSLog(@"error - encrypt (%d)", res);
        return nil;
    }
    
    return output;
}
       

-(NSString *)decryptAsDES {
    NSData *key = [[[UIDevice currentDevice] uniqueIdentifier] dataUsingEncoding:NSASCIIStringEncoding];         
    
    size_t outLength;
    NSMutableData *output = [NSMutableData dataWithLength:self.length];
    
    CCCryptorStatus res = CCCrypt(kCCDecrypt, kCCAlgorithmDES, kCCOptionPKCS7Padding, key.bytes, kCCKeySizeDES, NULL, self.bytes, self.length, output.mutableBytes, output.length, &outLength);
    
    if (res == kCCSuccess)
        output.length = outLength;
    else {
        NSLog(@"error - decrypt (%d)", res);
        return nil;
    }
    
    return [[NSString alloc] initWithData:output encoding:NSASCIIStringEncoding];
}   
@end
