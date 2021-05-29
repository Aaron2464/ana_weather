# ANA weather app
Take home assignment

## The Task
Develop an app that:
    * Allow users to see current weather information based on their current location (device location).
    * Makes use of theOpen WeatherAPI.  Is built using a Flutter framework that supports both iOS and Android

Stretch Goals
    * Allows users to view current weather by any location.
    * Allow users to store their 3 favorite locations within the app (locally).

## ScreenShot
    <img src="https://github.com/Aaron2464/ana_weather/blob/master/screen_shot/homepage.png"  width="180" height="374"> &emsp;&emsp;

### Notes
    1. The WidgetFlutterBinding is used to interact with the Flutter engine. Sqflite openDatabase needs to call native code to initialize Sqflite,
        and since the plugin needs to use platform channels to call the native code, which is done asynchronously therefore you have to call ensureInitialized()
        to make sure that you have an instance of the WidgetsBinding.
    2. If trying to access location in the background and add nescessary permissions.
        android:
            I should place the required permissions in my applications <my-app>/android/app/src/main/AndroidManifest.xml:
            <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
            <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
        ios:
            I should add permission in Info.plist
            // The is likely the only one you need. Background location is supported
            // by this -- the caveat is that a blue badge is shown in the status bar
            // when the app is using location service while in the background.
            <key>NSLocationWhenInUseUsageDescription</key>
            <string>App needs access to location and direction when open.</string>
    3. The first item in screen_shot is current weather at current city.
       If user don't provide location permission, the first item won't show up and list view will cove it.

### Date
    2021/05/29

### Instructions for how to build & run the app
    1. Please type 'pub get' in CLI once you download the project.
    2. Please allow the app to use device location, otherwise the weather of current location won't show up.

### Time spent
    7 hours

### Assumptions made
    In the beginning, I planed to create the ticket on Trello, and create 3 pages.
    1. To show the current weather at current location
    2. Add search page in order to search the city's weather that user would like to see and add in favorite page
    3. User could add city's weather during searching in favorite page
    4. Create a table in database to store the favorite weather of city.
    5. Error handling
    But it take too much time after discussing. :P

    So...The conclusion for me is creating one page include everything that you could see in the screen_shot

### Shortcuts/Compromises made
    I felt better that I have quick idea and solution than I just learnt Flutter.
    Such as I'd like to create three page, but I have been noticed don't go too far by  recruiter. Then some another idea came into my brain quickly.

### Why did you choose the technology/framework you used?
    I have used bloc design pattern the reason is trying to make code clean and readable.
    It's going to be easy after separated business mode, logic and UI when we want to test.
    Also it's easy to scale.

### Stretch goals attempted
    I attempted to stretch two of them, but combined them into one feature that user can press floating button to add current weather by any city and store the location immediately
    I wish I could done it better that of course I am going to split the current weather at current location and favorite location like I have Assumptions above.
    And also adding delete, reorder list, edit list item function in it. Perfect UI for sure. :P

### What did you not include in your solution that you want us to know about?
    1. I'd like to include edit, remove and reorder item in list
    2. Perfect UI design.
    3. 3 different pages like I mention it on Assumptions made section :)
    4. Update the current weather everyday.
    5. Showing more information about weather on UI.
    6. Search bar at the first page

### Other information about your submission that you feel it's important that we know if applicable.
    I have been working remotely for one and half years, I am very good at time management.
    And also I'm a self-starter who loves to handle difficult challenges with my approach by working as a team or independently.

### Your feedback on this technical challenge
    If the company can provide simple UI design, I assume that is better.
    Because we have different professional skill, and it could test how the mobile developer cooperate with UI designer.
    And if there is a simple api, it could test between mobile developer and backend developer as well.
    In order to know how we can work collaborated with cross-functional groups perfectly. :)


**Thank you for taking time to have a look at this and my code.
**Hope to hear from you soon. :)
**Aaron
