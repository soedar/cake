//
//  IXCircle.m
//  proj1-cake
//
//  Created by Soedar on 5/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "IXCircle.h"


@implementation IXCircle

@synthesize parts = parts_;
@synthesize center = center_;
@synthesize radius = radius_;

+ (id) circleWithParts:(int)parts center:(CGPoint)center
{
    return [[[self alloc] initWithParts:parts center:center] autorelease];
}

- (id) initWithParts:(int)parts center:(CGPoint)center
{
    if (self = [super init]) {
        radius_ = 150;
        parts_ = parts;
        center_ = center;
        alphaRad = 2*M_PI / parts_;
        self.position = center;
        
    }
    return self;
}

- (void) setParts:(int)parts
{
    parts_ = parts;
    alphaRad = 2*M_PI / parts_;
}

- (void) draw
{
    glLineWidth(1);
    glColor4ub(255, 0, 0, 255);
    ccDrawCircle(ccp(0,0), radius_, 0, 60, NO);
    
    for (int i=0;i<parts_;i++) {
        float rad = alphaRad * i;
        float x = radius_ * sinf(rad);
        float y = radius_ * cosf(rad);
        
        ccDrawLine(ccp(0,0), ccp(x,y));
    }
}

- (BOOL) shouldTrack:(UITouch*)touch
{
    CGPoint point = [self convertTouchToNodeSpace:touch];
    float radius = sqrtf(point.x*point.x + point.y*point.y);
    current_angle = POS_ANGLE(atan2f(point.x, point.y));
    
    startLine = -1;
    endLine = -1;
    return (radius <= radius_);
}

- (void) drawPointFromTouch:(UITouch*)touch ribbon:(CCRibbon*)ribbon
{
    CGPoint point = [self convertTouchToNodeSpace:touch];
    float angle = atan2f(point.x, point.y);
    
    if (POS_ANGLE(angle) < current_angle) {
        return;
    }
    
    current_angle = POS_ANGLE(angle);
    
    point.x = radius_ * sinf(angle);
    point.y = radius_ * cosf(angle);
   
    if (startLine < 0) {
        startLine = POS_ANGLE(angle) / alphaRad;
    }
    endLine = (POS_ANGLE(angle) / alphaRad) + 1;
    
    point = [self convertToWorldSpace:point];
    [ribbon addPointAt:point width:5];
}

- (int) getSelectedQuadrants
{
    return endLine - startLine;
}

@end
