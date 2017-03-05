//
//  main.m
//  ULIGUIPlugin
//
//  Created by Uli Kusterer on 05/03/2017.
//  Copyright © 2017 Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ULIGUIPlugin.h"

int main(int argc, const char *argv[])
{
	NSLog(@"Plugin service started!");
	
	// To use the service from an application or other process,
	//	use NSXPCConnection to establish a connection to the service by doing something like this:
	NSXPCConnection * connectionToService = [[NSXPCConnection alloc] initWithServiceName: [NSString stringWithUTF8String: argv[1]]];
	connectionToService.remoteObjectInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ULIGUIPluginProtocol)];
	[connectionToService resume];

	// Once you have a connection to the service, you can use it like this:
	id<ULIGUIPluginProtocol> proxy = [connectionToService remoteObjectProxy];
	[proxy initializePluginWithReply: ^() {
		// And, when you are finished with the service, clean up the connection like this:
		[connectionToService invalidate];
	}];
	
	sleep(10);
	
	[proxy terminatePlugin];
	
	sleep(60);

	NSLog(@"Plugin service terminating!");
	
    return 0;
}
