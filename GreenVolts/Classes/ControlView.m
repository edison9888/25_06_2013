//
//  ControlView.m
//  GreenVolts
//
//  Created by Shinu Mohan on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ControlView.h"
#import "SBJson.h"
#import "LoginManager.h"
#import "GreenVoltsAppDelegate.h"

@interface ControlView()<LoginManagerDelegate>

-(void)handleAction;
-(void)connectToServer:(NSString *)pURLString;
-(void)jsonParser;
-(void)changeAccessToken;
-(void)checkArrayLockStatus;
-(void)fetchSessionToken;
-(void)handleException:(int)errorCode andAdditionalMessage:(NSString*)message;
@end

UIScrollView *controlScrollView;
UISlider *customRollSlider;
UISlider *customTiltSlider;

UILabel *rollValueDisplayLabel;
UILabel *tiltValueDisplayLabel;

UITextField *m_PasswordTextField;

int oldRollValue;
int oldTiltValue;

@implementation ControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self loadView];
        // Initialization code
    }
    return self;
}

- (UIImage*)resizedImage:(UIImage*)image forWidth:(float) newWidth forHeight:(float) newHeight
{
    
    CGRect frame = CGRectMake(0, 0, newWidth, newHeight);
    UIGraphicsBeginImageContext(frame.size);
    [image drawInRect:frame];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resizedImage;
}

-(void)loadView

