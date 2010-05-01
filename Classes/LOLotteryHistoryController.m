//
//  LOLotteryHistoryController.m
//  Lottery
//
//  Created by eric on 09-12-2.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <sqlite3.h>
#import "LOLotteryHistoryController.h"
#import "Lottery.h"
#import "SearchSettingViewController.h"
#import "LotteryConfig.h"

@implementation LOLotteryHistoryController

@synthesize search;
//@synthesize searchSettingsController;
@synthesize historyTableView;
//@synthesize allLotteryHistoryData;
@synthesize lotteryHistoryData;
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
	
	[self initHistoryData];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self createSearchBar];
}

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

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.search = nil;
	self.historyTableView = nil;
//	self.allLotteryHistoryData = nil;
	self.lotteryHistoryData = nil;
//	self.searchSettingsController = nil;
}

- (void)dealloc {
	[historyTableView release];
	[search release];
	[searchSettingsController release];
	[allLotteryHistoryData release];
	[lotteryHistoryData release];
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [lotteryHistoryData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"LotteryHistoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [self createCellContentView:CellIdentifier];
    }
	UILabel *itemLabel = (UILabel *)[cell viewWithTag:1];
	UILabel *dateLabel = (UILabel *)[cell viewWithTag:2];
   // UILabel *titleLabel = (UILabel *)[cell viewWithTag:3];
	UILabel *redLabel = (UILabel *)[cell viewWithTag:3];
	UILabel *blueLabel = (UILabel *)[cell viewWithTag:4];
    // Set up the cell...
	Lottery *tmpLottery = [lotteryHistoryData objectAtIndex:indexPath.row];
	//期数
	itemLabel.text = tmpLottery.ItemNO;
	//日期
	dateLabel.text = tmpLottery.date;
	//titleLabel.text = @"中奖号码:";
	int tl = tmpLottery.hitNumber.length;
	NSString *red1 = [tmpLottery.hitNumber substringToIndex:2];
	NSString *red2 = [tmpLottery.hitNumber substringWithRange:NSMakeRange(tl - 12, 2)];
	NSString *red3 = [tmpLottery.hitNumber substringWithRange:NSMakeRange(tl - 10, 2)];
	NSString *red4 = [tmpLottery.hitNumber substringWithRange:NSMakeRange(tl - 8, 2)];
	NSString *red5 = [tmpLottery.hitNumber substringWithRange:NSMakeRange(tl - 6, 2)];
	NSString *red6 = [tmpLottery.hitNumber substringWithRange:NSMakeRange(tl - 4, 2)];
	redLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", red1, red2, red3, red4, red5, red6];
	blueLabel.text = [tmpLottery.hitNumber substringFromIndex:tmpLottery.hitNumber.length-2];

    return cell;
}

-(UITableViewCell *)createCellContentView:(NSString *)cellIdentifier {
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 60) reuseIdentifier:cellIdentifier] autorelease];
	UILabel *tmpLabel;
	//期数
	tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
	tmpLabel.tag = 1;
	tmpLabel.font = [UIFont boldSystemFontOfSize:12];
	[cell.contentView addSubview:tmpLabel];
	[tmpLabel release];
	//日期
	tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 90, 30)];
	tmpLabel.tag = 2;
	tmpLabel.font = [UIFont boldSystemFontOfSize:12];
	[cell.contentView addSubview:tmpLabel];
	[tmpLabel release];
	//红球
	tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 10, 110, 30)];
	tmpLabel.tag = 3;
	tmpLabel.font = [UIFont boldSystemFontOfSize:12];
	tmpLabel.textColor = [UIColor redColor]; 
	[cell.contentView addSubview:tmpLabel];
	[tmpLabel release];
	//蓝球
	tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(285, 10, 80, 30)];
	tmpLabel.tag = 4;
	tmpLabel.font = [UIFont boldSystemFontOfSize:12];
	tmpLabel.textColor = [UIColor blueColor];
	[cell.contentView addSubview:tmpLabel];
	[tmpLabel release];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
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


#pragma mark SearchBar Delegate implement
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	
	//[lotteryHistoryData removeAllObjects];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	searchBar.showsCancelButton = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	//NSLog(@"all:%@", allLotteryHistoryData);
