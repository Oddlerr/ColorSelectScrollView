//
//  HAColorCircle.m
//  HAScrollExample
//
//  Created by a.holodok on 27.05.14.
//  Copyright (c) 2014 a.holodok. All rights reserved.
//

#import "HAColorCircle.h"

@implementation HAColorCircle

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.circleColor = [UIColor whiteColor];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect))];
    [self.circleColor setFill];
    [ovalPath fill];
}

@end
