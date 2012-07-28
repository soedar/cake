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
#import "IXFraction.h"
#import "IXCircleProtocol.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer<IXCircleProtocol>
{
    CCRibbon *ribbon;
    IXCircle *circle;
    BOOL shouldTrack;
    
    CCLabelTTF *fractionLabel;
    int targetPieces;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
