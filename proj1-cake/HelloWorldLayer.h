//
//  HelloWorldLayer.h
//  proj1-cake
//
//  Created by Soedar on 5/7/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "IXCircle.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCRibbon *ribbon;
    IXCircle *circle;
    BOOL shouldTrack;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
