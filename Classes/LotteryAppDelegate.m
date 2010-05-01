//
//  LotteryAppDelegate.m
//  Lottery
//
//  Created by eric on 09-12-2.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "LotteryAppDelegate.h"
#import "LOLotteryHistoryController.h"
#import "LotteryNumStatisticController.h"

@implementation LotteryAppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	[self createView];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	//[lotteryHistoryController release];
	[tabBarController release];
    [window release];
    [super dealloc];
}

-(void)createView
{	
	tabBarController = [[UITabBarController alloc] init];
	//lottery history
	LOLotteryHistoryController *lotteryController = [[LOLotteryHistoryController alloc] init];
	[lotteryController.tabBarItem setTitle:@"History"];
	[lotteryController.tabBarItem setImage:[UIImage imageNamed:@"History.png"]];
	UINavigationController *histNav = [[UINavigationController alloc] initWithRootViewController:lotteryController];
	[lotteryController release];
	
	//lottery number statistic
	LotteryNumStatisticController *numStatisticController = [[LotteryNumStatisticController alloc] init];
	[numStatisticController.tabBarItem setTitle:@"数字"];
	[numStatisticController.tabBarItem setImage:[UIImage imageNamed:@"Number.png"]];
	
	//latest lottery number
	
	
	[tabBarController setViewControllers:[NSArray arrayWithObjects:histNav, numStatisticController, nil]];	
	[histNav release];
	[numStatisticController release];
	[window addSubview:tabBarController.view];
}
@end
