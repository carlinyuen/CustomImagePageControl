CustomImagePageControl
======================

Custom PageControl that can draw images as well as dots as page indicators. Simply stores two extra arrays that hold images for active and inactive states for each page.

Super simple setup and usage:

 1. Add folder to project.
 2. #import into desired view controller.
 3. Alloc, initWithFrame, and addSubview like any other UIView.
 4. Set numberOfPages, then currentPage, then setPageImage:withImage:forState: accordingly.
 5. Add delegate to capture when user taps on a page indicator.

From there, the customization is all yours!

### Customization
Extra properties you can customize:

 * _dotTintColor_ (UIColor) Color for usual dot.
 * _currentDotTintColor_ (UIColor) Color for current highlighted dot.
 * _dotDiameter_ (CGFloat) Size of dot in points.
 * _dotSpacing_ (CGFloat) Space between each dot in points.

*Note: You should set numberOfPages before currentPage / setPageImage. Lowering
the numberOfPages will truncate the image arrays, so you may have to reset
images.

![Screenshot](/screenshot.png "Example")
