//
//  LotteryNumStatisticController.h
//  Lottery
//
//  Created by eric on 09-12-11.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LotteryNumStatisticController : UITableViewController {
	UITableView *numStatisticTableView;
}
@property (nonatomic, retain) UITableView *numStatisticTableView;

-(void)initTableView;
-(void)createHeader;
@end
