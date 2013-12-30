//
//  BKVAppDelegate.h
//  BitStamp TickerWatcher
//
//  Created by Bryan Vines on 12/29/13.
//  Copyright (c) 2013 Bryan Vines. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BKVAppDelegate : NSObject <NSApplicationDelegate>

// BitStamp Value Properties
@property NSNumber * highValue;
@property NSNumber * lowValue;
@property NSNumber * lastValue;
@property NSNumber * bidValue;
@property NSNumber * askValue;
@property (copy) NSString * volumeValue;

@property (assign) IBOutlet NSWindow *window;

@end
