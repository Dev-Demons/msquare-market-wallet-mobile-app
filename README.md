# MSQUARE MARKET Mobile Application

A Crypto Wallet created in Flutter using GetX and Provider. This wallet is available only for Android and iOS Mobile Devices. To clone this wallet use:

* Main Branch (Stable Channel) : https://github.com/globalmsq/msquare-market-wallet-mobile-app/blob/main

## Getting Started

## How to use
### Android Only
**Step 1:**

Download or clone this repo using the link below:
```
https://github.com/globalmsq/msquare-market-wallet-mobile-app.git
```
**Step 2:**

Go to root project and execute the following command:
```
flutter pub get
```
**Step 3:**

Run the following command to run the applcation
```
flutter run
```
**Step 4:**

Setup Firebase App for Android in Firebase Console using following:
```
https://firebase.google.com/docs/flutter/setup?platform=android
```

## Features
* Fingerprint Authentication
* Realtime Internet Connection Check
* Crashlytics
* Social Logins
* Password Authentications
* Encrypted Data
* QR Code Transactions
* Deep link payments
* Realtime User Data
* Transaction History
* Wallet Termination
* Language Selection (Chinese, English, Japanese, Korean)
## Upcoming Features
* Crypto Tokens Price Tracker
* First Time Usage Tutorial
* Better User Interface

