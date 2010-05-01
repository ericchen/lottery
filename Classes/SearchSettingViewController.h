//
//  SearchSetting.h
//  Lottery
//
//  Created by eric on 09-12-6.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchSettingViewController : UITableViewController <UITabBarDelegate, UITableViewDataSource>{
	NSArray *settingNames;
	NSArray *settingKeys;
	//UITableView *tableView;
}
@property (nonatomic, retain) NSArray *settingNames;
@property (nonatomic, retain) NSArray *settingKeys;

@end
