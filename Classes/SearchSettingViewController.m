//
//  SearchSetting.m
//  Lottery
//
//  Created by eric on 09-12-6.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SearchSettingViewController.h"
#import "LotteryConfig.h"

@implementation SearchSettingViewController
@synthesize settingNames;
@synthesize settingKeys;
/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	settingNames = [[NSArray arrayWithObjects:@"期数", @"日期",@"中奖号码", nil] retain];
	settingKeys  = [[NSArray arrayWithObjects:kItemNo, kDate, kNumber, nil] retain];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}
/**
-(void)loadView {
	//self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	
	//add table view
	//tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStyleGrouped];
	//tableView.delegate = self;
	//tableView.dataSource = self;
	//[self.view addSubview:tableView];
	//[tableView release];
	
}**/
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.settingNames = nil;
	self.settingKeys = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@"%d", [settingNames count]);
    return [settingNames count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	cell.textLabel.text = [settingNames objectAtIndex:indexPath.row];
	cell.textLabel.font = [UIFont systemFontOfSize:14];
	NSUserDefaults *searchPrefs = [NSUserDefaults standardUserDefaults];
	NSLog(@"key:%@:pref:%@", [settingKeys objectAtIndex:indexPath.row], [searchPrefs objectForKey:[settingKeys objectAtIndex:indexPath.row]]);
	

	cell.accessoryType = ([searchPrefs boolForKey:[settingKeys objectAtIndex:indexPath.row]] == 1)? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *searchPrefs = [NSUserDefaults standardUserDefaults];
	
	for (int i=0; i < settingKeys.count; i++) {
		if (i != indexPath.row) {
			[searchPrefs setBool:NO forKey:[settingKeys objectAtIndex:i]];
			UITableViewCell *tcell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
			tcell.accessoryType = UITableViewCellAccessoryNone;
		}
	}
	[searchPrefs setBool:YES forKey:[settingKeys objectAtIndex:indexPath.row]];
	UITableViewCell *ncell = [tableView cellForRowAtIndexPath:indexPath];
	ncell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"搜索依据";
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
	[settingKeys release];
	[settingNames release];
}


@end

