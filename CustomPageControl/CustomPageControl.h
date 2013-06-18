/**
	@file	CustomPageControl.h
	@author	Carlin
	@date	6/12/13
	@brief	A custom page indicator control element that lets you set images as well.
*/
//  Copyright (c) 2013 Carlin Yuen. All rights reserved.

//  Based off version by Morten Heiberg <morten@heiberg.net>
//	http://stackoverflow.com/questions/2942636/how-can-i-change-the-color-of-pagination-dots-of-uipagecontrol/4073602#4073602


#import <UIKit/UIKit.h>

@protocol CustomPageControlDelegate;

typedef enum {
	CustomPageControlImageStateInactive,
	CustomPageControlImageStateActive
} CustomPageControlImageState;

@interface CustomPageControl : UIView

// Set these to control the CustomPageControl.
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger numberOfPages;

// Customize these as well as the backgroundColor property.
@property (nonatomic, strong) UIColor *dotColorCurrentPage;
@property (nonatomic, strong) UIColor *dotColorOtherPage;

// Optional delegate for callbacks when user taps a page dot.
@property (nonatomic, weak) NSObject<CustomPageControlDelegate> *delegate;

- (void)setPageImage:(NSInteger)page withImage:(UIImage*)image forState:(CustomPageControlImageState)state;

@end


#pragma mark - Delegate

@protocol CustomPageControlDelegate<NSObject>
@optional
- (void)pageControlPageDidChange:(CustomPageControl *)pageControl;
@end