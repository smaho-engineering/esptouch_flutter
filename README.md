# `esptouch`

Flutter plugin package which contains an API for ESP-Touch written in Dart combined with platform-specific implementation for Android using Java and iOS using Objective-C.

The original [iOS](https://github.com/EspressifApp/EsptouchForIOS) and [Android](https://github.com/EspressifApp/EsptouchForAndroid) apps had to be heavily customized and tweaked in order to support custom task parameters.

This enables the users of this plugin change how long the task runs, you could set it to hours, if this is what your workflow requires.

## Usage

### Example app

For a complete example app, see [`example` folder](https://github.com/smaho-engineering/esptouch_flutter/tree/master/example) in the repository.

### Code snippets

TODO: Add code snippets in the README to clarify how the plugin should be used

### API reference

TODO: Improve existing Dart documentation and link the API reference so it's easily accessible from Github (not only on Dart Pub).

## Contribute

This is an open-source project built by the [SMAHO Engineering team from Munich](https://smaho.com) to wrap [Espressif](https://github.com/EspressifApp)'s ESP-Touch mobile app kits.

If you discover issues or just want to improve the project, please contribute.

### Get started

To get started, run the example app.

1. **Install Flutter.**
    
    Follow the [official installation guide](https://flutter.dev/docs/get-started/install). You can verify your installation by executing the following commands
    ```
    $ flutter --version
    $ flutter doctor
    ```
2. **Configure your IDE.**

   * For Flutter and Dart code, you can use [Android Studio](https://flutter.dev/docs/development/tools/android-studio).
   ```
   studio .
   ```
   * To work with Android-specific code (`.gradle`, `.java`, ...), use [Android Studio](https://flutter.dev/docs/development/tools/android-studio).
   ```
   studio android
   studio example/android
   ```
   * To work with iOS-specific code (`.m`, `.h`, ...), use [Xcode](https://developer.apple.com/xcode/) and/or [AppCode](https://www.jetbrains.com/objc/).
   ```
   open example/ios/Runner.xcworkspace
   appcode example/ios/Runner.xcworkspace
   ```
   
   Make sure you don't see any red squiggly lines, a properly configured IDE will help *a lot* during development.
   
   This is my recommended setup, but other IDEs should also work, e.g [Visual Studio Code](https://flutter.dev/docs/development/tools/vs-code), IntelliJ, or Vim.

3. **Use a real phone for development.**

   The plugin will not work in emulators and simulators, so you need real phones for development.
   ```
   flutter devices
   ```

4. **Run example app**

    1. `cd example`
    2. Install packages `flutter packages get`
    3. Run the app `flutter run`. After some time, you should see the app open on your phone.

5. **Prepare embedded devices.**

    To verify that the ESP-Touch app works, you need some hardware to connect to your WiFi network.

### Style guides

As we are writing Dart, Java and Objective-C code, we need familiarize ourselves with each language's style guide. Whenever possible, prefer automated solutions or IDE configs that help other developers write consistent code "automatically".

When this is not available, fallback to these style guides:

* Dart: [Effective Dart: Style](https://www.dartlang.org/guides/language/effective-dart/style) and [`dartfmt`](https://github.com/dart-lang/dart_style)
* Objective-C: [Google Objective-C Style Guide](http://google.github.io/styleguide/objcguide.html)
* Java: [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)

## Fundamentals

> In this section, we include links and tutorials to basic technologies that this repository relies on. New developers should start by reading these documentation links.

### [Flutter](https://flutter.io/)

Flutter is Google's UI toolkit for creating beautiful, native experiences for iOS and Android from a single codebase.

For help getting started with Flutter, view the [online documentation](https://flutter.io/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.

#### [Flutter plugin packages](https://flutter.io/developing-packages/)

This repository contains a Flutter plugin package for ESP-Touch. A plugin package is a specialized package that includes platform-specific implementation code for Android and iOS.


### ESP-Touch

Using ESP-Touch, you can configure network for ESP8266 and ESP32 devices.

> Espressif’s ESP-Touch protocol implements the Smart Config technology to help users connect ESP8266EX- and ESP32-embedded devices to a Wi-Fi network through simple configuration on a smartphone.

## Resources

* [`EspressifApp/EsptouchForIOS`](https://github.com/EspressifApp/EsptouchForIOS) ESP-Touch for iOS using Objective-C
* [`EspressifApp/EsptouchForAndroid`](https://github.com/EspressifApp/EsptouchForAndroid) ESP-Touch for Android using Java
* [Espressif ESP-Touch Overview](https://www.espressif.com/en/products/software/esp-touch/overview)
* [ESP-Touch User Guide (`.pdf`)](https://www.espressif.com/sites/default/files/documentation/esp-touch_user_guide_en.pdf)
* [Smart config API reference](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/network/esp_smartconfig.html) - We don't directly use this in the plugin, but can help you understand how things work
