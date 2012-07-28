//
//  IXCircle.h
//  proj1-cake
//
//  Created by Soedar on 5/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "IXDrawingPrimitives.h"
#import "IXCircleOverlay.h"
#import "IXFraction.h"
#import "IXCircleProtocol.h"

#define POS_ANGLE(angle) ((angle < 0) ? angle + 2*M_PI : angle)

@interface IXCircle : CCNode {
    IXCircleOverlay *overlay_;
    CCSprite *sprite;
    IXFraction *fraction_;
    
    id<IXCircleProtocol> delegate_;
}

@property (readonly, nonatomic) IXCircleOverlay *overlay;
@property (readonly, nonatomic) IXFraction *fraction;
@property (nonatomic, retain) id<IXCircleProtocol> delegate;

+ (id) circleWithCenter:(CGPoint)center overlay:(IXCircleOverlay*)overlay;
- (id) initWithCenter:(CGPoint)center overlay:(IXCircleOverlay*)overlay;

- (void) startTrack:(UITouch*)touch;
- (void) trackTouch:(UITouch*)touch;
- (void) endTrack:(UITouch*)touch;

@end
