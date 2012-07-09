//
//  HelloWorldLayer.m
//  proj1-cake
//
//  Created by Soedar on 5/7/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        self.isTouchEnabled = YES;
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        circle = [IXCircle circleWithParts:4 center:ccp(size.width/2, size.height/2)];
		[self addChild: circle];
	}
	return self;
}

- (void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    shouldTrack = [circle shouldTrack:touch];
    
    if (shouldTrack) {
        ccColor4B color = ccc4(0, 255, 0, 150);
        ribbon = [CCRibbon ribbonWithWidth:10 image:@"Icon.png" length:10.0 color:color fade:0.6f];
        [self addChild:ribbon];
        
        CGPoint origin = [circle convertToWorldSpace:CGPointMake(0, 0)];
        [ribbon addPointAt:origin width:5];
    }
    
    return shouldTrack;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (shouldTrack) {
        [circle drawPointFromTouch:touch ribbon:ribbon];
    }
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (shouldTrack) {
        [self removeChild:ribbon cleanup:YES];
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
