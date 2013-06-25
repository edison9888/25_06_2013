//
//  MaintenanceLogBarCodeView.m
//  GreenVolts
//
//  Created by Shinu Mohan on 24/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MaintenanceLogBarCodeView.h"
#import "GreenVoltsAppDelegate.h"

@interface MaintenanceLogBarCodeView() 

-(void) loadview;
- (void)loadScannerView;
-(void)createCustomNavigationView;
- (void)displayOldORNewBarcodeImage;
- (NSString *)documentsPathForFileName:(NSString *)name;

@end

ZBarReaderViewController *reader;
UIImageView *resultImage;
NSString *barcodeValue;
NSString *newBarCodeTitle = @"Scan NEW Barcode";
NSString *oldBarCodeTilte = @"Scan OLD Barcode";
NSString *oldBarCodeImageName = @"oldBarCodeimage.png";
NSString *newBarCodeImageName = @"newBarCodeimage.png";
NSString *folderName = @"BarcodeImages";

UILabel *barcodeValueDisplayLabel;
UILabel *redLine;

@implementation MaintenanceLogBarCodeView
@synthesize isOLDBarCodeReader;
@synthesize delegate;
@synthesize barcodeNumber;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadview];
}
#pragma mark- initial methods
-(void) loadview
{
    [self createCustomNavigationView];
    
    //tile
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(120,50,150,30);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica - Bold" size:10];
    titleLabel.text = @"Hold Steady";
    [self.view addSubview:titleLabel];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIImageView *borderImageView = [[UIImageView alloc]init];
    borderImageView.frame = CGRectMake(50, 80, 220, 150);
    [borderImageView setImage:[UIImage imageNamed:@"Bar-Code-Frame.png"]];
    [self.view addSubview:borderImageView];
    
    
    resultImage = [[UIImageView alloc]init];
    resultImage.frame = CGRectMake(90, 100, 150, 100);
    resultImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:resultImage];
    
    barcodeValueDisplayLabel = [[UILabel alloc]init];
    barcodeValueDisplayLabel.frame = CGRectMake(100, 205, 460, 20);
    //barcodeValueDisplayLabel.textAlignment = UITextAlignmentLeft;
    barcodeValueDisplayLabel.textColor = [UIColor whiteColor];
    barcodeValueDisplayLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:barcodeValueDisplayLabel];
    
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanButton addTarget:self 
               action:@selector(scanButtonTouched:)
     forControlEvents:UIControlEventTouchUpInside];
    [scanButton setTitle:@"Scan" forState:UIControlStateNormal];
    [scanButton setTintColor:[UIColor whiteColor]];
    [scanButton setBackgroundImage:[UIImage imageNamed:@"button_subheader_generic_black.png"] forState:UIControlStateNormal];
    scanButton.frame = CGRectMake(130, 235, 60, 30);
    [self.view addSubview:scanButton];
    
    //red label
    redLine = [[UILabel alloc]init];
    redLine.frame = CGRectMake(70, 150, 190, 3);
    redLine.backgroundColor = [UIColor redColor];
    redLine.hidden = YES;
    [self.view addSubview:redLine];
    
    UILabel *bottamMessageLabel1 = [[UILabel alloc]init];
    bottamMessageLabel1.frame = CGRectMake(50,270,300,20);
    bottamMessageLabel1.textColor = [UIColor whiteColor];
    bottamMessageLabel1.backgroundColor = [UIColor clearColor];
    bottamMessageLabel1.font = [UIFont fontWithName:@"Helvetica - Bold" size:8];
    bottamMessageLabel1.text = @"Try to avoid shadows and glare.";//Barcode will scan automatically.
 
    [self.view addSubview:bottamMessageLabel1];

    if (barcodeNumber) {
        [self displayOldORNewBarcodeImage];
    }

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
    [button addTarget:self action:@selector(logbackButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:button]; 
    
    UILabel *logtitlelabel = [[UILabel alloc] initWithFrame:CGRectMake(100,10,200,25)];
    //logtitlelabel.numberOfLines = 0;//Dynamic
    logtitlelabel.backgroundColor = [UIColor clearColor];
    logtitlelabel.textColor = [UIColor whiteColor];
    
    if (isOLDBarCodeReader) 
        logtitlelabel.text = oldBarCodeTilte;
    else
        logtitlelabel.text = newBarCodeTitle;

    [navBar addSubview:logtitlelabel];
    [self.view addSubview:navBar];
 
}

- (void)displayOldORNewBarcodeImage
{
     barcodeValueDisplayLabel.text = self.barcodeNumber;
    
    NSString *imageName;
    
    if (isOLDBarCodeReader) 
        imageName =  oldBarCodeImageName;
    else
        imageName =  newBarCodeImageName;
    
    NSString *dataPath = [self documentsPathForFileName:folderName];
    
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",dataPath,imageName];
    NSData *pngData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *image = [UIImage imageWithData:pngData];

    resultImage.image = image;
}

- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);  
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name]; 
}

- (void)loadScannerView
{
    reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 1];
  
    GreenVoltsAppDelegate *appDelegate = (GreenVoltsAppDelegate *)[[UIApplication sharedApplication] delegate];
       
    [appDelegate.window.rootViewController presentModalViewController: reader
                            animated: YES];
}

#pragma mark- imagePickerController Delegates
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
     [reader dismissModalViewControllerAnimated:YES];
    if(self.delegate && [self.delegate respondsToSelector:@selector(backButtonTouched:)])
        [delegate backButtonTouched:self.view];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
     redLine.hidden = NO;
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
     barcodeValue = symbol.data;
     barcodeValueDisplayLabel.text = barcodeValue;
    resultImage.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    
    NSString *imageName;
    
    if (isOLDBarCodeReader) 
        imageName =  oldBarCodeImageName;
    else
        imageName =  newBarCodeImageName;
  
    // Saving into Documents folder
    NSString *dataPath = [self documentsPathForFileName:folderName];
    
    NSError *error = nil;

    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
    
    NSString *filePath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",imageName]];
    NSData *pngData = UIImagePNGRepresentation([info objectForKey: UIImagePickerControllerOriginalImage]);
    [pngData writeToFile:filePath atomically:YES];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];

}

#pragma mark- Button Actions
- (void)scanButtonTouched:(id)sender
{
    [self loadScannerView];
}

- (IBAction)logbackButtonTouched:(id)sender
{
    [reader dismissModalViewControllerAnimated: NO];
    [UIView animateWithDuration:.35 delay:0.0 options:UIViewAnimationCurveEaseOut animations:
     ^{
         //self.center = CGPointMake(self.center.x + CGRectGetWidth(self.frame), self.frame.origin.y);         
         CGRect newRect = self.view.frame;
         newRect.origin.x += newRect.size.width;
         self.view.frame = newRect;
     } completion:^(BOOL finished) {
         
         if ([barcodeValueDisplayLabel.text length]) 
         {
             if(self.delegate && [self.delegate respondsToSelector:@selector(barcodeScanSuccessfull: barcodeNumber:)])
                 [delegate barcodeScanSuccessfull:self.view barcodeNumber:barcodeValueDisplayLabel.text]; 
         }
         else 
         {
             
             if(self.delegate && [self.delegate respondsToSelector:@selector(backButtonTouched:)])
                 [delegate backButtonTouched:self.view];
         }
         

    }];
    
    [reader dismissModalViewControllerAnimated: YES];
    
}

@end
