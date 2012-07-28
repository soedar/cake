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
       
        fractionLabel = [[CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:30] retain];
        [fractionLabel setColor:ccc3(0, 255, 0)];
        [fractionLabel setPosition:ccp(60, 300)];
        [self addChild:fractionLabel];
        
        IXCircleOverlay *overlay = [IXCircleOverlay newOverlay];
        circle = [[IXCircle circleWithCenter:ccp(size.width/2, size.height/2) overlay:overlay] retain];
        [self addChild:circle];
        
        [circle setDelegate:self];
        
        [fractionLabel setString:circle.fraction.string];
	}
	return self;
}

- (void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    [circle startTrack:touch];
    return YES;
}

- (void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    [circle trackTouch:touch];
}

- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [circle endTrack:touch];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[fractionLabel release]; fractionLabel = nil;
    [circle release]; circle = nil;
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

- (void) selectedAreaIsCorrect:(BOOL)correct
{
    if (correct) {
        [fractionLabel setString:circle.fraction.string];
    }
}
@end
