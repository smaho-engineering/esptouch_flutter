// Usually, I would prefer splitting up an app into smaller files, but as this
// is an example app for a published plugin, it's better to have everything in
// one file so that all of the examples are visible on https://pub.dev/packages/esptouch_flutter/example

import 'dart:async';

import 'package:esptouch_flutter/esptouch_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController ssid = TextEditingController();
  final TextEditingController bssid = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController expectedTaskResults = TextEditingController();
  final TextEditingController intervalGuideCode = TextEditingController();
  final TextEditingController intervalDataCode = TextEditingController();
  final TextEditingController timeoutGuideCode = TextEditingController();
  final TextEditingController timeoutDataCode = TextEditingController();
  final TextEditingController repeat = TextEditingController();
  final TextEditingController portListening = TextEditingController();
  final TextEditingController portTarget = TextEditingController();
  final TextEditingController waitUdpReceiving = TextEditingController();
  final TextEditingController waitUdpSending = TextEditingController();
  final TextEditingController thresholdSucBroadcastCount =
      TextEditingController();
  ESPTouchPacket packet = ESPTouchPacket.broadcast;

  @override
  void dispose() {
    ssid.dispose();
    bssid.dispose();
    password.dispose();
    expectedTaskResults.dispose();
    intervalGuideCode.dispose();
    intervalDataCode.dispose();
    timeoutGuideCode.dispose();
    timeoutDataCode.dispose();
    repeat.dispose();
    portListening.dispose();
    portTarget.dispose();
    waitUdpReceiving.dispose();
    waitUdpSending.dispose();
    thresholdSucBroadcastCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'ESP-TOUCH',
            style: TextStyle(
              fontFamily: 'serif-monospace',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        // Using builder to get context without creating new widgets
        //  https://docs.flutter.io/flutter/material/Scaffold/of.html
        body: Builder(builder: (context) => Center(child: form(context))),
      ),
    );
  }

  bool fetchingWifiInfo = false;

  void fetchWifiInfo() async {
    setState(() => fetchingWifiInfo = true);
    try {
      ssid.text = await SimpleWifiInfo.ssid ?? '';
      bssid.text = await SimpleWifiInfo.bssid ?? '';
    } finally {
      setState(() => fetchingWifiInfo = false);
    }
  }

  createTask() {
    Duration? durationTryParse(String milliseconds) {
      final parsed = int.tryParse(milliseconds);
      return parsed != null ? Duration(milliseconds: parsed) : null;
    }

    return ESPTouchTask(
      ssid: ssid.text,
      bssid: bssid.text,
      password: password.text,
      packet: packet,
      taskParameter: ESPTouchTaskParameter().copyWith(
        intervalGuideCode: durationTryParse(intervalGuideCode.text),
        intervalDataCode: durationTryParse(intervalDataCode.text),
        timeoutGuideCode: durationTryParse(timeoutGuideCode.text),
        timeoutDataCode: durationTryParse(timeoutDataCode.text),
        waitUdpSending: durationTryParse(waitUdpSending.text),
        waitUdpReceiving: durationTryParse(waitUdpReceiving.text),
        repeat: int.tryParse(repeat.text),
        portListening: int.tryParse(portListening.text),
        portTarget: int.tryParse(portTarget.text),
        thresholdSucBroadcastCount:
            int.tryParse(thresholdSucBroadcastCount.text),
        expectedTaskResults: int.tryParse(expectedTaskResults.text),
      ),
    );
  }

  Widget form(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          Center(
            child: OutlinedButton(
              onPressed: fetchingWifiInfo ? null : fetchWifiInfo,
              child: Text(
                fetchingWifiInfo ? 'Fetching WiFi info' : 'Use current Wi-Fi',
              ),
            ),
          ),
          TextFormField(
            controller: ssid,
            decoration: const InputDecoration(
              labelText: 'SSID',
              hintText: 'Tony\'s iPhone',
              helperText: helperSSID,
            ),
          ),
          TextFormField(
            controller: bssid,
            decoration: const InputDecoration(
              labelText: 'BSSID',
              hintText: '00:a0:c9:14:c8:29',
              helperText: helperBSSID,
            ),
          ),
          TextFormField(
            controller: password,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: r'V3Ry.S4F3-P@$$w0rD',
              helperText: helperPassword,
            ),
          ),
          RadioListTile(
            title: Text('Broadcast'),
            value: ESPTouchPacket.broadcast,
            groupValue: packet,
            onChanged: setPacket,
            activeColor: color,
          ),
          RadioListTile(
            title: Text('Multicast'),
            value: ESPTouchPacket.multicast,
            groupValue: packet,
            onChanged: setPacket,
            activeColor: color,
          ),
          TaskParameterDetails(
            color: color,
            expectedTaskResults: expectedTaskResults,
            intervalGuideCode: intervalGuideCode,
            intervalDataCode: intervalDataCode,
            timeoutGuideCode: timeoutGuideCode,
            timeoutDataCode: timeoutDataCode,
            repeat: repeat,
            portListening: portListening,
            portTarget: portTarget,
            waitUdpReceiving: waitUdpReceiving,
            waitUdpSending: waitUdpSending,
            thresholdSucBroadcastCount: thresholdSucBroadcastCount,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskRoute(task: createTask()),
                  ),
                );
              },
              child: const Text('Execute'),
            ),
          ),
        ],
      ),
    );
  }

  void setPacket(ESPTouchPacket? packet) {
    if (packet == null) return;
    setState(() {
      this.packet = packet;
    });
  }
}

