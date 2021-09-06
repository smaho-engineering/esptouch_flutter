## 1.0.0

* Migrate package to Dart's null safety language feature, requiring Dart 2.12 or higher. Close [`esptouch_flutter #17`](https://github.com/smaho-engineering/esptouch_flutter/issues/17).
* Add `const` constructor to `ESPTouchTaskParameter`, and make all fields final. In case you relied on the task parameter fields being mutable, use the `copyWith` method on the `ESPTouchTaskParameter`. 
* Add `const` constructor to `ESPTouchResult`.
* Update example app to null safety and remove anything deprecated. Simplify example app (no private, only one file, etc...).

## 0.2.4

Remove deprecated pubspec keys.
README and example app improvements about stopping the ESP scan in 0.2.4+1.

## 0.2.3

Reduce noisy logging

## 0.2.2

Remove EspTouchDemo-Info.plist. No idea why it was there but it breaks my build 🤬
README improvements in 0.2.2+1.

## 0.2.1

README: Add simple example with Kotlin

## 0.2.0

Migrated to AndroidX.

Change compileSdkVersion to 28. Fix [`#3`](https://github.com/smaho-engineering/esptouch_flutter/issues/3): flutter build apk should now work again.


## 0.1.5

Fix podspecs for iOS.

## 0.1.4

Request run-time permissions for location on Android M+ to make BSSID/SSID information work.
Execute event sink methods on the main thread.

## 0.1.3

Add example app screenshots.

## 0.1.2

More docs improvements. Add missing license.

## 0.1.1

Improve documentation.

## 0.1.0

Initial release. Support ESP-Touch on iOS and Android. Fully configurable from your Dart code.
