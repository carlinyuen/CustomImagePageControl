//
//  CCViewController.m
//  CustomImagePageControlExample
//
//  Created by . Carlin on 11/19/13.
//  Copyright (c) 2013 Carlin Creations. All rights reserved.
//

#import "CCViewController.h"

#import "CustomImagePageControl.h"

#define NUM_PAGES 6
#define SIZE_UI_MIN_TOUCH 44

@interface CCViewController () <
    CustomImagePageControlDelegate
>
//@property (weak, nonatomic) IBOutlet CustomImagePageControl *pageControl;
@property (strong, nonatomic) CustomImagePageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get size of screen
    CGRect viewFrame = [[UIScreen mainScreen] bounds];
    
    // Setup scrollview views
    float shade = (128.f / NUM_PAGES);
    for (int i = 0; i < NUM_PAGES; ++i)
    {
        CGRect frame = CGRectMake(
            CGRectGetWidth(viewFrame) * i,  
            0, 
            CGRectGetWidth(viewFrame), 
            CGRectGetHeight(viewFrame)
        );
        UIView *view = [[UIView alloc] initWithFrame:frame];
        float color = (shade * (i + 1) + 128.f) / 255.f;
        view.backgroundColor = [UIColor 
            colorWithRed:0
            green:color / 2 
            blue:color 
            alpha:1];
        
        [self.scrollView addSubview:view];
    }
    
    // Setup scrollview
    self.scrollView.pagingEnabled = true;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.showsVerticalScrollIndicator = false; 
    self.scrollView.bounces = true;
    self.scrollView.contentSize = CGSizeMake(
        CGRectGetWidth(viewFrame) * NUM_PAGES,
        CGRectGetHeight(viewFrame)
    );
    
    // PageControl
    self.pageControl = [[CustomImagePageControl alloc] initWithFrame:CGRectMake(
        0, CGRectGetHeight(viewFrame) - SIZE_UI_MIN_TOUCH, 
        CGRectGetWidth(viewFrame), SIZE_UI_MIN_TOUCH
    )];
//    self.pageControl.frame = CGRectMake(0, 100, 320, 24);
	self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0 green:0 blue:.3 alpha:1];
    self.pageControl.numberOfPages = NUM_PAGES;
	self.pageControl.currentPage = 0;
    self.pageControl.delegate = self;
    [self.view addSubview:self.pageControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Class Methods

- (void)scrollToPage:(int)page
{
    [self.scrollView scrollRectToVisible:CGRectMake(
        page * self.view.frame.size.width, 0, 
        self.view.frame.size.width, self.view.frame.size.height
    ) animated:true];
}


#pragma mark - CustomPageControlDelegate

/** @brief When page control dot is tapped */
- (void)pageControlPageDidChange:(CustomImagePageControl *)pageControl
{
    [self scrollToPage:pageControl.currentPage];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// Change page control accordingly:
	//	Update the page when more than 50% of the previous/next page is visible
    float pageSize = scrollView.bounds.size.width;
    int page = floor((scrollView.contentOffset.x - pageSize / 2) / pageSize) + 1;

	// Bound page limits
	if (page >= NUM_PAGES) {
		page = NUM_PAGES - 1;
	} else if (page < 0) {
		page = 0;
	}
	
    // Update page control as we scroll
    self.pageControl.currentPage = page;
}


@end
