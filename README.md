# Rentall

## Table of contents
- [Introduction](#introduction)
- [Screenshots](#screenshots)
- [Features](#features)
- [Technologies used](#technologies-used)
- [Third-party libraries](#third-party-libraries)
- [License](#license)

## Introduction
- <b>Rentall</b> is a cross-platform mobile app built with Flutter and Firebase, It's made for real estate rent.
- It was made for my graduation project, and i was the project coordinator, [see presentation](https://docs.google.com/presentation/d/1aavZTc0V0L-LTU-S8oY4WsdrNqiVjpUE9VCWXzJ-c-U/edit?usp=sharing).

## Screenshots
<p align="center"> 
<img src="https://i.imgur.com/yvHGXNo.png" width=305 height =597><img src="https://i.imgur.com/C43agr8.png" width=305 height =597>
<img src="https://i.imgur.com/2pUTeL0.png" width=305 height =597><img src="https://i.imgur.com/FUosR08.png" width=305 height =597> 
<img src="https://i.imgur.com/xdLNbP8.png" width=305 height =597><img src="https://i.imgur.com/YYr2geS.png" width=305 height =597>
</p>

## Features
* Browse real estate rental ads
* Search bar for looking up ads
* Filter by city, type, price, period
* Publish or update ads and upload images
* Map view and services, users can navigate rentals on map or display rentals location
* Contact rental host and display his other ads
* Authentication, login by email, Gmail and Facebook
* Share ad externally
* Add rental to favorites
* Localization, available in English and Arabic

## Technologies used

### Firebase
<img src="https://nikhil.is-a.dev/Assets/Card-Image/firebase.webp" width=115 height=115>

- Firestore is the database used in our app, it stores rentals, users, their favorites, etc.

- Firebase Auth is used for all authentication features, including social authentication and verification emails.

- Firebase Storage It is used to store rental images that users upload.

### Algolia
![image](https://user-images.githubusercontent.com/30279216/188701687-8438d6b6-4a5a-4f58-a279-90e568f8e1e1.png)

- Algolia is a search engine that provides accurate typo-tolerant search results.

- It is synced with the firestore database using cloud functions.

### Google Maps API
<img src="https://user-images.githubusercontent.com/30279216/188702236-f359c32e-9ddd-4b5d-9aa6-58a3d13649dc.png" width=115 height=115>

- It is used for map services, displaying map view and locating rentals.

## Third-party libraries
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [equatable](https://pub.dev/packages/equatable)
- [get_it](https://pub.dev/packages/get_it)
- [json_serializable](https://pub.dev/packages/json_serializable)
- [flutter_form_builder](https://pub.dev/packages/flutter_form_builder)
- [shared_preferences](https://pub.dev/packages/shared_preferences)
- [cached_network_image](https://pub.dev/packages/cached_network_image)
- [easy_localization](https://pub.dev/packages/easy_localization)
- [carousel_slider](https://pub.dev/packages/carousel_slider)
- [internet_connection_checker](https://pub.dev/packages/internet_connection_checker)
- [expandable_page_view](https://pub.dev/packages/expandable_page_view)
- [image_picker](https://pub.dev/packages/image_picker)
- [phone_number](https://pub.dev/packages/phone_number)
- [url_launcher](https://pub.dev/packages/url_launcher)
- [permission_handler](https://pub.dev/packages/permission_handler)
- [geolocator](https://pub.dev/packages/geolocator)
- [geocoding](https://pub.dev/packages/geocoding)
- [flutter_svg](https://pub.dev/packages/flutter_svg)
- [share_plus](https://pub.dev/packages/share_plus)
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)

## License
Released under the [MIT License](https://github.com/akhattab451/rentall/blob/master/LICENSE.txt).

