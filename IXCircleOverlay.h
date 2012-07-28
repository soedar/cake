//
//  IXCircleOverlay.h
//  proj1-cake
//
//  Created by soedar on 27/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "IXDrawingPrimitives.h"

@interface IXCircleOverlay : CCNode {
    int parts_;
    float radius_;
    float startAngle_;
    float endAngle_;
    
    float alphaAngle;
}
@property (nonatomic, assign) int parts;
@property (readonly, nonatomic, assign) float radius;
@property (nonatomic, assign) float startAngle;
@property (nonatomic, assign) float endAngle;

+ (id) newOverlay;
- (int) getSelectedParts;

@end