//	NSLog(@"cancel retain count:%d", [lotteryHistoryData retainCount]);
	[self reloadHistoryData];
	[historyTableView reloadData];
	search.text = @"";
	[search resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	NSString *searchNum = [searchBar text];
	[self searchHitNumber:searchNum];
	[historyTableView reloadData];
	[search resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if ([searchText length] == 0) {
		[self reloadHistoryData];
		[historyTableView reloadData];
		return;
	}
	[self searchHitNumber:searchText];
	[historyTableView reloadData];
}

#pragma mark Implement self methods

//read lottery history from db
-(void)initHistoryData
{
	sqlite3 *database;
	sqlite3_stmt *statement;
	NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"lottery" ofType:@"db"];
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		char *sql = "SELECT * FROM lotteries";
		self.lotteryHistoryData = [NSMutableArray array];
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
			//step each row
			while (sqlite3_step(statement) == SQLITE_ROW) {
				int itemNo = (int)sqlite3_column_int(statement, 0);
				char *dateResult = (char *)sqlite3_column_text(statement, 1);
				char *red1 = (char *)sqlite3_column_text(statement, 2);
				char *red2 = (char *)sqlite3_column_text(statement, 3);
				char *red3 = (char *)sqlite3_column_text(statement, 4);
				char *red4 = (char *)sqlite3_column_text(statement, 5);
				char *red5 = (char *)sqlite3_column_text(statement, 6);
				char *red6 = (char *)sqlite3_column_text(statement, 7);
				char *blue = (char *)sqlite3_column_text(statement, 8);
				
				Lottery *lottery = [[Lottery alloc] init];
				lottery.ItemNO = [NSString stringWithFormat:@"%d", itemNo];
				//format date
				NSDateFormatter *df = [[NSDateFormatter alloc] init];
				[df setDateFormat:@"yy.MM.dd"];
				[df setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"] autorelease]];
				NSString *pdate = [NSString stringWithUTF8String:dateResult];
				//pdate = [pdate stringByReplacingOccurrencesOfString:@"." withString:@"/"];

				NSDate *convertDate = [df dateFromString:pdate];
				[df setDateFormat:@"YYYY年MM月dd日"];
				lottery.date = [df stringFromDate:convertDate];
				[df release];
	
				//format hitnumber
				NSString *num = [NSString stringWithFormat:@"%s%s%s%s%s%s%s", red1,red2,red3,red4,red5,red6,blue];
				lottery.hitNumber = num;
				[self.lotteryHistoryData addObject:lottery];
				[lottery release];
				
			}
			//NSArray *loHisData = [NSArray arrayWithArray:lotteryHistoryData];
			allLotteryHistoryData = [[NSArray alloc] initWithArray:lotteryHistoryData];
			//allLotteryHistoryData = [[NSArray arrayWithArray:lotteryHistoryData] retain];
			//[allLotteryHistoryData retain];
			
			NSLog(@"history data:%d", [lotteryHistoryData count]);
			NSLog(@"all history data:%d", [allLotteryHistoryData count]);
		}
		//[allLotteryHistoryData release];
	}
	
}

-(void)reloadHistoryData
{
	
	[lotteryHistoryData removeAllObjects];
	[lotteryHistoryData addObjectsFromArray:allLotteryHistoryData];
}

-(void)searchHitNumber:(NSString *)num
{
	//store the key need to remove
	[self reloadHistoryData];
	Lottery *tmpLottery;
	NSLog(@"lott count:%d", [lotteryHistoryData count]);
	int count = 0;
	NSMutableIndexSet *removeIdx = [[NSMutableIndexSet alloc] init];
	NSUserDefaults *searchPrefs = [NSUserDefaults standardUserDefaults];
	NSString *haystack = @"";
	for (tmpLottery in lotteryHistoryData) {
		if ([searchPrefs boolForKey:kItemNo]) {
			haystack = tmpLottery.ItemNO;
		} else {
			haystack = tmpLottery.hitNumber; 
		}
		if ([haystack rangeOfString:num].location == NSNotFound ) {//NSLog(@"%d", i);
			[removeIdx addIndex:count];
		} 
		count++;
	}
	NSLog(@"remove idx:%@", removeIdx);
	[lotteryHistoryData removeObjectsAtIndexes:removeIdx];
	[removeIdx release];
	//[tmpLottery release];
}

-(void)createSearchBar
{
	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
	NSUserDefaults *searchPrefs = [NSUserDefaults standardUserDefaults];
	if ([searchPrefs boolForKey:kItemNo]) {
		searchBar.placeholder = @"按 期号 搜索";
	} else if ([searchPrefs boolForKey:kDate]) {
		searchBar.placeholder = @"按 日期(2009/08/08) 搜索";
	} else if ([searchPrefs boolForKey:kNumber]) {
		searchBar.placeholder = @"按 双色球号码 搜索";
	}
	searchBar.showsCancelButton = NO;
	searchBar.delegate = self;
	UITextField *searchField = [[searchBar subviews] lastObject];
	[searchField setReturnKeyType:UIReturnKeyDone];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithTitle:@"选项"
											   style:UIBarButtonItemStylePlain
											   target:self
											   action:@selector(setSearchOption)]
											  autorelease];
	
	self.navigationItem.titleView = searchBar;
	self.search = searchBar;
	[searchBar release];
}

-(void)setSearchOption
{
	if (searchSettingsController == nil) {
		searchSettingsController = [[SearchSettingViewController alloc] initWithStyle:UITableViewStyleGrouped];
	}
	[self.navigationController pushViewController:searchSettingsController animated:YES];
}
@end

