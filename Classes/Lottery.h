//
//  Lottery.h
//  Lottery
//
//  Created by eric on 09-12-2.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Lottery : NSObject {
	NSString *ItemNO;
	NSString    *date;
	NSString  *hitNumber;
}

@property (nonatomic, retain) NSString *ItemNO;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *hitNumber;

//-(NSString *)setHitNumber:(NSString *)numStr;
@end
