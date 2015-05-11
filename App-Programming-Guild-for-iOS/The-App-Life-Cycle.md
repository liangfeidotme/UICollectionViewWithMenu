The Main Function
---

The `main` function's job is to hand control off to the UIKit framework. The `UIApplicationMain` function handles this process by creating the core objects of your app, loading your app's user interface from the avaialbe `storyboard` files, calling your custom code so that you have a chance to do some initial setup, and putting the app's run loop in motion.

**The role of objects in an iOS app**

* UIApplication
    * event loop & other high-level app behaviors.
* App delegate
    * app initialization, state transitions, high-level app events.
    * the only one guaratteed to be present in every app, so it is often used to set up the app's initial data structures.
* Documents and data model objects
    * **Document-Based App Programming Guide for iOS**
* View controller objects
    * View controller objects manage the presentation of your app's content on screen.
    * A view controller manages a single view and its collection of subviews.
    * When presented, the view controller makes its view visible by installing them in the app's window.
    * loading views, presenting them, rotating them
    * **View controller Programming Guide for iOS**
* UIWindow object
    * coordinates the presentation of one or more views on a screen.
    * In addition to hosting views, windows work with the `UIApplication` object to deliver events to your views and view controllers.
* View objects, control objects, and layer objects
    * Views and controls provide the visual representation of your app's content.
    * A view is an object that draws content in a designated rectangular area and responds to events within that area.
    * Controls are a specified type of view responsible for implementing familar interface objects such as buttons, text fields, and toggle switches.
    * **Layer objects** are actully data objects that represent visual content.

The Main Run Loop
---

The `UIApplication` object sets up the main run loop at launch time and uses it to process events and handle updates to view-based interfaces.

A touch event is usually dispatched to the main window object, which in turn dispatches it to the view in which the touch occurred.

** Event Handling Guide for iOS **

Common types of events for iOS apps

* Touch
    * Views are responder objects.
* Remote control / Shake motion events
    * headphones & other accessories
* Accelerometer / Magnetometer / Gyroscope
* Location
    * **Location and Maps Programming Guide**
* Redraw
    * **Drawing and Printing Guide for iOS**

The `UIApplication` object, your view objects, and your view controller objects are all examples of responder objects.

***responder chain***

Execution States for Apps
---

![](https://developer.apple.com/library/ios/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/Art/high_level_flow_2x.png)

**App status**

* Not running
* Inactive
    * The app is running in the foreground but is currently not receiving events.
    * An app usually stays in this state only briefly as it transitions to a different state.
* Active
* Background
* Suspended
    * When a low-memory condition occures, the system may purge suspended apps without notice to make more space for the foreground app.


* `application:willFinishLauchingWithOptions:`
* `application:didFinishLaunchingWithOptions:`
* `applicationDidBecomeActive:`
* `applicationWillResignActive:`
* `applicationDidEnterBackground:`
* `applicationWillEnterForeground:`
* `aplicationWillTerminate:`
