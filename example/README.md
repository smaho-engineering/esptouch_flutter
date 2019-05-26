# Examples for using the `esptouch_flutter` plugin

The example demonstrates how to use the [`esptouch_flutter`](https://pub.dev/packages/esptouch_flutter) plugin.
You can read the full source code on GitHub: [`example` folder](https://github.com/smaho-engineering/esptouch_flutter/tree/master/example) in the repository.

The example app lets you configure

* WiFi SSID (WiFi name)
* WiFi BSSID (MAC of the wireless access point)
* Password
* Duration of the task
* Expected task count
* ... many more.

You can use current network SSID/BSSID or enter it manually (getting wifi info is restricted on the platforms, so sometimes it's necessary to enter them manually).

You can run the example app by:

```
flutter packages get
cd example
flutter run
```

### Screenshots

When you run the example app, this is more or less what you should expect:


#### Simple config

Set WiFi details, such as name, address and password. All fields are editable.

![Simple Configuration](https://github.com/smaho-engineering/esptouch_flutter/raw/master/example/screenshots/simple_config.png)


#### Advanced config

You can configure all task parameters right from your Flutter app. This level of configurability is not even supported in the official example apps.

![Advanced Configuration](https://github.com/smaho-engineering/esptouch_flutter/raw/master/example/screenshots/advanced_config.png)


### Code snippets

In the code example, I specify the types for clarity. You can omit them as Dart can infer them.

```dart
import 'package:esptouch_flutter/esptouch_flutter.dart';

// Somewhere in your widget...
final ESPTouchTask task = ESPTouchTask(
  ssid: 'My WiFi network',
  bssid: 'ab:cd:ef:12:23:34',
  password: 'I love SMAHO',
);
final Stream<ESPTouchResult> stream = task.execute();
StreamSubscription<ESPTouchResult> streamSubscription = stream.listen((ESPTouchResult result) {
  print('Configured IP: ${result.ip} MAC: ${result.bssid}');
});
// Don't forget to cancel your stream subscription:
streamSubscription.cancel();
```

If you would like to customize the task, provide `ESPTouchTaskParameter` instance as `taskParameter` to `ESPTouchTask`.

```dart
final ESPTouchTask task = ESPTouchTask(
  ssid: 'My WiFi network',
  bssid: 'ab:cd:ef:12:23:34',
  password: 'The esptouch flutter plugin is awesome',
  taskParameter: ESPTouchTaskParameter(waitUdpReceiving: Duration(hour: 12)),
);
// You can still stop the task at any point by calling .cancel on the stream subscription:
streamSubscription.cancel();
```

In a real world example, you could display the result to the user, save it locally in SQLite or send it to your backend.

## Getting Started

This project is a starting point for a Flutter application using the `esptouch_flutter` plugin.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.io/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
