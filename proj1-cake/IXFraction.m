//
//  IXFraction.m
//  proj1-cake
//
//  Created by Soedar on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IXFraction.h"

@implementation IXFraction

@synthesize string = string_;
@synthesize numerator = numerator_;
@synthesize denominator = denominator_;

+ (IXFraction*) randomFraction
{
    int denominator = (arc4random() % 9) + 2;
    int numerator = (arc4random() % (denominator)) + 1;
    return [[[self alloc] initWithNumerator:numerator denominator:denominator] autorelease];
}

- (id) initWithNumerator:(int)numerator denominator:(int)denominator
{
    if (self = [super init]) {
        numerator_ = numerator;
        denominator_ = denominator;
        
        string_ = [[NSString stringWithFormat:@"%i / %i", numerator_, denominator_] retain];
    }
    
    return self;
}

- (void) dealloc
{
    [string_ release]; string_ = nil;
    [super dealloc];
}

@end
