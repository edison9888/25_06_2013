//
//  MaintenanceLogDetailPickerView.m
//  GreenVolts
//
//  Created by Shinu Mohan on 24/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaintenanceLogDetailPickerView.h"

@interface MaintenanceLogDetailPickerView() 

-(void)createCustomNavigationView;
- (IBAction)logbackButtonTouched:(id)sender;   
@end
@implementation MaintenanceLogDetailPickerView
//@synthesize pickerview;
@synthesize delegate;
@synthesize currentTime;
#pragma mark-initialisation


- (id)initWithFrame:(CGRect)frame andTime:(NSString*)time
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        self.currentTime=time;
        [self loadview];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark-load views

-(void) loadview
{    
    [self createCustomNavigationView];
    notesview=[[UIView alloc]initWithFrame:CGRectMake(0,45,320,330)];
    //notesview.backgroundColor=[UIColor darkGrayColor];
    notesview.backgroundColor=[UIColor colorWithRed:30/255.0f green:37/255.0f blue:38/255.0f alpha:1.0];
    [self addSubview:notesview];
    taskupdatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,45,320,330)];
    taskupdatePicker.datePickerMode = UIDatePickerModeTime;
    taskupdatePicker.minuteInterval=15;       
    if(currentTime)
    {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSDate *date = [dateFormat dateFromString:currentTime]; 
    [taskupdatePicker setDate:date];
    }
    
    taskupdatePicker.backgroundColor = [UIColor blueColor];
    [taskupdatePicker addTarget:self action:@selector(pickerChanged:)forControlEvents:UIControlEventValueChanged];
    [self addSubview:taskupdatePicker];
  
}

#pragma mark-custom methods

-(void)createCustomNavigationView
{
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
     //navBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navpopover_cell_backround (2)"]];
    navBar.tintColor=[UIColor colorWithRed:1/255.f green:14/255.f blue:41/255.f alpha:1];

    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(5,5,80,30);
    button.backgroundColor=[UIColor clearColor];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"Back.png"] forState:UIControlStateNormal];
     [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(logbackButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:button]; 
    
    UILabel *logtitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(100,10,200,25)];
    //logtitlelabel.numberOfLines = 0;//Dynamic
    logtitlelabel.backgroundColor = [UIColor clearColor];
    logtitlelabel.textColor = [UIColor whiteColor];
    logtitlelabel.text = @"Task Duration";
    [navBar addSubview:logtitlelabel];
    
    [self addSubview:navBar];
}

#pragma mark-button actions

- (IBAction)logbackButtonTouched:(id)sender
{
    [UIView animateWithDuration:.35 delay:0.0 options:UIViewAnimationCurveEaseOut animations:
     ^{
         //self.center = CGPointMake(self.center.x + CGRectGetWidth(self.frame), self.frame.origin.y);         
         CGRect newRect = self.frame;
         newRect.origin.x += newRect.size.width;
         self.frame = newRect;
     } completion:^(BOOL finished) {
         if(self.delegate && [self.delegate respondsToSelector:@selector(backButtonTouched:)])
             [delegate backButtonTouched:self];
     }];
}


#pragma mark-picker methods

- (void)pickerChanged:(id)sender
{
    NSLog(@"picker changed");
     //animate
    NSDate *selectedDate = taskupdatePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm"];
    NSString *dateString = [dateFormat stringFromDate:selectedDate];
    NSLog(@"%@",dateString);
   // [taskupdatePicker setDate:selectedDate];
    if(self.delegate && [self.delegate respondsToSelector:@selector(pickerUpdateToLog:)])
        [self.delegate pickerUpdateToLog:dateString]; 
}

- (void)pickerView:(UIPickerView *)pV didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


- (IBAction)selecttaskduration:(id)sender 
{
    
}
@end

