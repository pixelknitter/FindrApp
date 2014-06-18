FindrApp
=========

An app that utilizes Yelp APIs to bring you closer to finding what you need.

Time spent: 20 hours spent in total

## User Stories

### Required:
#### Search Results Page
* [x] Table rows should be dynamic height according to the content height
* [x] Custom cells should have the proper Auto Layout constraints
* [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).

#### Filter page
##### (Unfortunately, not all the filters are supported in the Yelp API)

* [x] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
* [x] The filters table should be organized into sections as in the mock.
* [x] You can use the default UISwitch for on/off states.
* [x] Radius filter should expand as in the real Yelp app
* [x] Categories should show a subset of the full list with a "See All" row to expand. Category list is here: http://www.yelp.com/developers/documentation/category_list
* [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.

### Optional:
* [ ] Implement a custom switch for Filters.
* [ ] Infinite scroll for restaurant results.
* [ ] Implement the restaurant detail pages
* [ ] Implement map view of restaurant results.

Walkthrough of all user stories:

![Video Walkthrough](https://raw.githubusercontent.com/NinjaSudo/FindrApp/master/demo_findr.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

**Note**
Forgot to walkthrough some of the bonuses I had added in the walkthrough, there is a network error message as well as a no data message when the filters/search comes up empty.

## Resources Used

### Pods

* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [BDBOAuth1Manager](https://github.com/bdbergeron/BDBOAuth1Manager)
* [MBProgressHUD](https://github.com/jdg/MBProgressHUD)
* [POP](https://github.com/facebook/pop) **(Didn't Use)**
* [LBBlurredImage](https://github.com/lukabernardi/LBBlurredImage) **(Didn't Use)**
* [TSMessages](https://github.com/toursprung/TSMessages)

### APIs

[Yelp Search API](http://www.yelp.com/developers/documentation/v2/search_api)

### Further Reading

* http://www.raywenderlich.com/55384/ios-7-best-practices-part-1
* http://www.yelp.com/developers/documentation/v2/search_api
* http://www.raywenderlich.com/5478/uiview-animation-tutorial-practical-recipes
* http://www.raywenderlich.com/73286/top-5-ios-7-animations
* https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIScrollView_Class/Reference/UIScrollView.html#//apple_ref/occ/instm/UIScrollView/scrollRectToVisible:animated:
* http://locassa.com/animate-uitableview-cell-height-change/
* http://horseshoe7.wordpress.com/2013/05/26/hands-on-with-the-mantle-model-framework/

### Tools

* http://www.hurl.it/

### Credits

[Filter designed by Niels Gesquiere from the Noun Project](http://www.thenounproject.com/megapixl/)

## Personal Notes

* Learned about best practices with self.property versus _property
* Learned about the shared manager design pattern
* Discovered some SWEET Pods (listed below)
* Need to look into setting an icon image more closely for NavBar Button Items
* Focus on one feature at a time
* Research best practices and design patterns
* Start the HW even earlier
