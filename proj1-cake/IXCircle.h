//
//  IXCircle.h
//  proj1-cake
//
//  Created by Soedar on 5/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define POS_ANGLE(angle) ((angle < 0) ? angle + 2*M_PI : angle)

@interface IXCircle : CCNode {
    int parts_;
    CGPoint center_;
    float radius_;
    
    float alphaRad;
    int startLine;
    int endLine;
    
    // temp variable, used to restrict only clockwise movement
    float current_angle;
}

@property (nonatomic, assign) int parts;
@property (readonly, nonatomic, assign) CGPoint center;
@property (readonly, nonatomic, assign) float radius;

+ (id) circleWithParts:(int)parts center:(CGPoint)center;
- (id) initWithParts:(int)parts center:(CGPoint) center;
- (BOOL) shouldTrack:(UITouch*)touch;
- (void) drawPointFromTouch:(UITouch*)touch ribbon:(CCRibbon*)ribbon;
- (int) getSelectedQuadrants;

@end
