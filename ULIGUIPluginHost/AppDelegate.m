//
//  AppDelegate.m
//  ULIGUIPluginHost
//
//  Created by Uli Kusterer on 05/03/2017.
//  Copyright © 2017 Uli Kusterer. All rights reserved.
//

#import "AppDelegate.h"
#import "ULIGUIPluginProtocol.h"
#import "ULIGUIPlugin.h"


@interface AppDelegate () <NSXPCListenerDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (strong) NSTask * pluginTask;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Start a service that our plugins can connect to to make requests:
	[NSThread detachNewThreadSelector: @selector(serviceListenerThread) toTarget: self withObject: nil];
	
	// Quick hack to ensure we don't have a race condition:
	//[self performSelector: @selector(readyToLaunchPlugins) withObject: nil afterDelay: 10.0];
}


-(void) readyToLaunchPlugins
{
	// The code below launches a plugin host that could load one plugin:
	NSString * thePath = [NSBundle.mainBundle.bundlePath stringByAppendingString: @"/Contents/MacOS/ULIGUIPlugin.app/Contents/MacOS/ULIGUIPlugin"];
	self.pluginTask = [NSTask launchedTaskWithLaunchPath: thePath arguments: @[ NSBundle.mainBundle.bundleIdentifier ]];
}


- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection {
    // This method is where the NSXPCListener configures, accepts, and resumes a new incoming NSXPCConnection.
    
    // Configure the connection.
    // First, set the interface that the exported object implements.
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(ULIGUIPluginProtocol)];
    
    // Next, set the object that the connection exports. All messages sent on the connection to this service will be sent to the exported object to handle. The connection retains the exported object.
    ULIGUIPlugin *exportedObject = [ULIGUIPlugin new];
    newConnection.exportedObject = exportedObject;
    
    // Resuming the connection allows the system to deliver more incoming messages.
    [newConnection resume];
    
    // Returning YES from this method tells the system that you have accepted this connection. If you want to reject the connection for some reason, call -invalidate on the connection and return NO.
    return YES;
}


-(void) serviceListenerThread
{
    // Set up the one NSXPCListener for this service. It will handle all incoming connections.
    NSXPCListener *listener = [NSXPCListener serviceListener];
    listener.delegate = self;
    
    // Resuming the serviceListener starts this service. This method does not return.
    [listener resume];
}

@end
