//
//  IXFraction.h
//  proj1-cake
//
//  Created by Soedar on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IXFraction : NSObject {
    int numerator_;
    int denominator_;
    NSString *string_;
}

@property (readonly, nonatomic, retain) NSString *string;
@property (readonly, nonatomic) int numerator;
@property (readonly, nonatomic) int denominator;

+ (IXFraction*) randomFraction;
- (id) initWithNumerator:(int)numerator denominator:(int)denominator;

@end