class TaskRoute extends StatefulWidget {
  TaskRoute({required this.task});

  final ESPTouchTask task;

  @override
  State<StatefulWidget> createState() => TaskRouteState();
}

class TaskRouteState extends State<TaskRoute> {
  late final Stream<ESPTouchResult> stream;
  late final StreamSubscription<ESPTouchResult> streamSubscription;
  late final Timer timer;

  final List<ESPTouchResult> results = [];

  @override
  void initState() {
    stream = widget.task.execute();
    streamSubscription = stream.listen(results.add);
    final receiving = widget.task.taskParameter.waitUdpReceiving;
    final sending = widget.task.taskParameter.waitUdpSending;
    final cancelLatestAfter = receiving + sending;
    timer = Timer(
      cancelLatestAfter,
      () {
        streamSubscription.cancel();
        if (results.isEmpty && mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('No devices found'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context)..pop()..pop(),
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
    super.initState();
  }

  @override
  dispose() {
    timer.cancel();
    streamSubscription.cancel();
    super.dispose();
  }

  Widget waitingState(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ),
          SizedBox(height: 16),
          Text('Waiting for results'),
        ],
      ),
    );
  }

  Widget error(BuildContext context, String s) {
    return Center(child: Text(s, style: TextStyle(color: Colors.red)));
  }

  copyValue(BuildContext context, String label, String v) {
    return () {
      Clipboard.setData(ClipboardData(text: v));
      final snackBar = SnackBar(content: Text('Copied $label to clipboard $v'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    };
  }

  Widget noneState(BuildContext context) {
    return Text('None');
  }

  Widget resultList(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, index) {
        final result = results[index];
        final textTheme = Theme.of(context).textTheme;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onLongPress: copyValue(context, 'BSSID', result.bssid),
                child: Row(
                  children: <Widget>[
                    Text('BSSID: ', style: textTheme.bodyText1),
                    Text(result.bssid,
                        style: TextStyle(fontFamily: 'monospace')),
                  ],
                ),
              ),
              GestureDetector(
                onLongPress: copyValue(context, 'IP', result.ip),
                child: Row(
                  children: <Widget>[
                    Text('IP: ', style: textTheme.bodyText1),
                    Text(result.ip, style: TextStyle(fontFamily: 'monospace')),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task'),
      ),
      body: Container(
        child: StreamBuilder<ESPTouchResult>(
          builder: (context, AsyncSnapshot<ESPTouchResult> snapshot) {
            if (snapshot.hasError) {
              return error(context, 'Error in StreamBuilder');
            }
            if (!snapshot.hasData) {
              final primaryColor = Theme.of(context).primaryColor;
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                ),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                return resultList(context);
              case ConnectionState.none:
                return noneState(context);
              case ConnectionState.done:
                return resultList(context);
              case ConnectionState.waiting:
                return waitingState(context);
            }
          },
          stream: stream,
        ),
      ),
    );
  }
}

