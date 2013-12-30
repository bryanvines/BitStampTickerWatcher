//
//  BKVAppDelegate.m
//  BitStamp TickerWatcher
//
//  Created by Bryan Vines on 12/29/13.
//  Copyright (c) 2013 Bryan Vines. All rights reserved.
//

#import "BKVAppDelegate.h"
#import "JSONKit.h"

@implementation BKVAppDelegate

#pragma mark - Application Delegate methods
- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {
    //--------------------------------------------------------------------------------------------------------
    //
    //  applicationDidFinishLaunching:
    //
    //  synopsis:       [self applicationDidFinishLaunching:aNotification];
    //                      void retval - No return value.
    //
    //  description:    applicationDidFinishLaunching: is designed to perform the application's initialization
    //                  tasks. In this implementation, it calls the createTimer method to set up a timer which
    //                  updates the application's properties every two seconds.
    //
    //  errors:         none.
    //
    //  returns:        none.
    //
    //--------------------------------------------------------------------------------------------------------

    // And one timer to rule them all.
    [self createTimer];
}
- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    //--------------------------------------------------------------------------------------------------------
    //
    //  applicationShouldTerminateAfterLastWindowClosed:
    //
    //  synopsis:       retval = [self applicationShouldTerminateAfterLastWindowClosed:sender];
    //                      BOOL retval             - A Boolean value.
    //                      NSApplication * sender  - The sender of the event.
    //
    //  description:    applicationShouldTerminateAfterLastWindowClosed: is designed to inform the application
    //                  whether it should terminate when the application's last window is closed. Since this
    //                  is a single-window utility application, we return YES to enable this feature.
    //
    //  errors:         none.
    //
    //  returns:        YES to allow application to terminate when its last window closes, NO otherwise.
    //
    //--------------------------------------------------------------------------------------------------------
    
    return YES;
}

#pragma mark - Utility Methods
- (void) createTimer {
    //--------------------------------------------------------------------------------------------------------
    //
    //  createTimer
    //
    //  synopsis:       [self createTimer];
    //                      void retval - No return value.
    //
    //  description:    createTimer is designed to create a repeating event, firing once every 2 seconds,
    //                  which calls our updateProperties method. In this way, the application monitors the
    //                  current BitStamp values.
    //
    //  errors:         none.
    //
    //  returns:        none.
    //
    //--------------------------------------------------------------------------------------------------------
    
    // Create a timer which calls our updateProperties method once every two seconds.
    NSTimer * myTimer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                         target:self
                                                       selector:@selector(updateProperties)
                                                       userInfo:nil
                                                        repeats:YES];
    
    // Start the timer.
    [myTimer fire];
}
- (void) updateProperties {
    //--------------------------------------------------------------------------------------------------------
    //
    //  updateProperties
    //
    //  synopsis:       [self updateProperties];
    //                      void retval - No return value.
    //
    //  description:    updateProperties is designed to get the current BitStamp Ticker values and set our
    //                  application's properties accordingly.
    //
    //  errors:         none.
    //
    //  returns:        none.
    //
    //--------------------------------------------------------------------------------------------------------
    
    // Get the current BitStamp values in a dictionary.
    NSDictionary * bsValues = [self dictionaryWithBitStampValues];
    
    // If we have a non-nil dictionary, we can proceed.
    if (bsValues) {
        
        // Set properties based on dictionary key values.
        
        // HIGH
        // If the dictionary contains a high value, set our property with it.
        // Otherwise set our property to nil.
        if ([bsValues objectForKey:@"high"]) {
            self.highValue = [bsValues objectForKey:@"high"];
        } else {
            self.highValue = nil;
        }
        
        // LOW
        // If the dictionary contains a low value, set our property with it.
        // Otherwise set our property to nil.
        if ([bsValues objectForKey:@"low"]) {
            self.lowValue = [bsValues objectForKey:@"low"];
        } else {
            self.lowValue = nil;
        }
        
        // LAST
        // If the dictionary contains a last value, set our property with it.
        // Otherwise set our property to nil.
        if ([bsValues objectForKey:@"last"]) {
            self.lastValue = [bsValues objectForKey:@"last"];
        } else {
            self.lastValue = nil;
        }
        
        // VOLUME
        // If the dictionary contains a volume value, set our property with it.
        // Otherwise set our property to nil.
        if ([bsValues objectForKey:@"volume"]) {
            self.volumeValue = [bsValues objectForKey:@"volume"];
        } else {
            self.volumeValue = nil;
        }
        
        // BID
        // If the dictionary contains a bid value, set our property with it.
        // Otherwise set our property to nil.
        if ([bsValues objectForKey:@"bid"]) {
            self.bidValue = [bsValues objectForKey:@"bid"];
        } else {
            self.bidValue = nil;
        }
        
        // ASK
        // If the dictionary contains a ask value, set our property with it.
        // Otherwise set our property to nil.
        if ([bsValues objectForKey:@"ask"]) {
            self.askValue = [bsValues objectForKey:@"ask"];
        } else {
            self.askValue = nil;
        }
    }
}
- (NSDictionary *) dictionaryWithBitStampValues {
    //--------------------------------------------------------------------------------------------------------
    //
    //  dictionaryWithBitStampValues
    //
    //  synopsis:       retval = [self dictionaryWithBitStampValues];
    //                      NSDictionary * retval - A dictionary containing current BitStamp Ticker values.
    //
    //  description:    dictionaryWithBitStampValues is designed to get the current BitStamp Ticker values
    //                  and store them in an NSDictionary.
    //
    //  errors:         none.
    //
    //  returns:        NSDictionary
    //
    //--------------------------------------------------------------------------------------------------------
    
    // The URL of the BitStamp Ticker
    NSURL * bitStampTickerURL = [NSURL URLWithString:@"https://www.bitstamp.net/api/ticker/"];
    
    // Get the data from the BitStamp Ticker
    NSData * JSONdata = [NSData dataWithContentsOfURL:bitStampTickerURL];
    
    // Use a JSONDecoder to get this into a NSDictionary.
    NSDictionary * jsonDict = [[[JSONDecoder alloc]init] objectWithData:JSONdata];
    
    // Return the dictionary.
    return jsonDict;
}

@end