{ 
    NSLog(@"loading control page");
    UILabel *pPasswordLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 310, 20)]; 
    pPasswordLabel.text=@"Reason for Change";
    pPasswordLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    pPasswordLabel.textColor = [UIColor whiteColor];
    pPasswordLabel.backgroundColor=[UIColor clearColor];
    pPasswordLabel.textAlignment=UITextAlignmentLeft;
    [self addSubview:pPasswordLabel];

    m_PasswordTextField=[[UITextField alloc]initWithFrame:CGRectMake(5, 30, 310, 30)];
    //m_PasswordTextField.placeholder = @"Reason for Change";
    m_PasswordTextField.borderStyle=UITextBorderStyleRoundedRect;
    m_PasswordTextField.returnKeyType=UIReturnKeyDone;
    m_PasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
    m_PasswordTextField.delegate=self;
    [self addSubview:m_PasswordTextField];  

    //allocating the scrollview
    controlScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 65, 310, 460)];
    controlScrollView.contentSize = CGSizeMake(310, 720);
    //controlScrollView.showsVerticalScrollIndicator = NO;
    controlScrollView.backgroundColor = [UIColor  blackColor];
    
    UIButton *pResumeTrackingButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pResumeTrackingButton.frame=CGRectMake(10,5, 90, 30);
    pResumeTrackingButton.backgroundColor=[UIColor clearColor];
    pResumeTrackingButton.tag=7;
    [pResumeTrackingButton setImage:[UIImage imageNamed:@"Track.png"] forState:UIControlStateNormal];
    [pResumeTrackingButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [pResumeTrackingButton setTitle:@"Resume Tracking" forState:UIControlStateNormal];
    [controlScrollView addSubview:pResumeTrackingButton];
    
    UIButton *pLockButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pLockButton.frame=CGRectMake(110,5, 90, 30);
    pLockButton.backgroundColor=[UIColor clearColor];
    pLockButton.tag=5;
    [pLockButton setImage:[UIImage imageNamed:@"Lock.png"] forState:UIControlStateNormal];
    [pLockButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [controlScrollView addSubview:pLockButton];

    UIButton *pUnLockButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pUnLockButton.frame=CGRectMake(210,5, 90, 30);
    pUnLockButton.backgroundColor=[UIColor clearColor];
    pUnLockButton.tag=6;
    [pUnLockButton setImage:[UIImage imageNamed:@"unlock.png"] forState:UIControlStateNormal];
    [pUnLockButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [controlScrollView addSubview:pUnLockButton];

    UILabel *movePresetPositionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 310, 20)];
    movePresetPositionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    movePresetPositionLabel.backgroundColor = [UIColor clearColor];
    movePresetPositionLabel.textColor = [UIColor yellowColor];
    movePresetPositionLabel.text = @"Move to Preset Position";
    [controlScrollView addSubview:movePresetPositionLabel];
    
    UIButton *pFaceUpButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pFaceUpButton.frame=CGRectMake(110, 70, 90, 30);
    pFaceUpButton.backgroundColor=[UIColor clearColor];
    pFaceUpButton.tag=1;
    [pFaceUpButton setImage:[UIImage imageNamed:@"FaceUp.png"] forState:UIControlStateNormal];
    [pFaceUpButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [controlScrollView addSubview:pFaceUpButton];
    
    UIButton *pFaceWestButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pFaceWestButton.frame=CGRectMake(50,120, 90, 30);
    pFaceWestButton.backgroundColor=[UIColor clearColor];
    pFaceWestButton.tag=2;
    [pFaceWestButton setImage:[UIImage imageNamed:@"FaceWest.png"] forState:UIControlStateNormal];
    [pFaceWestButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [controlScrollView addSubview:pFaceWestButton];  

    UIButton *pFaceEastButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pFaceEastButton.frame=CGRectMake(175, 120, 90, 30);
    pFaceEastButton.backgroundColor=[UIColor clearColor];
    pFaceEastButton.tag=3;
    [pFaceEastButton setImage:[UIImage imageNamed:@"FaceEast.png"] forState:UIControlStateNormal];
    [pFaceEastButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [controlScrollView addSubview:pFaceEastButton];

    UIButton *pFaceDownButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pFaceDownButton.frame=CGRectMake(110, 170, 90, 30);
    pFaceDownButton.backgroundColor=[UIColor clearColor];
    pFaceDownButton.tag=4;
    [pFaceDownButton setImage:[UIImage imageNamed:@"FaceDown.png"] forState:UIControlStateNormal];
    [pFaceDownButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [controlScrollView addSubview:pFaceDownButton];

    UILabel *moveCustomPositionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 240, 310, 20)];
    moveCustomPositionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    moveCustomPositionLabel.backgroundColor = [UIColor clearColor];
    moveCustomPositionLabel.textColor = [UIColor yellowColor];
    moveCustomPositionLabel.text = @"Move to Custom Position";
    [controlScrollView addSubview:moveCustomPositionLabel];
    
    UILabel *customPositionLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 270, 310, 20)];
    customPositionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    customPositionLabel.backgroundColor = [UIColor clearColor];
    customPositionLabel.textColor = [UIColor yellowColor];
    customPositionLabel.text = @"Custom Position";
    [controlScrollView addSubview:customPositionLabel];
    
    UILabel *rollLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 340, 30, 20)];
    rollLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    rollLabel.backgroundColor = [UIColor clearColor];
    rollLabel.textColor = [UIColor yellowColor];
    rollLabel.text = @"Roll";
    [controlScrollView addSubview:rollLabel];
    
    //RollSlider Background Image
    UIImageView *rollBackGroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(35, 335, 260, 25)];
    rollBackGroundImage.image =[UIImage imageNamed:@"Slider-Backgroundj.png"];
    [controlScrollView addSubview:rollBackGroundImage];

    //Roll Custom Slider
    CGRect customRollSliderframe = CGRectMake(40, 335, 250, 5);
    customRollSlider = [[UISlider alloc] initWithFrame:customRollSliderframe];
    [customRollSlider addTarget:self action:@selector(rollSliderAction:) forControlEvents:UIControlEventValueChanged];
    customRollSlider.backgroundColor = [UIColor clearColor]; 

    UIImage *stetchLeftTrack = [[self resizedImage:[UIImage imageNamed:@"Slider-Filler.png"] forWidth:230 forHeight:10]
                                stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];
    UIImage *stetchRightTrack = [[self resizedImage:[UIImage imageNamed:@"noImage.png"] forWidth:230 forHeight:10]
                                 stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];
    [customRollSlider setThumbImage: [self resizedImage:[UIImage imageNamed:@"Slider-Cap.png"] forWidth:30 forHeight:30] forState:UIControlStateNormal];
    [customRollSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [customRollSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    customRollSlider.minimumValue = -180;
    customRollSlider.maximumValue = 90;
    customRollSlider.continuous = YES;
    customRollSlider.value = 0.0;
    [controlScrollView addSubview:customRollSlider];
    

    UILabel *tiltLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 420, 30, 20)];
    tiltLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    tiltLabel.backgroundColor = [UIColor clearColor];
    tiltLabel.textColor = [UIColor yellowColor];
    tiltLabel.text = @"Tilt";
    [controlScrollView addSubview:tiltLabel];

    //Tilt Slider Background Image
    UIImageView *tiltBackGroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(35, 415, 260, 25)];
    tiltBackGroundImage.image =[UIImage imageNamed:@"Slider-Backgroundj.png"];
    [controlScrollView addSubview:tiltBackGroundImage];
    
    //Tilt Custom Slider
    CGRect customTiltSliderframe = CGRectMake(40, 415, 250, 5);
    customTiltSlider = [[UISlider alloc] initWithFrame:customTiltSliderframe];
    [customTiltSlider addTarget:self action:@selector(tiltSliderAction:) forControlEvents:UIControlEventValueChanged];
    customTiltSlider.backgroundColor = [UIColor clearColor];    

    [customTiltSlider setThumbImage: [self resizedImage:[UIImage imageNamed:@"Slider-Cap.png"] forWidth:30 forHeight:30] forState:UIControlStateNormal];
    [customTiltSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [customTiltSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    customTiltSlider.minimumValue = -35;
    customTiltSlider.maximumValue = 70;
    customTiltSlider.continuous = YES;
    //customTiltSlider.value = 20.0;
    [controlScrollView addSubview:customTiltSlider];
    
    //rollValueDisplay Label
    rollValueDisplayLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 310, 30, 30)];
    rollValueDisplayLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    rollValueDisplayLabel.backgroundColor = [UIColor clearColor];
    rollValueDisplayLabel.textColor = [UIColor yellowColor];
    rollValueDisplayLabel.textAlignment = UITextAlignmentCenter;
    rollValueDisplayLabel.text = [NSString stringWithFormat:@"%d",ceilf(customRollSlider.value)];
    [controlScrollView addSubview:rollValueDisplayLabel];
    
    //tiltValueDisplay Label
    tiltValueDisplayLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 390, 30, 30)];
    tiltValueDisplayLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    tiltValueDisplayLabel.backgroundColor = [UIColor clearColor];
    tiltValueDisplayLabel.textColor = [UIColor yellowColor];
    tiltValueDisplayLabel.textAlignment = UITextAlignmentCenter;
    tiltValueDisplayLabel.text = [NSString stringWithFormat:@"%d",ceilf(customTiltSlider.value)];
    [controlScrollView addSubview:tiltValueDisplayLabel];
    
    
    UIButton *applyButton=[UIButton buttonWithType:UIButtonTypeCustom];
    applyButton.frame=CGRectMake(110, 480, 90, 30);
    applyButton.backgroundColor=[UIColor lightGrayColor];
    applyButton.tag=9;
    [applyButton  setTitle:@"Apply" forState:UIButtonTypeCustom];
    //[applyButton setImage:[UIImage imageNamed:@"FaceDown.png"] forState:UIControlStateNormal];
    [applyButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [controlScrollView addSubview:applyButton];
    
    [self addSubview:controlScrollView];

}

