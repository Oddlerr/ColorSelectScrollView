//
//  HAScrollView.m
//  HAScrollExample
//
//  Created by a.holodok on 21.05.14.
//  Copyright (c) 2014 a.holodok. All rights reserved.
//

#import "HAScrollView.h"
#import "HAColorCircle.h"


@interface HAScrollView ()
{
    float _circleDistance;
    float _circleLargeDiametr;
    float _circleSmallDiametr;
    int _selectedColorNumber;
}

@property (nonatomic, strong) NSArray *circleViews;

@end

const float IMAGE_WIDTH = 150;



@implementation HAScrollView


#pragma mark - INIT methods
-(void)awakeFromNib
{
    _circleDistance = 66;
    _circleSmallDiametr = 36;
    _circleLargeDiametr = 64;
    [super setDelegate:self];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    [self setDecelerationRate:UIScrollViewDecelerationRateFast];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnView:)];
    [gestureRecognizer setNumberOfTapsRequired:1];
    [gestureRecognizer setNumberOfTouchesRequired:1];
    [self addGestureRecognizer:gestureRecognizer];
    [self setClipsToBounds:YES];
}


//сдвигает цвета, выделяя тапнутый пользователем
// shifts colors, highlighting selected color (on user tap)
-(void)tappedOnView:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint tappedPoint = [gestureRecognizer locationInView:self];
    int numberOfCircle = (tappedPoint.x - self.frame.size.width/2 + 0.5*_circleDistance)/_circleDistance+1; // find coordiate of tap in scroll content and find color number
    [self setColorNumber:numberOfCircle animated:YES];
}

// method for setting colors to select
-(void)setColors:(NSArray *)colors
{
    _colors = colors;
    
    for (UIView * view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    // creates colored circle views and add them into array
    NSMutableArray * circleViews = [NSMutableArray arrayWithCapacity:colors.count];
    for (int i = 0; i < colors.count; i++)
    {
        UIColor *currentColor = colors[i];
        HAColorCircle * circle = [[HAColorCircle alloc] init];
        [circle setCircleColor:currentColor];
        [circleViews addObject:circle];
    }
    self.circleViews = circleViews; // set frames for circle views
}

// set frames for circle views
-(void)setCircleViews:(NSArray *)circleViews
{
    _circleViews = circleViews;
    for (int i = 0; i < circleViews.count; i++)
    {
        UIView * currentView = circleViews[i];
        if (i == 0)
        {
            [currentView setFrame:CGRectMake(0, 0, _circleLargeDiametr, _circleLargeDiametr)];
        }
        else
        {
            [currentView setFrame:CGRectMake(0, 0, _circleSmallDiametr, _circleSmallDiametr)];
        }
        [self addSubview:currentView];
    }
    _selectedColorNumber = 1;
}


-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    for (int i = 0; i < _circleViews.count; i++)
    {
        [_circleViews[i] setCenter:CGPointMake(frame.size.width/2 + i*_circleDistance, frame.size.height/2)];
    }
    [self setContentSize:CGSizeMake(self.frame.size.width + (_circleViews.count-1)*_circleDistance, self.frame.size.height)];
}


-(void)setColorNumber:(int)colorNumber animated:(BOOL)animated
{
    int currentColor = colorNumber;
    if (currentColor < 1)
    {
        currentColor = 1;
    }
    if (currentColor >_circleViews.count)
    {
        currentColor = _circleViews.count;
    }
    [self setContentOffset:CGPointMake((currentColor - 1)*_circleDistance, 0) animated:animated];
    _selectedColorNumber = colorNumber;
}


// чтобы нельзя было выставить делегата scrollView
// prohibits setting scrollView delegate
-(void)setDelegate:(id<UIScrollViewDelegate>)delegate
{
    [super setDelegate:self];
}



// center on circle, most of which is in the middle part of view
-(void)centerOnCircle
{
    CGPoint point = self.contentOffset;
    for (int i = 0; i < _circleViews.count; i++)
    {
        UIView * currentView = _circleViews[i];
        float dist = ABS(point.x + self.frame.size.width/2 - currentView.center.x);
        if (dist <_circleDistance/2)
        {
            [self setContentOffset:CGPointMake((i)*_circleDistance, 0) animated:YES];
            _selectedColorNumber = i + 1;
            if (self.haDelegate && [self.haDelegate respondsToSelector:@selector(didSelectColor:)])
            {
                [self.haDelegate didSelectColor:self];        //this will call the method implemented in your other class
            }
            break;
        }
    }
}





#pragma mark - delegates
// срабатывает постоянно при скролле
// method is called at every moment of scrolling
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = self.contentOffset;
    for (int i = 0; i < _circleViews.count; i++)
    {
        UIView *currentView = _circleViews[i];
        float dist = ABS(point.x + self.frame.size.width/2 - currentView.center.x);
        CGPoint currentViewCentre = currentView.center;
        if (dist > _circleDistance)
        {
            [currentView setFrame:CGRectMake(currentView.frame.origin.x, currentView.frame.origin.y, _circleSmallDiametr, _circleSmallDiametr)];
        }
        else
        {
            float currentCircleDiametr = _circleSmallDiametr + ((_circleLargeDiametr-_circleSmallDiametr) * (1-dist/_circleDistance));
            [currentView setFrame:CGRectMake(currentView.frame.origin.x, currentView.frame.origin.y, currentCircleDiametr, currentCircleDiametr)];
        }
        [currentView setCenter:currentViewCentre];
    }
}

//метод срабатывает как только скролл остановился после "разгона" его пользователем
// method on stopping after the scroll view does continue to scroll on touch up
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self centerOnCircle];
}

// метод срабатывает, когда пользователь остановил скролл вручную
// method for stopping scrolling manually
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!self.decelerating)
    {
        [self centerOnCircle];
    }
}

@end