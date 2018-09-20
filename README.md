# InmoblyChallenge
This task is to make a UIcollectionView displays a photos from flickr API moreover, I used core data to save images in database locally, also user can update view manually by (Pull to refresh feature), finally user can open any image in full screen mode and swipe left and right to next and previous images.
# Language
-   Swift 4.1
# Design
  - VIPER design pattern.
    - View : 2 Classes ```FlickrViewController``` (Main View) and  ` FullScreenViewController` (Full Screen Mode View)
    - Interactor : 1 Class `Interactor`, It Contains all business methods
            -  Flickr API calls
            -  Core Data methods.
    -  Presenter : 1 Class `Presenter`, It Contains methods that fill the passive view with data.
    -  Entity : It owns all models needed `FlickrResource`, `Photos` and `Photo`.

# Pods (V 1.5.2)
- ` pod 'ObjectMapper'`: JSON parser to swift Object.
-  `pod 'SDWebImage'`: third party library to display images by lazy loading.
  