#pragma mark- button Actions
-(void)rollSliderAction:(id)sender
{
    NSLog(@"SCROLLVALUE customRollSlider::: %f",customRollSlider.value);

    oldRollValue = ceilf(customRollSlider.value);;
    rollValueDisplayLabel.text = [NSString stringWithFormat:@"%d",oldRollValue];
}
-(void)tiltSliderAction:(id)sender
{
    NSLog(@"SCROLLVALUE tiltSliderAction ::: %f",customTiltSlider.value);
    
    oldTiltValue = ceilf(customTiltSlider.value);
    int value  =ceilf(customTiltSlider.value);
    tiltValueDisplayLabel.text = [NSString stringWithFormat:@"%d",value];
}

-(void)buttonAction:(UIButton*)button
{
#ifdef DEMO_BUILD
    
    switch (button.tag)
    {
        case 1:
            self.operationPerformed = @"Face Up";
            break;
        case 2:
            self.operationPerformed = @"Face West";
            break;
        case 3:
            self.operationPerformed = @"Face East";
            break;
        case 4:
            self.operationPerformed = @"Face Down";
            break;
        case 5:
            self.operationPerformed = @"Lock";
            break;
        case 6:
            self.operationPerformed = @"Unlock";
            break;
        case 7:
            self.operationPerformed = @"Resume Tracking";
            break;
        case 9:
            //Roll and Tilt
            break;
        default:
            self.operationPerformed = @"";
            break;
            
    }
    
    UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    pAlert.tag=1;
    [pAlert show];
    //return;
#else
    
    [m_PasswordTextField resignFirstResponder];
    switch (button.tag)
    {
        case 1:
            //Face Up
            actionState=MOVE;
            moveDirection=UP;
            [self handleAction];
            break;
        case 2:
            //Face West
            actionState=MOVE;
            moveDirection=WEST;
            [self handleAction];
            break;
        case 3:
            //Face East
            actionState=MOVE;
            moveDirection=EAST;
            [self handleAction];
            break;
        case 4:
            //Face Down
            actionState=MOVE;
            moveDirection=DOWN;
            [self handleAction];
            break;
        case 5:
            //Lock
            actionState=LOCK;
            [self handleAction];
            break;
        case 6:
            //Unlock
            actionState=UNLOCK;
            [self handleAction];
            break;
        case 7:
            //Resume Tracking
            actionState=MOVE;
            moveDirection=RESUME;
            [self handleAction];
            break;
        case 9:
            //Roll and Tilt
            actionState = ROLL_AND_TILT;
            [self handleAction];
            break;
        default:
            break;
    }
#endif
}

