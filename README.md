# `esptouch`

Flutter plugin package which contain an API for ESP-TOUCH written in Dart combined with platform-specific implementation for Android using Java and iOS using Objective-C.

## Getting Started

## Development

1. Install Flutter.
    Follow the [official installation guide](https://flutter.dev/docs/get-started/install). You can verify your installation by executing the following commands
    ```
    $ flutter --version
    $ flutter doctor
    ```
2. Configure your IDE
   * For Flutter and Dart code, you can use [Android Studio](https://flutter.dev/docs/development/tools/android-studio) or [Visual Studio Code](https://flutter.dev/docs/development/tools/vs-code).
   * To work with Android-specific code (`.gradle, .java`), use [Android Studio](https://flutter.dev/docs/development/tools/android-studio)
   * To work with iOS-specific code (`.m, .h`), use [Xcode](https://developer.apple.com/xcode/)
3. Connect a real device
   Much of the plugin will not work in emulators and simulators, so you need real devices for development.
   ```
   flutter devices
   ```
4. Run example app

    1. Install packages `flutter packages get`
    2. Run the app `flutter run`. After some time, you should see the app open on your phone.

    

## Fundamentals

> In this section, we include links and tutorials to basic technologies that this repository relies on. New developers should start by reading these documentation links.

### [Flutter](https://flutter.io/)

Flutter is Google's UI toolkit for creating beautiful, native experiences for iOS and Android from a single codebase.

For help getting started with Flutter, view the [online documentation](https://flutter.io/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.

#### [Flutter plugin packages](https://flutter.io/developing-packages/)

This repository contains a Flutter plugin package for ESP-TOUCH. A plugin package is a specialized package that includes platform-specific implementation code for Android and iOS.


### ESP-TOUCH

Using ESP-TOUCH, you can configure network for ESP8266 and ESP32 devices.

> Espressif’s ESP-TOUCH protocol implements the Smart Config technology to help users connect ESP8266EX- and ESP32-embedded devices to a Wi-Fi network through simple configuration on a smartphone.

## Resources

* [`EspressifApp/EsptouchForIOS`](https://github.com/EspressifApp/EsptouchForIOS) ESP-Touch for iOS using Objective-C
* [`EspressifApp/EsptouchForAndroid`](https://github.com/EspressifApp/EsptouchForAndroid) ESP-Touch for Android using Java
* [Espressif ESP-TOUCH Overview](https://www.espressif.com/en/products/software/esp-touch/overview)
* [ESP-TOUCH User Guide (`.pdf`)](https://www.espressif.com/sites/default/files/documentation/esp-touch_user_guide_en.pdf)

### Style Guides

As we are writing Dart, Java and Objective-C code, we need familiarize ourselves with each language's style guide. Whenever possible, prefer automated solutions or IDE configs that help other developers write consistent code "automatically".

* Objective-C: [Google Objective-C Style Guide](http://google.github.io/styleguide/objcguide.html)
* Java: ???
* Dart: [Effective Dart: Style](https://www.dartlang.org/guides/language/effective-dart/style) and [`dartfmt`](https://github.com/dart-lang/dart_style)
