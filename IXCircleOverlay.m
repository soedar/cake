//
//  IXCircleOverlay.m
//  proj1-cake
//
//  Created by soedar on 27/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "IXCircleOverlay.h"


@implementation IXCircleOverlay

@synthesize parts = parts_;
@synthesize radius = radius_;
@synthesize startAngle = startAngle_;
@synthesize endAngle = endAngle_;
@synthesize alphaAngle = alphaAngle_;

+ (id) newOverlay
{
    return [[[self alloc] init] autorelease];
}

- (id) init
{
    if (self = [super init]) {
        radius_ = 150;
        parts_ = 0;
        alphaAngle_ = 0;
        
        startAngle_ = 0;
        endAngle_ = 0;
    }
    return self;
}

- (void) draw
{
    [super draw];
    glColor4ub(0, 0, 255, 100);
    ixDrawHighlight(ccp(0,0), radius_, startAngle_, endAngle_);
    
    glLineWidth(3.0);
    glColor4ub(255, 255, 255, 255);
    ixDrawOverlay(ccp(0,0), radius_, parts_);
}


- (void) setParts:(int)parts
{
    parts_ = parts;
    alphaAngle_ = 2*M_PI / parts_;
}

- (void) setStartAngle:(float)startAngle
{
    int piece = startAngle / alphaAngle_;
    startAngle_ = piece * alphaAngle_;
}

- (void) setEndAngle:(float)endAngle
{
    endAngle_ = endAngle;
    if (endAngle < startAngle_) {
        endAngle_ = endAngle + 2*M_PI;
    }
}

- (int) getSelectedParts
{
    float delta = endAngle_ - startAngle_;
    return (int)ceilf(delta/alphaAngle_);
}
@end