#pragma mark - 

-(void)handleAction
{
    NSString *value = [m_PasswordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(value.length==0)
    {
        UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Reason for change is mandatory." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:NULL];
        pAlert.tag=0;
        [pAlert show];
        moveDirection=NO_DIRECTION;
        actionState=UNAVAILABLE;
    }
    else
    {
        UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
        pAlert.tag=1;
        [pAlert show];
    }
}

#pragma mark UIAlertView delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
#ifdef DEMO_BUILD
    if (alertView.tag==1) {
        
        if (buttonIndex==0) {
            sleep(1);
            
            if(self.operationPerformed != @"")
            {
                UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%@ Success", self.operationPerformed] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:NULL];
                [pAlert show];
                pAlert=nil;  
            }
            
        }    
        
        
    }
    return;
#endif
    
    if(alertView.tag==0)
    {
        m_PasswordTextField.text=@"";
        [m_PasswordTextField becomeFirstResponder];
        return; 
    }
    if(buttonIndex==1)
        return;
    NSString *pSessionToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"SESSION_TOKEN"];
    NSString *pEntityType=[[NSUserDefaults standardUserDefaults]objectForKey:@"ENTITY_TYPE"];
    NSString *pEntityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"];
    switch (actionState)
    {
        case MOVE:
        {
            NSArray *directionArray=[NSArray arrayWithObjects:@"UP",@"WEST",@"EAST",@"DOWN",@"RESUME",nil];
            NSString *direction=nil;
            if(moveDirection!=NO_DIRECTION)
                direction=[directionArray objectAtIndex:moveDirection];
            if(direction)
            {
                urlString=[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/MoveTracker?sessionToken=%@&entityScope=%@&entityID=%@&action=%@&logReason=%@",kserverAddress,pSessionToken,pEntityType,pEntityId,direction,[m_PasswordTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
               // [self connectToServer:urlString];
                if([pEntityType isEqualToString:@"4"])
                    [self checkArrayLockStatus];
                else
                    [self connectToServer:urlString];
            }
        }
            break;
        case LOCK:
        {
            urlString = [NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/LockArray?sessionToken=%@&arrayID=%@&logReason=%@",kserverAddress,pSessionToken,pEntityId,[m_PasswordTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [self connectToServer:urlString];
        }
            break;
        case UNLOCK:
        {
           urlString =[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/UnLockArray?sessionToken=%@&arrayID=%@&logReason=%@",kserverAddress,pSessionToken,pEntityId,[m_PasswordTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [self connectToServer:urlString];


        }
            break;
        case ROLL_AND_TILT:
        {
            NSString *customRollValue = [NSString stringWithFormat:@"%d",oldRollValue];
            NSString *customTiltValue = [NSString stringWithFormat:@"%d",oldTiltValue];
            
            
            urlString = [NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/MoveTracker?customRoll=%@&logReason=%@&sessionToken=%@&action=CUSTOM&entityID=%@&entityScope=%@&customTilt=%@",kserverAddress,customRollValue,[m_PasswordTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],pSessionToken,pEntityId,pEntityType,customTiltValue];
            //[self connectToServer:urlString];
            if([pEntityType isEqualToString:@"4"])
                [self checkArrayLockStatus];
            else
                [self connectToServer:urlString];

            
        }
            break;
        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    m_PasswordTextField.text=@"";
    //pTitleLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"ENTITY_NAME"];
}

#pragma mark URLConnectionManager Methods
-(void)checkArrayLockStatus
{
    if(m_ActivityIndicatorView)
    {
        [m_ActivityIndicatorView removeFromSuperview];
        m_ActivityIndicatorView=nil;
    }
    m_ActivityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(150, 200, 30, 30)];
    [m_ActivityIndicatorView startAnimating];
    m_ActivityIndicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
    [self addSubview:m_ActivityIndicatorView];  
    
	if(mURLConnection) 
	{
		[mURLConnection cancel];
		mURLConnection=nil;
	}
    if(mResponseData)
	{
		mResponseData=nil;
	}
    NSString *pSessionToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"SESSION_TOKEN"];
    NSString *pEntityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"ID"];
    
    
    NSString *pURLString=[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetArrayLockStatus?sessionToken=%@&arrayID=%@",kserverAddress,pSessionToken,pEntityId];
    NSLog(@"ArrayLock: %@", pURLString);
	mURLConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pURLString]] delegate:self];
    isArrayLockStatusCheck=YES;
}
-(void)connectToServer:(NSString *)pURLString
{
    isArrayLockStatusCheck=NO;
    urlString=nil;
    urlString=[pURLString copy];
    if(m_ActivityIndicatorView)
    {
        [m_ActivityIndicatorView removeFromSuperview];
        m_ActivityIndicatorView=nil;
    }
    m_ActivityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(150, 200, 30, 30)];
    [m_ActivityIndicatorView startAnimating];
    m_ActivityIndicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
    [self addSubview:m_ActivityIndicatorView];  
    
	if(mURLConnection) 
	{
		[mURLConnection cancel];
		mURLConnection=nil;
	}
    if(mResponseData)
	{
		mResponseData=nil;
	}
    
    
    NSLog(@"URL REQ");
    
    // NSLog(@"URL Request: %@",[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetMaintenancePlans?sessionToken=%@&siteID=%@&entity scope=%@&entityID=%@&maintenancePlanTypeID=%@&ownerID=%@&completed=%@&componentTypeID=%@&",kserverAddress,sessionToken,siteID,entityscope,entityID,maintenancePlanTypeID,ownerID,completed,componentTypeID]);  
    
	mURLConnection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pURLString]] delegate:self];
    
    
    
    
    
    
    //NSLog(@"URL Request: %@",[NSString stringWithFormat:@"%@/GreenVolts-ISIS-BL-Web-Models-iPhone-iPhone_DS.svc/JSON/GetMaintenancePlans?sessionToken=%@&siteID=%@&entity scope=%@&entityID=%@&maintenancePlanTypeID=%@&ownerID=%@&completed=%@&componentTypeID=%@&",kserverAddress,sessionToken,siteID,entityscope,entityID,maintenancePlanTypeID,ownerID,completed,componentTypeID]);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
    if(!mResponseData)
        mResponseData=[NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [mResponseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    if(m_ActivityIndicatorView){[m_ActivityIndicatorView removeFromSuperview];m_ActivityIndicatorView=nil;}
    
    UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Make sure your device has an active network connection and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:NULL];
    [pAlert show];
    pAlert=nil;        
    
    if(mURLConnection) 
	{
		[mURLConnection cancel];
		mURLConnection=nil;
	}
	if(mResponseData)
	{
		mResponseData=nil;
	}
    
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if(mURLConnection) 
	{
		[mURLConnection cancel];
		mURLConnection=nil;
	}
    if(m_ActivityIndicatorView){[m_ActivityIndicatorView removeFromSuperview];m_ActivityIndicatorView=nil;}
    [self jsonParser];
}	

