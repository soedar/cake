//
//  IXCircle.m
//  proj1-cake
//
//  Created by Soedar on 5/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "IXCircle.h"


@implementation IXCircle

@synthesize overlay = overlay_;
@synthesize fraction = fraction_;
@synthesize delegate = delegate_;

+ (id) circleWithCenter:(CGPoint)center
                overlay:(IXCircleOverlay*)overlay
{
    return [[[self alloc] initWithCenter:(CGPoint)center
                                overlay:overlay] autorelease];
}

- (id) initWithCenter:(CGPoint)center
              overlay:(IXCircleOverlay *)overlay
{
    if (self = [super init]) {
        overlay_ = [overlay retain];
        sprite = [CCSprite spriteWithFile:@"pizza.png"];
        
        self.position = center;
        
        [self updateFraction:[IXFraction randomFraction]];
        [self addChild:sprite];
        [self addChild:overlay_];
    }
    return self;
}

- (void) dealloc
{
    [overlay_ release]; overlay_ = nil;
    [fraction_ release]; fraction_ = nil;
    
    [super dealloc];
}

- (void) updateFraction:(IXFraction*)fraction
{
    if (fraction_ != nil) {
        [fraction_ release];
    }
    fraction_ = [fraction retain];
    [overlay_ setParts:fraction_.denominator];
}

- (void) startTrack:(UITouch*)touch
{
    CGPoint point = [self convertTouchToNodeSpace:touch];
    float angle = POS_ANGLE(atan2f(point.x, point.y));
    
    [overlay_ setStartAngle:angle];
}

- (void) trackTouch:(UITouch*)touch
{
    CGPoint point = [self convertTouchToNodeSpace:touch];
    float angle = POS_ANGLE(atan2f(point.x, point.y));
    
    [overlay_ setEndAngle:angle];
}

- (void) endTrack:(UITouch*)touch
{
    int parts = [overlay_ getSelectedParts];
    
    if (parts == fraction_.numerator) {
        [self updateFraction:[IXFraction randomFraction]];
        if (delegate_ != nil) {
            [delegate_ selectedAreaIsCorrect:YES];
        }
    } else {
        if (delegate_ != nil) {
            [delegate_ selectedAreaIsCorrect:NO];
        }
    }
    
    [overlay_ setStartAngle:0];
    [overlay_ setEndAngle:0];
}
@end
