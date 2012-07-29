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
       
        totalLingerCount = 10;
        currentLingerCount = 0;
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
    [self autoHighlightFromPiece:0 to:fraction_.numerator];
}

- (void) startTrack:(UITouch*)touch
{
    // If user has started highlighting the circle, we
    // stop all automated highlighting
    [self unscheduleAllSelectors];
    
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

- (void) autoHighlightFromPiece:(int)startPiece to:(int)endPiece
{
    if (endPiece > fraction_.denominator)
        return;
    
    float startAngle = startPiece * overlay_.alphaAngle;
    float endAngle = endPiece * overlay_.alphaAngle;
    [self autoHighlightFromAngle:startAngle to:endAngle];
}

- (void) autoHighlightFromAngle:(float)startAngle to:(float)endAngle
{
    [overlay_ setStartAngle:startAngle];
    autoEndAngle = endAngle;
    [self schedule:@selector(ticks:) interval:0.05];
}
 
- (void) ticks:(ccTime)dt
{
    if (overlay_.endAngle < autoEndAngle) {
        [overlay_ setEndAngle:overlay_.endAngle+0.05];
    } else {
        if (currentLingerCount >= totalLingerCount) {
            [self unschedule:@selector(ticks:)];
            [delegate_ autoHighlightCompleted];
            currentLingerCount = 0;
        }
        else {
            currentLingerCount++;
        }
    }
}

@end
