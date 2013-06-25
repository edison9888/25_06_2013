//
//  HomeViewController.m
//  PE
//
//  Created by Nithin George on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "SectionViewController.h"
#import "GridCell.h"
#import "Helper.h"
#import "DBHandler.h"
#import "SettingViewController.h"

/////////////////////////////////////////////////////////////////////////////////////////

@implementation UINavigationBar (CustomImage)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage 
					  imageWithContentsOfFile:[[NSBundle mainBundle] 
											   pathForResource:@"navigationBar"
											   ofType:@"png"]];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end

/////////////////////////////////////////////////////////////////////////////////////////

@implementation HomeViewController

//@synthesize homeSectionItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}



#pragma mark - View lifecycle

- (void)viewDidLoad{
    
    // self.navigationController.navigationBar.translucent = YES;
  //self.navigationController.navigationBar.opaque = YES;
   // self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;

    [super viewDidLoad];
    [self createCustomNavigationLeftButton];
    [self loadHomeisplayArray];
    self.navigationItem.title=@"Casinos";
    [[NSUserDefaults standardUserDefaults]  setValue:@"nithingeorge" forKey:@"nithingeorge"];	
}

- (void)loadHomeisplayArray {
    
    // [[DBHandler sharedManager] beginTransaction];
    //[[DBHandler sharedManager] commitTransaction];
    //loading the home data from the table
    homeSectionItems=[[[DBHandler sharedManager]readHomeItems:HOME_TYPE] retain];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [gridView reloadData];
     [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)createCustomNavigationLeftButton {
    [self.navigationItem hidesBackButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 25);
    [button setBackgroundImage:[UIImage imageNamed:SETTING_IMAGE] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(iconButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    button=nil;
    [item release];
    item = nil;
}

#pragma mark -
#pragma mark Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath	{
	// Return the height of rows in the section.
	return 110;//125;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (HOME_SECTION_COUNT%COL_COUNT==0) {
        
              return (HOME_SECTION_COUNT/COL_COUNT);
    }

    else {

        return (HOME_SECTION_COUNT/COL_COUNT)+1;
    }
 
 }


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    // Try to retrieve from the table view a now-unused cell with the given identifier.
    GridCell *cell = (GridCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
          cell=[[[GridCell alloc] init] autorelease];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell displayCellItems:[self readHomeSectionItems:indexPath.row*COL_COUNT]:1];
	// Configure the cell.
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic may go here. Create and push another view controller.	
	
}

#pragma mark -
#pragma mark Home Section Items

- (NSMutableArray *)readHomeSectionItems:(int)index{
    
    NSMutableArray *secions =   nil;
    
    if ([homeSectionItems count] > 0) {
      
        secions=[[[NSMutableArray alloc]init] autorelease];
        for(int item=index ,col=0;item<HOME_SECTION_COUNT;item++,col++){
            if (col<COL_COUNT) 
                [secions addObject:[homeSectionItems  objectAtIndex:item]];
            else
                break;
        }
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"YOur Message" message:@"In home screen array count is zero"
                                                       delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
        [alert release];
        //[self loadHomeisplayArray];
        //[gridView reloadData];
    }
  return secions;
}


#pragma mark - Button Events

- (void)sectionButtonPresssed:(UIButton *)section{
    
    UIButton *button = (UIButton *)section;
    //[button.layer setBorderWidth:1.0];
   // [button.layer setCornerRadius:5.0];
   // [button.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    SectionViewController *sectionViewController=[[SectionViewController alloc] initWithNibName:SECTIONVIEWCONTROLLER_NIB_NAME bundle:nil];
    sectionViewController.sectionID=button.tag;
    [self.navigationController pushViewController:sectionViewController animated:YES];
    [sectionViewController release];
    sectionViewController=nil;
   
}

- (void)iconButtonClicked:(id)sender {

    SettingViewController *settingViewController=[[SettingViewController alloc]initWithNibName:SETTINGVIEWCONTROLLER_NIB_NAME bundle:nil];
    UINavigationController *settingNavigationController=[[UINavigationController alloc]initWithRootViewController:settingViewController];
    [self.navigationController presentModalViewController:settingNavigationController animated:YES];
    [settingViewController release];
    settingViewController=nil;
    [settingNavigationController release];
    settingNavigationController = nil;

}

#pragma mark-
#pragma mark Orientation methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
       return NO;
}

#pragma mark-
#pragma mark Memory Relese methods

- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc{
    [homeSectionItems release];
     gridView = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



@end
