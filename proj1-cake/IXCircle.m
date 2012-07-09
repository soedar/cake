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
        alpha_rad_ = CC_DEGREES_TO_RADIANS(360.0/parts_);
        self.position = center;
        
        activeRad_ = UNDEF_RAD;
    }
    return self;
}

- (void) draw
{
    glLineWidth(1);
    glColor4ub(255, 0, 0, 255);
    ccDrawCircle(ccp(0,0), radius_, 0, 60, NO);
    
    for (int i=0;i<parts_;i++) {
        float rad = alpha_rad_ * i;
        float x = radius_ * sinf(rad);
        float y = radius_ * cosf(rad);
        
        ccDrawLine(ccp(0,0), ccp(x,y));
    }
}

- (BOOL) shouldTrack:(UITouch*)touch
{
    CGPoint point = [self convertTouchToNodeSpace:touch];
    
    float threshold = radius_ * 0.10;
    float radius = sqrtf(point.x*point.x + point.y*point.y);
    activeRad_ = UNDEF_RAD;
    
    return (radius <= threshold);
}

- (void) drawPointFromTouch:(UITouch*)touch ribbon:(CCRibbon*)ribbon
{
    CGPoint point = [self convertTouchToNodeSpace:touch];
    float radius = sqrtf(point.x*point.x + point.y*point.y);
   
    if (activeRad_ == UNDEF_RAD) {
        float threshold = radius_*0.25;
        
        if (radius >= threshold) {
            float angle = atan2f(point.x, point.y);
            activeRad_ = round(angle/alpha_rad_) * alpha_rad_;
        }
    }
    else {
        BOOL activated = (radius >= radius_*0.75);
        if (activated) {
            float rad = atan2f(point.x, point.y);
            point.x = radius_ * sinf(rad);
            point.y = radius_ * cosf(rad);
        }
        
        else {
            point.x = radius * sinf(activeRad_);
            point.y = radius * cosf(activeRad_);
        } 
        
        point = [self convertToWorldSpace:point];
        [ribbon addPointAt:point width:5];
    }
}

@end
