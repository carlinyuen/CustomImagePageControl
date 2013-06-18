ios-objc-custom-page-control
============================

Custom PageControl that can draw images as well as dots as page indicators. Simply stores two extra arrays that hold images for active and inactive states for each page.

Super simple setup and usage:

 1. Add folder to project.
 2. #import into desired view controller.
 3. Alloc, initWithFrame, and addSubview like any other UIView.
 4. Set numberOfPages, currentPage, setPageImage:withImage:forState: accordingly.
 5. Add delegate to capture when user taps on a page indicator.

From there, the customization is all yours!

![Screenshot](/screenshot.png "Example")
