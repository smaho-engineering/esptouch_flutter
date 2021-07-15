# `esptouch_flutter`

> Flutter plugin for ESP-Touch to configure network for ESP-8266 and ESP-32 devices. Runs on iOS and Android.

`esptouch_flutter` is Flutter plugin package which contains an API for ESP-Touch written in Dart combined with
platform-specific implementation for Android using Java and iOS using Objective-C.

This package provides a high customizability to the ESP Touch tasks and an idiomatic Dart interface for launching tasks. Custom task parameters lets the users of this plugin change how long the task runs, you could set it to hours, if this is what your workflow requires.


[![smaho-engineering/esptouch_flutter](https://img.shields.io/static/v1?label=smaho-engineering&message=esptouch_flutter&logo=flutter&logoWidth=30&color=FF8200&labelColor=08589c&labelWidth=30)](https://github.com/smaho-engineering)

[![weekday_selector](https://img.shields.io/pub/v/esptouch_flutter?label=esptouch_flutter&logo=data:image/png;base64,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)](https://pub.dev/packages/esptouch_flutter 'See esptouch_flutter package info on pub.dev')

[![GitHub Stars Count](https://img.shields.io/github/stars/smaho-engineering/esptouch_flutter?logo=github)](https://github.com/smaho-engineering/esptouch_flutter 'Star our repository on GitHub!')

## Important links

* [**Star the repo on GitHub! ⭐️**](https://github.com/smaho-engineering/esptouch_flutter)
* [Check package info on `pub.dev`](https://pub.dev/packages/esptouch_flutter)
* [Open an issue](https://github.com/smaho-engineering/esptouch_flutter/issues)
* [Read the docs](https://pub.dev/documentation/esptouch_flutter/latest/) We put effort into the docs, so if something is still not clear, open an issue. We will try top help you out and update the docs.
* This Dart package is created by the [SMAHO development team](https://github.com/smaho-engineering).

## Usage

### Example app

<img src="https://github.com/smaho-engineering/esptouch_flutter/raw/master/example/screenshots/simple_config.png?raw=true" alt="GIF Flutter plugin esptouch_flutter - Example app in action" height="500"/>

For a **complete example app**, see the [`example` folder](https://github.com/smaho-engineering/esptouch_flutter/tree/master/example) in the repository.

The example app lets you configure WiFi SSID, BSSID, password, the duration of the task, expected task count and many more.

For a **simplest possible app**, see the [`smaho-engineering/esptouch_flutter_kotlin_example`](https://github.com/smaho-engineering/esptouch_flutter_kotlin_example) repository.

### Code snippets

```dart
import 'package:esptouch_flutter/esptouch_flutter.dart';

// Somewhere in your widget...
final ESPTouchTask task = ESPTouchTask(
  ssid: 'My WiFi network',
  bssid: 'ab:cd:ef:12:23:34',
  password: 'I love SMAHO',
);
final Stream<ESPTouchResult> stream = task.execute();
final printResult = (ESPTouchResult result) {
 print('IP: ${result.ip} MAC: ${result.bssid}');
};
StreamSubscription<ESPTouchResult> streamSubscription = stream.listen(printResult);

// Don't forget to cancel your stream subscription.
// You might cancel after the UDP wait+send time has passed (default 1 min)
// or you could cancel when the user asked to cancel
// for example, either via X button, or popping a route off the stack.
streamSubscription.cancel();
```

If you would like to customize the task, provide an `ESPTouchTaskParameter` instance as `taskParameter` to `ESPTouchTask`. In the code example, I specify the types for clarity but you can omit the types as Dart can infer them.

```dart
final ESPTouchTask task = ESPTouchTask(
  ssid: 'My WiFi network',
  bssid: 'ab:cd:ef:12:23:34',
  password: 'I love Flutter and ESP-Touch, too',
  // Tweak the task using task parameters
  taskParameter: ESPTouchTaskParameter(waitUdpReceiving: Duration(hour: 12)),
);
// You can still stop the task at any point by calling .cancel on the stream subscription:
streamSubscription.cancel();
```

In a real world example, you'd get the WiFi credentials from the user and you could either display the configured device, save it locally in SQLite or send it to your backend. 

## Fundamentals


**Use a real phone for development.** The plugin will not work in emulators and simulators, so you need real phones for development. Run `flutter devices` to verify.

**Prepare your embedded devices.** To verify that the ESP-Touch app works, you need some hardware with ESP8266 and ESP32 to connect to your WiFi network.

### `connectivity`

You may to provide an easy way for getting the current WiFi network's SSID and BSSID. Use the [`connectivity`](https://pub.dev/packages/connectivity) plugin for discovering the state of the network (WiFi & mobile/cellular) connectivity on Android and iOS.

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
[Android](https://github.com/EspressifApp/EsptouchForAndroid) modules had to be heavily customized and
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

## Breaking change in iOS 14.6
Starting with iOS 14.6 the `com.apple.developer.networking.multicast` entitlement is required, to allow the broadcasting of IP packages on iOS, which is used by esptouch.

In order ot enable it, you need to request the entitlemant as an account holder [here](https://developer.apple.com/contact/request/networking-multicast).
Once you are enrolled, you can configure it [here](https://developer.apple.com/forums/thread/663271)
![Screen Shot 2021-06-21 at 17 24 50](https://user-images.githubusercontent.com/50801656/122798220-87f39580-d2ea-11eb-838e-faeeed28fc8e.png)

## Contribute

This is an open-source project built by the [SMAHO Engineering team from Munich](https://smaho.com) to wrap [Espressif](https://github.com/EspressifApp)'s ESP-Touch mobile app kits.

### Flutter

If you are coming from IoT background, you might not know what Flutter is.

[Flutter](https://flutter.io/) is Google's UI toolkit for creating beautiful, native experiences for iOS and Android from a single codebase. For help getting started with Flutter, view the [online documentation](https://flutter.io/docs). 
This repository contains a [Flutter plugin package](https://flutter.io/developing-packages/) for ESP-Touch. A plugin package is a specialized package that includes platform-specific implementation code for Android and iOS. The Flutter portion of the app sends messages to its host (iOS or Android) over a [platform channel](https://flutter.dev/docs/development/platform-integration). This plugin relies on platform channels (event channels) heavily.
