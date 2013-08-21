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

	/* Set these to control the CustomPageControl. */
	@property (nonatomic, assign) NSInteger currentPage;
	@property (nonatomic, assign) NSInteger numberOfPages;

	/* Customize spacing & dot size */
	@property (nonatomic, assign) CGFloat dotDiameter;
	@property (nonatomic, assign) CGFloat dotSpacing;

	/* Custom dot colors */
	@property (nonatomic, strong) UIColor *currentDotTintColor;
	@property (nonatomic, strong) UIColor *dotTintColor;

	/* Optional delegate for callbacks when user taps a page dot. */
	@property (nonatomic, weak) NSObject<CustomPageControlDelegate> *delegate;

	/** @brief Set image for a page indicator at a given index */
	- (void)setPageImage:(NSInteger)page withImage:(UIImage*)image forState:(CustomPageControlImageState)state;

@end


#pragma mark - Delegate

@protocol CustomPageControlDelegate<NSObject>
@optional

	- (void)pageControlPageDidChange:(CustomPageControl *)pageControl;

@end