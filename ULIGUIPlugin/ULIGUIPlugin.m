//
//  ULIGUIPlugin.m
//  ULIGUIPlugin
//
//  Created by Uli Kusterer on 05/03/2017.
//  Copyright © 2017 Uli Kusterer. All rights reserved.
//

#import "ULIGUIPlugin.h"


@interface ULIGUIPlugin ()

@property void (^terminationReply)();

@end


@implementation ULIGUIPlugin

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
-(void)	initializePluginWithReply: (void (^)())inTerminationReply
{
	self.terminationReply = [inTerminationReply copy];
	NSLog(@"Plugin asked us to initialize.");
}


-(void) terminatePlugin
{
	NSLog(@"Plugin terminate.");
	self.terminationReply();
}

@end
