# Interview Demo App to search photos

This application is use to search photos from Flickr APIs.

## Prerequisite

- This app requires Mac OS Catalina (10.15.7) or higher
- Minimum Xcode 11.4.1 required

## Getting Started :

- Clone this project
- Run Interview_Demo.xcodeproj

## Implementation Details

Below are list of Packages and responsibilities of each packages :

- BackEnd - This package contains code base of service handling.
- FronEnd - This package contains code base of view and its business logic.
- Resources - This package holds all resources of application like Assets, Localization file etc.
- Model - This package holds all data models of application.
- Utility - This package holds utilities like LocalizationUtility , AppConstants etc.
- Interview_DemoTests - This package contains all unit test cases of application

Views :

- SearchViewController - This is main view controller which holds collection view and search bar and its interactions.
- SearchViewCollectionCell - This is cusomized UICollectionCell to show cases and image and progressing of image download

View Models :
- SearchViewModel - This is view model view controller interacts with this to update UI layout.

Models :

- PhotoModel - This model respresents a replica of JSON coming from Flickr API
- SearchResultModel - This model also respresents a replica of JSON coming from Flickr API

Service Classes :

- ServiceManager - This class is responsible to talk with URLSession using respective tasks.
- ServiceConstants - This class contains all constants related to services like API_key
- PhotoServiceManager - This class is responsible for calling search module's APIs like search photos / download photos. 
- PhotoCachingManager - This class this responsible for caching of images

