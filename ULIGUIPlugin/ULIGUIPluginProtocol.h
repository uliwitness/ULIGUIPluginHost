//
//  ULIGUIPluginProtocol.h
//  ULIGUIPlugin
//
//  Created by Uli Kusterer on 05/03/2017.
//  Copyright © 2017 Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>

// The protocol that this service will vend as its API. This header file will also need to be visible to the process hosting the service.
@protocol ULIGUIPluginProtocol

// Plugin calls back this block when host is tearing down the plugin.
//	As long as it holds on to this, the plugin process doesn't get switched
//	to low priority.
-(void)	initializePluginWithReply: (void (^)())teardownReply;

// Plugin calls teardownReply block here and is then shut down.
-(void) terminatePlugin;
    
@end
