//
//  HAScrollView.h
//  HAScrollExample
//
//  Created by a.holodok on 21.05.14.
//  Copyright (c) 2014 a.holodok. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HAScrollView;         //define class, so protocol can see HAScrollView
@protocol HAScrollViewDelegate <NSObject>  //define delegate protocol
@optional

-(void)didSelectColor: (HAScrollView *) sender;  //define delegate method to be implemented within another class

@end

@interface HAScrollView : UIScrollView <UIScrollViewDelegate>

-(void)setColorNumber:(int)colorNumber animated:(BOOL)animated;

@property float circleDistance;      // distance value between centers of neighbour circles
@property float circleSmallDiametr;  // width of unselected color circles
@property float circleLargeDiametr;  // width of selected color circle
@property (readonly) int selectedColorNumber; // number of circle in a row (in array)
@property (nonatomic, strong) NSArray * colors;

@property (nonatomic, weak) id <HAScrollViewDelegate> haDelegate; //define HAScrollViewDelegate as delegate

@end
