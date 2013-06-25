//
//  EntityDetails.h
//  GreenVolts
//
//  Created by YML on 9/22/11.
//  Copyright 2011 YML. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EntityDetails : NSObject 
@property(nonatomic,strong) NSString *m_DNI;
@property(nonatomic,strong) NSString *m_DateTimeLocal;
@property(nonatomic,strong) NSString *m_Energy;
@property(nonatomic,strong) NSString *m_Power;
@property(nonatomic,strong) NSString *m_WindDirection;
@property(nonatomic,strong) NSString *m_WindSpeed;
@end