-(void)jsonParser
{
    NSString *responseString=[[NSString alloc]initWithData:mResponseData encoding:NSUTF8StringEncoding];
    NSLog(@"JSON Request::::::\n%@",urlString);
    NSLog(@"JSON Response:::::\n%@",responseString);
    mResponseData=nil;
    
    NSDictionary *data=[responseString JSONValue];
    if(isArrayLockStatusCheck)
    {
        NSDictionary *userResult= [data objectForKey:@"GetArrayLockStatusResult"]; 
        
        NSArray *rootResult = [userResult objectForKey:@"RootResults"];
        
        if([rootResult count])
        {
            NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
            
            NSString *error=[rootResultDict objectForKey:@"Err"];
            
            NSDictionary *resultDict=[rootResult objectAtIndex:0];
            
            if ([resultDict valueForKey:@"IsLocked"] != NULL) {
                NSLog(@"Result is NULL");
            }
            BOOL isArrayLocked=[[resultDict valueForKey:@"IsLocked"] boolValue];
            
            if(isArrayLocked)
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                isArrayLockStatusCheck=NO;
                [self changeAccessToken];
                [self connectToServer:urlString];
            }
            
            NSNumber *errorId=[rootResultDict objectForKey:@"ErrID"];
            if([errorId intValue]==10001)
            {
                NSString *exception=[rootResultDict objectForKey:@"Err"];
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:exception delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            } 
            if ([errorId intValue]==10003)
            {
                [self fetchSessionToken];
            }
        }
    }
    else
    {
        switch (actionState)
        {
            case MOVE:
            {
                NSDictionary *userResult= [data objectForKey:@"MoveTrackerResult"]; 
                
                NSArray *rootResult = [userResult objectForKey:@"RootResults"];
                
                if([rootResult count])
                {
                    NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
                    
                    NSObject *error=[rootResultDict objectForKey:@"Err"];
                    
                    if([error isKindOfClass:[NSNull class]])
                    {
                        urlString=nil;
                        NSDictionary *resultDict=[rootResult objectAtIndex:0];
                        
                        NSObject *presultStatus=[resultDict objectForKey:@"Result"];
                        NSString *message;
                        if(![presultStatus isKindOfClass:[NSNull class]])
                        {
                            message = [rootResultDict objectForKey:@"Result"];

                        }
                        else 
                            message = @"Null response from Server";
                        UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:NULL];
                        [pAlert show];
                        pAlert=nil;  
                        moveDirection=NO_DIRECTION;
                    }
                    else 
                    {
                        NSNumber *errorId=[rootResultDict objectForKey:@"ErrID"];
                        if ([errorId intValue]==10003)
                        {
                            [self handleException:10003 andAdditionalMessage:nil];
                        }
                        else if([errorId intValue]==10001)
                        {
                            [self handleException:10001 andAdditionalMessage:[rootResultDict objectForKey:@"Error"]];
                        }
                        else if([errorId intValue]==10014)
                        {
                            [self handleException:10014 andAdditionalMessage:nil];
                        }
                        else if([errorId intValue]==10015)
                        {
                            [self handleException:10015 andAdditionalMessage:[rootResultDict objectForKey:@"Error"]];
                        }
                        else if([errorId intValue]==10016)
                        {
                            [self handleException:10016 andAdditionalMessage:[rootResultDict objectForKey:@"Error"]];
                        }
                    }
                }
            }
                break;
            case LOCK:
            {
                NSDictionary *userResult= [data objectForKey:@"LockArrayResult"]; 
                
                NSArray *rootResult = [userResult objectForKey:@"RootResults"];
                
                if([rootResult count])
                {
                    NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
                    
                    NSObject *error=[rootResultDict objectForKey:@"Err"];
                    
                    if([error isKindOfClass:[NSNull class]])
                    {
                        urlString=nil;
                        NSDictionary *resultDict=[rootResult objectAtIndex:0];
                        
                        NSObject *presultStatus=[resultDict objectForKey:@"Result"];
                        NSString *message;
                        if(![presultStatus isKindOfClass:[NSNull class]])
                        {
                            message = [rootResultDict objectForKey:@"Result"];
                            
                        }
                        else 
                            message = @"Null response from Server";
                        UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:NULL];
                        [pAlert show];
                        pAlert=nil;  
                        moveDirection=NO_DIRECTION;
                    }
                    else 
                    {
                        NSNumber *errorId=[rootResultDict objectForKey:@"ErrID"];
                        
                        if([errorId intValue]==10001)
                        {
                            [self handleException:10001 andAdditionalMessage:[rootResultDict objectForKey:@"Err"]];
                        }
                        else if([errorId intValue]==10003)
                        {
                            [self handleException:10003 andAdditionalMessage:nil];
                        }
                        else if([errorId intValue]==10017)
                        {
                            [self handleException:10017 andAdditionalMessage:nil];
                        }
                        else if([errorId intValue]==10018)
                        {
                            [self handleException:10018 andAdditionalMessage:nil];
                        }
                       
                    }
                }
            }
                break;
            case UNLOCK:
            {
                NSDictionary *userResult= [data objectForKey:@"UnLockArrayResult"]; 
                
                NSArray *rootResult = [userResult objectForKey:@"RootResults"];
                
                if([rootResult count])
                {
                    NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
                    
                    NSObject *error=[rootResultDict objectForKey:@"Err"];
                    
                    if([error isKindOfClass:[NSNull class]])
                    {
                        urlString=nil;
                        NSDictionary *resultDict=[rootResult objectAtIndex:0];
                        
                        NSObject *presultStatus=[resultDict objectForKey:@"Result"];
                        NSString *message;
                        if(![presultStatus isKindOfClass:[NSNull class]])
                        {
                            message = [rootResultDict objectForKey:@"Result"];
                            
                        }
                        else 
                            message = @"Null response from Server";
                        UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:NULL];
                        [pAlert show];
                        pAlert=nil;  
                        moveDirection=NO_DIRECTION;
                    }
                    else 
                    {        
                        NSNumber *errorId=[rootResultDict objectForKey:@"ErrID"];
                        if([errorId intValue]==10001)
                        {
                            [self handleException:10001 andAdditionalMessage:[rootResultDict objectForKey:@"Err"]];
                        }
                        else if([errorId intValue]==10003)
                        {
                            [self handleException:10003 andAdditionalMessage:nil];
                        }
                        else if([errorId intValue]==10019)
                        {
                            [self handleException:10019 andAdditionalMessage:nil];
                        }
                        else if([errorId intValue]==10020)
                        {
                            [self handleException:10020 andAdditionalMessage:nil];
                        }

                    }
                }
            }
                break;
            case ROLL_AND_TILT:
            {
                NSDictionary *userResult= [data objectForKey:@"MoveTrackerResult"]; 
                
                NSArray *rootResult = [userResult objectForKey:@"RootResults"];
                
                if([rootResult count])
                {
                    NSDictionary *rootResultDict=[rootResult objectAtIndex:0];
                    
                    NSObject *error=[rootResultDict objectForKey:@"Err"];
                    
                    if([error isKindOfClass:[NSNull class]])
                    {
                        urlString=nil;
                        NSDictionary *resultDict=[rootResult objectAtIndex:0];
                        
                        NSObject *presultStatus=[resultDict objectForKey:@"Result"];
                        NSString *message;
                        if(![presultStatus isKindOfClass:[NSNull class]])
                        {
                            message = [rootResultDict objectForKey:@"Result"];
                            
                        }
                        else 
                            message = @"Null response from Server";
                        UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:NULL];
                        [pAlert show];
                        pAlert=nil;  
                        moveDirection=NO_DIRECTION;
                    }
                    else 
                    {
                        NSNumber *errorId=[rootResultDict objectForKey:@"ErrID"];
                        
                        if([errorId intValue]==10001)
                        {
                            [self handleException:10001 andAdditionalMessage:[rootResultDict objectForKey:@"Err"]];
                        }
                        else if([errorId intValue]==10003)
                        {
                            [self handleException:10003 andAdditionalMessage:nil];
                        }
                        else if([errorId intValue]==10017)
                        {
                            [self handleException:10017 andAdditionalMessage:nil];
                        }
                        else if([errorId intValue]==10018)
                        {
                            [self handleException:10018 andAdditionalMessage:nil];
                        }
                        
                    }
                }
            }
                break;
            default:
                break;
        }    
    }
}
-(void)fetchSessionToken
{
    if(!m_Connection)
    {
        m_Connection=[[Connection alloc]init];
        m_Connection.m_delegate=self;
    }
    [m_Connection connectToServer];
    if(m_ActivityIndicatorView)
    {
        [m_ActivityIndicatorView removeFromSuperview];
        m_ActivityIndicatorView=nil;
    }
    m_ActivityIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(150, 200, 30, 30)];
    [m_ActivityIndicatorView startAnimating];
    m_ActivityIndicatorView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
    [self addSubview:m_ActivityIndicatorView];  
}
#pragma mark -- ConnectionDelegate
-(void)ConnectionFailed
{
    UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Make sure your device has an active network connection and try again"  
                                                 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:NULL];
    [pAlert show];
    pAlert=nil;
}
-(void)InvalidUserNameError:(int)errorIndex
{
    if(errorIndex==0)
    {
        UIAlertView *pAlert=[[UIAlertView alloc]initWithTitle:@"" message:@"Cannot connect to backend systems" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:NULL];
        [pAlert show];
        pAlert=nil;              
    }
    else if(errorIndex==1)
    {
        [[LoginManager sharedLoginManagerWithDelegate:self] ShowLoginPage];
    }  
}
-(void)Success
{
    if(isArrayLockStatusCheck)
    {
        [self checkArrayLockStatus];
    }
    else
    {
        [self changeAccessToken];
        [self connectToServer:urlString];   
    }
    
}