class TaskParameterDetails extends StatelessWidget {
  const TaskParameterDetails({
    Key? key,
    required this.color,
    required this.expectedTaskResults,
    required this.intervalGuideCode,
    required this.intervalDataCode,
    required this.timeoutGuideCode,
    required this.timeoutDataCode,
    required this.repeat,
    required this.portListening,
    required this.portTarget,
    required this.waitUdpReceiving,
    required this.waitUdpSending,
    required this.thresholdSucBroadcastCount,
  }) : super(key: key);

  final Color color;
  final TextEditingController expectedTaskResults;
  final TextEditingController intervalGuideCode;
  final TextEditingController intervalDataCode;
  final TextEditingController timeoutGuideCode;
  final TextEditingController timeoutDataCode;
  final TextEditingController repeat;
  final TextEditingController portListening;
  final TextEditingController portTarget;
  final TextEditingController waitUdpReceiving;
  final TextEditingController waitUdpSending;
  final TextEditingController thresholdSucBroadcastCount;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Task parameter detail',
        style: TextStyle(color: color),
      ),
      trailing: Icon(
        Icons.settings,
        color: color,
      ),
      initiallyExpanded: false,
      children: <Widget>[
        OptionalIntegerTextField(
          controller: expectedTaskResults,
          labelText: 'Expected task results (count)',
          hintText: 1,
          helperText: 'The number of devices you expect to scan.',
        ),
        OptionalIntegerTextField(
          controller: intervalGuideCode,
          labelText: 'Interval guide code (ms)',
          hintText: 8,
        ),
        OptionalIntegerTextField(
          controller: intervalDataCode,
          labelText: 'Interval data code (ms)',
          hintText: 8,
        ),
        OptionalIntegerTextField(
          controller: timeoutGuideCode,
          labelText: 'Timeout guide code (ms)',
          hintText: 2000,
        ),
        OptionalIntegerTextField(
          controller: timeoutDataCode,
          labelText: 'Timeout data code (ms)',
          hintText: 4000,
        ),
        OptionalIntegerTextField(
          controller: repeat,
          labelText: 'Repeat',
          hintText: 1,
        ),
        // The mac and ip length are skipped for now.
        OptionalIntegerTextField(
          controller: portListening,
          labelText: 'Listen on port',
          hintText: 18266,
        ),
        OptionalIntegerTextField(
          controller: portTarget,
          labelText: 'Target port',
          hintText: 7001,
        ),
        OptionalIntegerTextField(
          controller: waitUdpReceiving,
          labelText: 'Wait UDP receiving (ms)',
          hintText: 15000,
        ),
        OptionalIntegerTextField(
          controller: waitUdpSending,
          labelText: 'Wait UDP sending (ms)',
          hintText: 45000,
        ),
        OptionalIntegerTextField(
          controller: thresholdSucBroadcastCount,
          labelText: 'Broadcast count success threshold',
          hintText: 1,
        ),
      ],
    );
  }
}

class OptionalIntegerTextField extends StatelessWidget {
  const OptionalIntegerTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.helperText,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final int hintText;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: (String? value) {
        // The user didn't edit the field, so can return early without an error
        // and skip validating (int parsing).
        value = (value ?? '').trim();
        if (value == '') return null;

        final v = int.tryParse(value, radix: 10);
        if (v == null) return 'Please enter an integer number';
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText.toString(),
        helperText: helperText,
      ),
    );
  }
}

const helperSSID = "SSID is the technical term for a network name. "
    "When you set up a wireless home network, "
    "you give it a name to distinguish it from other networks in your neighbourhood.";
const helperBSSID =
    "BSSID is the MAC address of the wireless access point (router).";
const helperPassword = "The password of the Wi-Fi network";

/// The method channel is used to get the SSID and BSSID.
///
/// For a real app, consider using the
/// [`connectivity`](https://pub.dev/packages/connectivity) and
/// [`wifi_info_flutter`](https://pub.dev/packages/wifi_info_flutter) packages.
///
/// For more info: https://github.com/smaho-engineering/esptouch_flutter/blob/master/example/README.md#get-wifi-details
class SimpleWifiInfo {
  static const platform =
      MethodChannel('eng.smaho.com/esptouch_plugin/example');

  /// Get WiFi SSID using platform channels.
  ///
  /// Can return null if BSSID information is not available.
  static Future<String?> get ssid => platform.invokeMethod('ssid');

  /// Get WiFi BSSID using platform channels.
  ///
  /// Can return null if BSSID information is not available.
  static Future<String?> get bssid => platform.invokeMethod('bssid');
}
