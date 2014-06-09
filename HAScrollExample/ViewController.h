//
//  ViewController.h
//  HAScrollExample
//
//  Created by a.holodok on 27.05.14.
//  Copyright (c) 2014 a.holodok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HAScrollView.h"

@interface ViewController : UIViewController <HAScrollViewDelegate>

@property (nonatomic, strong) IBOutlet HAScrollView * colorScrollView;
@property (strong, nonatomic) IBOutlet UIButton *moveToLeftButton;
@property (strong, nonatomic) IBOutlet UIButton *moveToRightButton;

@property (nonatomic, strong) NSMutableArray * arrayOfColors;

- (IBAction)moveLeftButtonPressed:(id)sender;
- (IBAction)moveRightButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *exampleView;

@end