-(void)handleException:(int)errorCode andAdditionalMessage:(NSString*)message
{
    switch (errorCode)
    {
        case 10001:
        {
            NSString *pMessage=@"";
            if(message)
                pMessage=message;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Exception" message:pMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case 10003:
        {
            [self fetchSessionToken];
        }
            break;
        case 10014:
        {
            NSString *pMessage=@"Cannot issue command to tracker.";
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:pMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case 10015:
        {
            NSString *pMessage=@"Command failed with error: ";
            if(message)
                pMessage=[NSString stringWithFormat:@"%@%@",pMessage,message];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:pMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case 10016:
        {
            NSString *pMessage=@"";
            if(message)
                pMessage=message;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:pMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case 10017:
        {
            NSString *pMessage=@"Array already locked.";
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:pMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case 10018:
        {
            NSString *pMessage=@"Array lock failed.";
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:pMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case 10019:
        {
            NSString *pMessage=@"Array already unlocked.";
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:pMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        case 10020:
        {
            NSString *pMessage=@"Array unlock failed.";
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:pMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}
-(void)changeAccessToken
{
    NSString *query=[[urlString componentsSeparatedByString:@"?"] objectAtIndex:1];
    NSMutableArray *mutableQueryComponents=[NSMutableArray arrayWithArray:[query componentsSeparatedByString:@"&"]];
    for (int i=0;i<[mutableQueryComponents count];i++)
    {
        NSString *component=[mutableQueryComponents objectAtIndex:i];
        if([component hasPrefix:@"sessionToken="])
        {
            NSString *pSessionToken=[[NSUserDefaults standardUserDefaults]objectForKey:@"SESSION_TOKEN"];    
            component=[NSString stringWithFormat:@"sessionToken=%@",pSessionToken];
            [mutableQueryComponents replaceObjectAtIndex:i withObject:component];
            break;
        }
    }
    query=[mutableQueryComponents componentsJoinedByString:@"&"];
    NSString *serverPath=[[urlString componentsSeparatedByString:@"?"] objectAtIndex:0];
    urlString=[NSString stringWithFormat:@"%@?%@",serverPath,query];
}

#pragma mark LoginManagerDelegate methods
-(void)loginManager:(LoginManager*)manager loggedInSuccesfullyWithSessionToken:(NSString*)sessionToken
{
    [[NSUserDefaults standardUserDefaults]setObject:sessionToken forKey:@"SESSION_TOKEN"];  
    
    //have to right the rite code based on the requirment now requrment is not clear
    //[self.navigationController dismissModalViewControllerAnimated:YES];
    
    GreenVoltsAppDelegate* appDelegate=(GreenVoltsAppDelegate*)[UIApplication sharedApplication].delegate;
    UITabBarController *tabBar=(UITabBarController *)appDelegate.RootViewController;
    tabBar.selectedIndex=0;
    [appDelegate tabBarController:tabBar didSelectViewController:nil];
    UINavigationController *navC=[tabBar.viewControllers objectAtIndex:0];
    [navC popToRootViewControllerAnimated:YES];
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [m_PasswordTextField resignFirstResponder];
    return YES;
}

@end
