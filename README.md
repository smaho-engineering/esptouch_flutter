# `esptouch_flutter`

Flutter plugin package which contains an API for ESP-Touch written in Dart combined with
platform-specific implementation for Android using Java and iOS using Objective-C.

This package provides a high customizability to the ESP Touch tasks and an idiomatic Dart interface for launching tasks.

Custom task parameters lets the users of this plugin change how long the task runs, you could set it to hours, if this is what your workflow requires.

If you enjoy using this, I'd really appreciate a [**star on GitHub!**](https://github.com/smaho-engineering/esptouch_flutter).

## Usage

### Example app

For a complete example app, see the [`example` folder](https://github.com/smaho-engineering/esptouch_flutter/tree/master/example) in the repository.

The example app lets you configure WiFi SSID, BSSID, password, the duration of the task, expected task count and many more.

### Code snippets

```dart
import 'package:esptouch_flutter/esptouch_flutter.dart';

// Somewhere in your widget...
final ESPTouchTask task = ESPTouchTask(
  ssid: 'My WiFi network',
  bssid: 'ab:cd:ef:12:23:34',
  password: 'ILoveFlutter',
);
final Stream<ESPTouchResult> stream = task.execute();
final printResult = (ESPTouchResult result) {
 print('IP: ${result.ip} MAC: ${result.bssid}');
};
StreamSubscription<ESPTouchResult> streamSubscription = stream.listen(printResult);
// Don't forget to cancel your stream subscription:
streamSubscription.cancel();
```

If you would like to customize the task, provide `ESPTouchTaskParameter` instance as `taskParameter` to `ESPTouchTask`.

```dart
final ESPTouchTask task = ESPTouchTask(
  ssid: 'My WiFi network',
  bssid: 'ab:cd:ef:12:23:34',
  password: 'ILoveFlutter',
  // Tweak the task using task parameters
  taskParameter: ESPTouchTaskParameter(waitUdpReceiving: Duration(hour: 12)),
);
// You can still stop the task at any point by calling .cancel on the stream subscription:
streamSubscription.cancel();
```

In the code example, I specify the types for clarity. You can omit them as Dart can infer them.

In a real world example, you could display the configured devices to the user, save it locally in SQLite or send it to your backend. 

### API reference

The Full API reference is available on [`pub.dev`](https://pub.dev/documentation/esptouch_flutter/latest/).

We put effort into the docs, so if something is still not clear,
[please open an issue](https://github.com/smaho-engineering/esptouch_flutter/issues/new).
We will try top help you out and update the docs.

## Fundamentals

### ESP-Touch

Using ESP-Touch, you can configure network for ESP8266 and ESP32 devices.

> Espressif’s ESP-Touch protocol implements the Smart Config technology to help users connect
> ESP8266EX- and ESP32-embedded devices to a Wi-Fi network through simple configuration on a
> smartphone.


#### Resources

You can read more about ESP-Touch here:

* [Espressif ESP-Touch Overview](https://www.espressif.com/en/products/software/esp-touch/overview)
* [ESP-Touch User Guide (`.pdf`)](https://www.espressif.com/sites/default/files/documentation/esp-touch_user_guide_en.pdf)
* [Smart config API reference](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/network/esp_smartconfig.html) - We don't directly use this in the plugin, but can help you understand how things work
* [`EspressifApp/EsptouchForIOS`](https://github.com/EspressifApp/EsptouchForIOS) ESP-Touch for iOS using Objective-C
* [`EspressifApp/EsptouchForAndroid`](https://github.com/EspressifApp/EsptouchForAndroid) ESP-Touch for Android using Java


The original [iOS](https://github.com/EspressifApp/EsptouchForIOS) and
[Android](https://github.com/EspressifApp/EsptouchForAndroid) apps had to be heavily customized and
tweaked in order to support custom task parameters.

## Known issues

* We needed full customizability for the touch task parameters, these made changing a significant
  chunk of the Android and iOS platform side code necessary.
  We added builders for the task parameters as this looked like a solution that required the least
  changes to the platform code.
* The only way I could implement this plugin is by pasting the platform-specific code into this
  project. One reason for this was that it wasn't published anywhere as easily installable packages,
  and the second reason is that I had to tweak the platform code to support configuration of
  the ESPTouchTaskParameters. This means that new changes to the original git repositories do not
  automatically show up in this project, so we need to manually update the Android and iOS code.
* The underlying Android and iOS apps support different task parameters. There were multiple
  changes especially around IPv4 vs IPv6 handling. The plugin does not handle all of these
  differences.
* Keeping track of finished tasks is necessary on Flutter's side.
* AES support (last I checked the support differred on Android and iOS, so I haven't added them)

## Contribute

This is an open-source project built by the [SMAHO Engineering team from Munich](https://smaho.com) to wrap [Espressif](https://github.com/EspressifApp)'s ESP-Touch mobile app kits.

If you discover issues or know how to improve the project, please contribute: open a pull request or issue.

### Flutter

If you are coming from IoT background, you might not know what Flutter is.

[Flutter](https://flutter.io/) is Google's UI toolkit for creating beautiful, native experiences for iOS and Android from a single codebase. For help getting started with Flutter, view the [online documentation](https://flutter.io/docs).

#### Flutter plugin packages

This repository contains a [Flutter plugin package](https://flutter.io/developing-packages/) for ESP-Touch. A plugin package is a specialized package that includes platform-specific implementation code for Android and iOS.

#### Platform channels

The Flutter portion of the app sends messages to its host, the iOS or Android portion of the app, over a [platform channel](https://flutter.dev/docs/development/platform-integration). This plugin relies on platform channels (event channels) heavily.

### Get started

If you'd like to contribute, the best way to get started is by running the example app.

1. **[Install Flutter](https://flutter.dev/docs/get-started/install).**
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
   
   Make sure you don't see any red squiggly lines, *a properly configured IDE will help a lot during development*.
   
   This is my recommended setup, but other IDEs should also work, e.g [Visual Studio Code](https://flutter.dev/docs/development/tools/vs-code), IntelliJ, or Vim.

3. **Use a real phone for development.** The plugin will not work in emulators and simulators, so you need real phones for development. Run `flutter devices` to verify.

4. **Run the example app**

    1. `cd example`
    2. Install packages `flutter packages get`
    3. Run the app `flutter run`. After some time (~1 minute), you should see the app opening on your phone.

5. **Prepare embedded devices.** To verify that the ESP-Touch app works, you need some hardware with ESP8266 and ESP32 to connect to your WiFi network.
    
**Keep in mind that hot-reload and hot-restart will not reload platform code, so if you change java or obj-c files, you'll need to restart and recompile your app.**

### Style guides

As we are writing Dart, Java and Objective-C code, we need familiarize ourselves with each language's style guide. Whenever possible, prefer automated solutions or IDE configs that help other developers write consistent code "automatically".

When this is not available, fallback to these style guides:

* Dart: [Effective Dart: Style](https://www.dartlang.org/guides/language/effective-dart/style) and [`dartfmt`](https://github.com/dart-lang/dart_style)
* Objective-C: [Google Objective-C Style Guide](http://google.github.io/styleguide/objcguide.html)
* Java: [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
