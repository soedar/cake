//
//  IXDrawingPrimitives.h
//  proj1-cake
//
//  Created by soedar on 27/7/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define POS_ANGLE(angle) ((angle < 0) ? angle + 2*M_PI : angle)

void ixDrawOverlay(CGPoint center, float radius, int parts);
void ixDrawHighlight(CGPoint center, float radius, float startAngle, float endAngle);