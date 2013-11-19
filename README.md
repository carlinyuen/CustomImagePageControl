CustomImagePageControl
======================

Custom PageControl that can draw images as well as dots as page indicators. Simply stores two extra arrays that hold images for active and inactive states for each page.

Super simple setup and usage:

 1. Add folder to project.
 2. #import into desired view controller.
 3. Alloc, initWithFrame, and addSubview like any other UIView.
 4. Set numberOfPages, then currentPage, then setPageImage:withImage:forState: accordingly.
 5. Add delegate to capture when user taps on a page indicator.

From there, the customization is all yours! It's also really easy to swap it in
to replace a regular UIPageControl.

### Customization
Properties you can customize:

 * __pageIndicatorTintColor (UIColor)__ Color for usual dot.
 * __currentPageIndicatorTintColor (UIColor)__ Color for current highlighted dot.
 * __dotDiameter (CGFloat)__ Size of dot in points.
 * __dotSpacing (CGFloat)__ Space between each dot in points.

*Note: You should set numberOfPages before currentPage / setPageImage. Lowering
the numberOfPages will truncate the image arrays, so you may have to reset
images.

![Screenshot](/screenshot.png "Example")
