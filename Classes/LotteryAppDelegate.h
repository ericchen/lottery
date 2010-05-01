//
//  LotteryAppDelegate.h
//  Lottery
//
//  Created by eric on 09-12-2.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class LOLotteryHistoryController;

@interface LotteryAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	//LOLotteryHistoryController *lotteryHistoryController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;

-(void)createView;
@end

