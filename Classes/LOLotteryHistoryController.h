//
//  LOLotteryHistoryController.h
//  Lottery
//
//  Created by eric on 09-12-2.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchSettingViewController;


@interface LOLotteryHistoryController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
	UITableView *historyTableView;
	UISearchBar *search;
	NSArray *allLotteryHistoryData;
	NSMutableArray *lotteryHistoryData;
	SearchSettingViewController *searchSettingsController;

}

@property (nonatomic, retain) IBOutlet UITableView *historyTableView;
@property (nonatomic, retain) UISearchBar *search;
//@property (nonatomic, retain) SearchSettingViewController *searchSettingsController;
//@property (nonatomic, retain) NSArray *allLotteryHistoryData;
@property (nonatomic, retain) NSMutableArray *lotteryHistoryData;


-(UITableViewCell *)createCellContentView:(NSString *)cellIdentifier;
-(void)initHistoryData;
-(void)reloadHistoryData;
-(void)searchHitNumber:(NSString *)num;
-(void)createSearchBar;
-(void)setSearchOption;
@end
