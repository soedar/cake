//
//  IXCircle.h
//  proj1-cake
//
//  Created by Soedar on 5/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define UNDEF_RAD 5

@interface IXCircle : CCNode {
    float radius_;
    int parts_;
    float alpha_rad_;
    CGPoint center_;
    
    float activeRad_;
    BOOL isCurved_;
}

@property (readonly, nonatomic, assign) int parts;
@property (readonly, nonatomic, assign) CGPoint center;

+ (id) circleWithParts:(int)parts center:(CGPoint)center;
- (id) initWithParts:(int)parts center:(CGPoint) center;
- (CGPoint) getNodePointFromTouch:(UITouch*)touch;
- (BOOL) shouldTrack:(UITouch*)touch;
- (void) drawPointFromTouch:(UITouch*)touch ribbon:(CCRibbon*)ribbon;


@end
