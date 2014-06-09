//
//  ViewController.m
//  HAScrollExample
//
//  Created by a.holodok on 27.05.14.
//  Copyright (c) 2014 a.holodok. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // filling array with random colors
    self.arrayOfColors = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++)
    {
        UIColor * color = [self randomColor];
        [self.arrayOfColors addObject:color];
    }
    
    
     // HAScrollView set up
    [self.colorScrollView setColors:self.arrayOfColors];
    [self.colorScrollView setFrame:self.colorScrollView.frame];
    self.colorScrollView.haDelegate = self;
    self.exampleView.backgroundColor = [self.arrayOfColors objectAtIndex:0];
}



// HAScrollView Delegate method call
- (void) didSelectColor:(HAScrollView *)sender
{
    self.exampleView.backgroundColor = [self.arrayOfColors objectAtIndex:self.colorScrollView.selectedColorNumber - 1];
}



// метод для выставления рандомного цвета
// method for getting random color
- (UIColor*) randomColor
{
    CGFloat redLevel    = rand() / (float) RAND_MAX;
    CGFloat greenLevel  = rand() / (float) RAND_MAX;
    CGFloat blueLevel   = rand() / (float) RAND_MAX;
    
    UIColor *color = [UIColor colorWithRed: redLevel
                                     green: greenLevel
                                      blue: blueLevel
                                     alpha: 1.0];
    return  color;
}



#pragma mark - move colors with buttons
// сдвигает цвета при тапе по кнопке
- (IBAction) moveRightButtonPressed:(id)sender
{
    [self.colorScrollView setColorNumber:self.colorScrollView.selectedColorNumber + 1 animated:YES];
    self.moveToLeftButton.enabled = YES;
    
    if (self.colorScrollView.selectedColorNumber  == self.colorScrollView.colors.count)
    {
        self.moveToRightButton.enabled = NO;
    }
}

// сдвигает цвета при тапе по кнопке
- (IBAction) moveLeftButtonPressed:(id)sender
{
    [self.colorScrollView setColorNumber:self.colorScrollView.selectedColorNumber - 1 animated:YES];
    self.moveToRightButton.enabled = YES;
    
    if (self.colorScrollView.selectedColorNumber  == 0)
    {
        self.moveToLeftButton.enabled = NO;
    }
}
@end