## Libraries and Packages
* [Connectivity Plus](/https://pub.dev/packages/connectivity_plus)
* [Adaptive Dialog](https://pub.dev/packages/adaptive_dialog)
* [Dotted Border](https://pub.dev/packages/dotted_border)
* [Flutter Image Slideshow](https://pub.dev/packages/flutter_image_slideshow)
* [Flutter Screen Util](https://pub.dev/packages/flutter_screenutil)
* [Flutter SVG](https://pub.dev/packages/flutter_svg)
* [Firebase Authentication](https://pub.dev/packages/firebase_auth)
* [Firebase Core](https://pub.dev/packages/firebase_core)
* [Flutter Facebook Authentication](https://pub.dev/packages/flutter_facebook_auth)
* [Google Sign in](https://pub.dev/packages/google_sign_in)
* [Firebase Dynamic Links](https://pub.dev/packages/firebase_dynamic_links)
* [Sign in with Apple](https://pub.dev/packages/sign_in_with_apple)
* [Firebase Crashlytics](https://pub.dev/packages/firebase_crashlytics)
* [Get](https://pub.dev/packages/get)
* [Get It](https://pub.dev/packages/get_it)
* [Provider](https://pub.dev/packages/provider)
* [Google Fonts](https://pub.dev/packages/google_fonts)
* [http](https://pub.dev/packages/http)
* [Internet Connection Checker](https://pub.dev/packages/internet_connection_checker)
* [Local Auth](https://pub.dev/packages/local_auth)
* [Modal Progress Hud](https://pub.dev/packages/modal_progress_hud)
* [QR Code Scanner](https://pub.dev/packages/qr_code_scanner)
* [QR Flutter](https://pub.dev/packages/qr_flutter)
* [Shared Preferences](https://pub.dev/packages/shared_preferences)
* [Email Validator](https://pub.dev/packages/email_validator)
* [WebView Flutter](https://pub.dev/packages/webview_flutter)
* [Tutorial Coach Mark](https://pub.dev/packages/tutorial_coach_mark)

## Folder structure
The main folder structure provided for this wallet is as following:
```
futter-app/
|-android/
|-assets/
|-fonts/
|-ios/
|-lib/
```

The lib folder has follosing structure:
```
lib/
|-app_config
|-v2
```



### App Config

```
app_config/
|-app_config.dart
|-app_theme.dart
```

### V2 
```
v2/
|-core/
|-ui/
```
Now, lets dive into the lib folder which has the main code for the application.

```
1- core - All the application level constants, enums, models,APIs and services are declared here.
2- UI - Contains the View Layer of project inccludes components, screens(views) and widgets
```
### Core
```
|-core/
    |-constants/
        |-api_endpoints.dart
        |-colors.dart
        |-functions.dart
        |-static_values.dart
        |-style.dart

    |-enums/
        |-token_type.dart
        |-view_state.dart

    |-localization/
        |-languages.dart

    |-models/
        |-app_user.dart
        |-base_view_model.dart
        |-connections.dart
        |-decimal_text_input_formatter.dart
        |-history.dart
        |-notification_model.dart
        |-order_model.dart
        |-password_model.dart
        |-scan_data.dart
        |-transaction_model.dart

    |-services/
        |-api_services.dart
        |-auth_services.dart
        |-database_services.dart
        |-deep_link_payment.dart
        |-language_services.dart
        |-local_auth.dart
    
        |-API/
            |-order_api_service.dart
            |-transaction_api_service.dart
            |-user_api_service.dart
            |-wallet_api_service.dart
        
        |-locator_services
            |-internet_connectivity_service.dart
            |-password_attempt.dart

    |-devices_type.dart
```
### UI
```
|-ui/
    |-components/
        |-custom_snackbar.dart
        |-custom_snackbars.dart
        |-restart_widget.dart

    |-screens/
        |-splash_screen.dart
        |-web_view_screen.dart
   
        |-authentications/
            |_registration_complete.dart
            |_registration_provider.dart
            
            |-createid/
                |_create_id.dart
                |_create_id_provider.dart
                |_create_password.dart
                |_create_password_provider.dart
            
            |-login/
                |-login_provider.dart
                |-login_screen.dart
        
        |-contact_us/
            |-contact_us_provider.dart
            |-contact_us_screen.dart
        
        |-fallback_error/
            |-fallback_error_screen.dart
            |-no_internet_screen.dart
        
        |-history/
            |-history.dart
            |-history_provider.dart
        
        |-homescreen/
            |-base_screen.dart
            |-homescreen_provider.dart
            |-home_screen.dart
        
        |-notifications/
            |-notifications.dart
            |-notification_provider.dart
        
        |-onboarding/
            |-onboarding_provider.dart
            |-onboarding_screen.dart
        
        |-p2p/
            |-p2p_buy.dart
            |-p2p_provider.dart
            |-p2p_screen.dart
            
            |-p2p_create_ad/
                |-create_p2p_ad_provider.dart
                |-create_p2p_ad_screen.dart
            
            |-p2p_listing/
                |-p2p_user_screen.dart
                |-p2p_user_screen_provider.dart
        
        |-payment/
            |-mobile_payment.dart
            |-mobile_payment_provider.dart
        
        |-scanning/
            |-barcode_screen.dart
            |-barcode_screen_provider.dart
        
        |-settings/
            |-setting_provider.dart
            |-setting_screen.dart
        
        |-swap/
            |-swaping.dart
            |-swapping_provider.dart
        
        |-wallet/
            |-copy_address.dart
            |-my_wallet.dart
            |-my_wallet_provider.dart
            |-successfuly_connected.dart
            |-wallet_provider.dart
            |-wallet_request.dart
            |-wallet_req_provider.dart
            |-wallet_screen.dart
        
        |-wallet_termination/
            |-wallet_termination.dart
            |-wallet_termination_provider.dart

    |-widgets/
        |-barcode_token_widget.dart
        |-buy&sell_widget.dart
        |-custom_app_bar.dart
        |-custom_button.dart
        |-custom_login_button.dart
        |-custom_text_input_field.dart
        |-divider_widget.dart
        |-history_widget.dart
        |-password_snackbar.dart
        |-wallet_address_widget.dart
        
        |-buttons/
            |-custom_cancel_button.dart

        |-create_screen_widget/
            |-circular_check_button.dart
            |-registration_wallet_widget.dart

        |-dialogues/
            |-custom_alert_dialog.dart
            |-dialogue_single_button.dart
            |-fingerprint_unlock_dialogue.dart
            |-password_validation_dialogue.dart
            |-unlock_dailogue.dart

        |-history_widgets/
            |-history_list_card.dart
            |-rich_text_history_widget.dart

        |-home_screen_widgets/
            |-crypto_widget.dart
            |-slide_show_banner.dart

        |-p2p_widgets/
            |-asset_token_widget.dart
            |-custom_circular_indicator.dart
            |-decorated_tab_bar.dart
            |-empty_listing_widget.dart
            |-order_list_widget.dart
            |-order_widget.dart
            |-p2p_listing_card.dart

        |-setting_screen_widgets/
            |-setting_screen_widget.dart

        |-swap_screen_widgets/
            |-small_button.dart

|-firebase_options.dart
|-locator.dart
|-main.dart

```


## Archtecture

MVVM (Mode View ViewModel) architecture is an industry leading architecture and coding style which prevails all across mobile application developers industry is being used for development of this project. 

## Firebase App Distribution
Following are the Firebase App Distributions:
1. Developers
    https://appdistribution.firebase.dev/i/2bdcebcbb3bb59d0
2. Internal Testers
    https://appdistribution.firebase.dev/i/76564024c7fcbd41
3. External Testers
    https://appdistribution.firebase.dev/i/39026ba057b722c1

    


## Possible Error while running the app after cloning.

# Change Log
Old code, of design v1 was removed at the following commit by Imad Rashid (r.imad@mufin.co.kr)

    commit d6e7c81ae5fe648351548a8faf0a4a83409e9d30 (HEAD -> v0.7.0)
Author: ImadRashid <r.imad@mufin.co.kr>
Date:   Wed Sep 28 20:34:33 2022 +0500

    Legacy Code has been removed, app has been refactored.

In case anyone needs to revert back they can utilize above commit details to revert their head
