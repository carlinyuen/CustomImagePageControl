/**
	@file	CustomImagePageControl.h
	@author	Carlin
	@date	11/19/13
	@brief	A custom page indicator control element that lets you set images as well.
*/
//  Copyright (c) 2013 Carlin Yuen. All rights reserved.

//  Based off version by Morten Heiberg <morten@heiberg.net>
//	http://stackoverflow.com/questions/2942636/how-can-i-change-the-color-of-pagination-dots-of-uipagecontrol/4073602#4073602


#import <UIKit/UIKit.h>

	typedef enum {
		CustomImagePageControlImageStateInactive,
		CustomImagePageControlImageStateActive
	} CustomImagePageControlImageState;


#pragma mark - Delegate

@class CustomImagePageControl;
@protocol CustomImagePageControlDelegate<NSObject>

    @optional
	- (void)pageControlPageDidChange:(CustomImagePageControl *)pageControl;

@end


#pragma mark - Class

@interface CustomImagePageControl : UIView

	/* Set these to control the CustomImagePageControl. */
	@property (nonatomic, assign) NSInteger currentPage;
	@property (nonatomic, assign) NSInteger numberOfPages;

	/* Customize spacing & dot size */
	@property (nonatomic, assign) CGFloat dotDiameter;
	@property (nonatomic, assign) CGFloat dotSpacing;

	/* Custom dot colors */
	@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
	@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

	/* Optional delegate for callbacks when user taps a page dot. */
	@property (nonatomic, weak) NSObject<CustomImagePageControlDelegate> *delegate;

	/** @brief Set image for a page indicator at a given index */
	- (void)setPageImage:(NSInteger)page withImage:(UIImage*)image forState:(CustomImagePageControlImageState)state;

@end
