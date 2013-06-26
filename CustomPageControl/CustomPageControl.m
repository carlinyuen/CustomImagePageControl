/**
	@file	CustomPageControl.m
	@author	Carlin
	@date	6/12/13
	@brief	Custom page indicator control element that lets you use images as well.
*/
//  Copyright (c) 2013 Carlin Yuen. All rights reserved.


// Tweak these or make them dynamic.
#define kDotDiameter 7.0
#define kDotSpacer 7.0


#import "CustomPageControl.h"

@interface CustomPageControl ()

	/** Custom images */
	@property (nonatomic, strong) NSMutableArray* inactiveImages;
	@property (nonatomic, strong) NSMutableArray* activeImages;

@end


#pragma mark - Implementation

@implementation CustomPageControl

/** @brief Initialize data-related properties */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		// Default colors.
        self.backgroundColor = [UIColor clearColor];
        self.dotColorCurrentPage = [UIColor blackColor];
        self.dotColorOtherPage = [UIColor lightGrayColor];
		
		// Initialize images
		self.inactiveImages = [NSMutableArray array];
		self.activeImages = [NSMutableArray array];
    }
    return self;
}


#pragma mark - Class Functions

- (void)setCurrentPage:(NSInteger)page
{
    _currentPage = MIN(MAX(0, page), _numberOfPages - 1);
    [self setNeedsDisplay];
}


- (void)setNumberOfPages:(NSInteger)pages
{
    _numberOfPages = MAX(0, pages);
    _currentPage = MIN(MAX(0, _currentPage), _numberOfPages - 1);

	// Clear up images
	if (self.inactiveImages.count > _numberOfPages) {
		self.inactiveImages = [[self.inactiveImages
			subarrayWithRange:NSMakeRange(0, _numberOfPages)] mutableCopy];
	}
	if (self.activeImages.count > _numberOfPages) {
		self.activeImages = [[self.activeImages
			subarrayWithRange:NSMakeRange(0, _numberOfPages)] mutableCopy];
	}
	
    [self setNeedsDisplay];
}

/** @brief Sets image for page indicator at index */
- (void)setPageImage:(NSInteger)page withImage:(UIImage*)image forState:(CustomPageControlImageState)state
{
	if (page < self.numberOfPages)
	{
		switch (state) {
			case CustomPageControlImageStateActive:
				[self.activeImages setObject:image atIndexedSubscript:page];
				break;

			case CustomPageControlImageStateInactive:
			default:
				[self.inactiveImages setObject:image atIndexedSubscript:page];
				break;
		}
	}
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();   
    CGContextSetAllowsAntialiasing(context, true);

    CGRect currentBounds = self.bounds;
    CGFloat dotsWidth = self.numberOfPages*kDotDiameter + MAX(0, self.numberOfPages-1)*kDotSpacer;
    CGFloat x = CGRectGetMidX(currentBounds)-dotsWidth/2;
    CGFloat y = CGRectGetMidY(currentBounds)-kDotDiameter/2;
    for (int i=0; i<_numberOfPages; i++)
    {
		UIImage* image;
        CGRect circleRect = CGRectMake(x, y, kDotDiameter, kDotDiameter);
        if (i == _currentPage)
        {
			if (self.activeImages.count > i) {
				image = [self.activeImages objectAtIndex:i];
			} else {
				CGContextSetFillColorWithColor(context, self.dotColorCurrentPage.CGColor);
			}
        }
        else
        {
			if (self.inactiveImages.count > i) {
				image = [self.inactiveImages objectAtIndex:i];
			} else {
				CGContextSetFillColorWithColor(context, self.dotColorOtherPage.CGColor);
			}
        }
	
		// If image exists, draw it
		if (image && image != (id)[NSNull null])
		{
			circleRect.origin.x -= kDotDiameter / 4;
			circleRect.origin.y -= kDotDiameter / 4;
			circleRect.size.width += kDotDiameter / 2;
			circleRect.size.height += kDotDiameter / 2;
			CGContextDrawImage(context, circleRect, image.CGImage);
		}
		else {	// Standard dot
			CGContextFillEllipseInRect(context, circleRect);
		}
			
        x += kDotDiameter + kDotSpacer;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.delegate) return;

    CGPoint touchPoint = [[[event touchesForView:self] anyObject] locationInView:self];

    CGFloat dotSpanX = self.numberOfPages*(kDotDiameter + kDotSpacer);
    CGFloat dotSpanY = kDotDiameter + kDotSpacer;

    CGRect currentBounds = self.bounds;
    CGFloat x = touchPoint.x + dotSpanX/2 - CGRectGetMidX(currentBounds);
    CGFloat y = touchPoint.y + dotSpanY/2 - CGRectGetMidY(currentBounds);

    if ((x<0) || (x>dotSpanX) || (y<0) || (y>dotSpanY)) return;

    self.currentPage = floor(x/(kDotDiameter+kDotSpacer));
    if ([self.delegate respondsToSelector:@selector(pageControlPageDidChange:)])
    {
        [self.delegate pageControlPageDidChange:self];
    }
}

@end
