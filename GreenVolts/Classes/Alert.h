//
//  Alert.h
//  GreenVolts
//
//  Created by YML on 9/21/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Alert : NSObject 

@property(nonatomic,strong) NSString *m_Description;
@property(nonatomic,strong) NSString *m_Severity;
@property(nonatomic,strong) NSString *m_AlarmId;
@end
