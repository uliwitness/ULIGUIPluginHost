//
//  ULIGUIPlugin.h
//  ULIGUIPlugin
//
//  Created by Uli Kusterer on 05/03/2017.
//  Copyright © 2017 Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ULIGUIPluginProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface ULIGUIPlugin : NSObject <ULIGUIPluginProtocol>
@end
