FindrApp
=========

An app that utilizes Yelp APIs to bring you closer to finding what you need.

Time spent: XX hours spent in total

## Instructions

1. TODO

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

![Video Walkthrough]()

GIF created with [LiceCap](http://www.cockos.com/licecap/).

*Personal Notes:*



## Resources Used

### Pods

* AFNetworking
* BDBOAuth1Manager
* MBProgressHUD
* POP
* TSMessages

### APIs

Yelp API

### Further Reading

http://www.raywenderlich.com/55384/ios-7-best-practices-part-1
http://www.yelp.com/developers/documentation/v2/search_api
http://www.raywenderlich.com/5478/uiview-animation-tutorial-practical-recipes
http://www.raywenderlich.com/73286/top-5-ios-7-animations

### Credits

[Filter designed by Niels Gesquiere from the Noun Project](http://www.thenounproject.com/megapixl/)