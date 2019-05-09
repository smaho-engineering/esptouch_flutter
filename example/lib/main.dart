import 'dart:async';

import 'package:esptouch/esptouch.dart';
import 'package:esptouch_example/task_parameter_details.dart';
import 'package:esptouch_example/wifi_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

const helperSSID =
    "SSID is the technical term for a network name. When you set up a wireless home network, you give it a name to distinguish it from other networks in your neighbourhood.";
const helperBSSID =
    "BSSID is the MAC address of the wireless access point (router).";
const helperPassword = "The password of the Wi-Fi network";

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ssid = TextEditingController();
  final TextEditingController _bssid = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _expectedTaskResults =
      TextEditingController(); // TODO; is it the same as threshold?
  final TextEditingController _intervalGuideCode = TextEditingController();
  final TextEditingController _intervalDataCode = TextEditingController();
  final TextEditingController _timeoutGuideCode = TextEditingController();
  final TextEditingController _timeoutDataCode = TextEditingController();
  final TextEditingController _repeat = TextEditingController();

  // final TextEditingController _oneLength = TextEditingController();
  // final TextEditingController _macLength = TextEditingController();
  // final TextEditingController _ipLength = TextEditingController();
  final TextEditingController _portListening = TextEditingController();
  final TextEditingController _portTarget = TextEditingController();
  final TextEditingController _waitUdpReceiving = TextEditingController();
  final TextEditingController _waitUdpSending = TextEditingController();
  final TextEditingController _thresholdSucBroadcastCount =
      TextEditingController();
  ESPTouchPacket _packet = ESPTouchPacket.broadcast;

  @override
  void dispose() {
    _ssid.dispose();
    _bssid.dispose();
    _password.dispose();
    _expectedTaskResults.dispose();
    _intervalGuideCode.dispose();
    _intervalDataCode.dispose();
    _timeoutGuideCode.dispose();
    _timeoutDataCode.dispose();
    _repeat.dispose();
    _portListening.dispose();
    _portTarget.dispose();
    _waitUdpReceiving.dispose();
    _waitUdpSending.dispose();
    _thresholdSucBroadcastCount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepOrange,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
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
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: form(context),
          );
        }),
      ),
    );
  }

  bool fetchingWifiInfo = false;

  void fetchWifiInfo() async {
    setState(() {
      fetchingWifiInfo = true;
    });
    try {
      _ssid.text = await ssid;
      _bssid.text = await bssid;
    } finally {
      setState(() {
        fetchingWifiInfo = false;
      });
    }
  }

  createTask() {
    final taskParameter = ESPTouchTaskParameter();
    if (_intervalGuideCode.text.isNotEmpty) {
      taskParameter.intervalGuideCode =
          Duration(milliseconds: int.parse(_intervalGuideCode.text));
    }
    if (_intervalDataCode.text.isNotEmpty) {
      taskParameter.intervalDataCode =
          Duration(milliseconds: int.parse(_intervalDataCode.text));
    }
    if (_timeoutGuideCode.text.isNotEmpty) {
      taskParameter.timeoutGuideCode =
          Duration(milliseconds: int.parse(_timeoutGuideCode.text));
    }
    if (_timeoutDataCode.text.isNotEmpty) {
      taskParameter.timeoutDataCode =
          Duration(milliseconds: int.parse(_timeoutDataCode.text));
    }
    if (_repeat.text.isNotEmpty) {
      taskParameter.repeat = int.parse(_repeat.text);
    }
    if (_portListening.text.isNotEmpty) {
      taskParameter.portListening = int.parse(_portListening.text);
    }
    if (_portTarget.text.isNotEmpty) {
      taskParameter.portTarget = int.parse(_portTarget.text);
    }
    if (_waitUdpSending.text.isNotEmpty) {
      taskParameter.waitUdpSending =
          Duration(milliseconds: int.parse(_waitUdpSending.text));
    }
    if (_waitUdpReceiving.text.isNotEmpty) {
      taskParameter.waitUdpReceiving =
          Duration(milliseconds: int.parse(_waitUdpReceiving.text));
    }
    if (_thresholdSucBroadcastCount.text.isNotEmpty) {
      taskParameter.thresholdSucBroadcastCount =
          int.parse(_thresholdSucBroadcastCount.text);
    }
    if (_expectedTaskResults.text.isNotEmpty) {
      taskParameter.expectedTaskResults = int.parse(_expectedTaskResults.text);
    }

    return ESPTouchTask(
      ssid: _ssid.text,
      bssid: _bssid.text,
      password: _password.text,
      packet: _packet,
      taskParameter: taskParameter,
    );
  }

  Widget form(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          Center(
            child: OutlineButton(
              highlightColor: Colors.transparent,
              highlightedBorderColor: color,
              onPressed: fetchingWifiInfo ? null : fetchWifiInfo,
              child: fetchingWifiInfo
                  ? Text(
                      'Fetching WiFi info',
                      style: TextStyle(color: Colors.grey),
                    )
                  : Text(
                      'Use current Wi-Fi',
                      style: TextStyle(color: color),
                    ),
            ),
          ),
          TextFormField(
            controller: _ssid,
            decoration: const InputDecoration(
              labelText: 'SSID',
              hintText: 'Tony\'s iPhone',
              helperText: helperSSID,
            ),
          ),
          TextFormField(
            controller: _bssid,
            decoration: const InputDecoration(
              labelText: 'BSSID',
              hintText: '00:a0:c9:14:c8:29',
              helperText: helperBSSID,
            ),
          ),
          TextFormField(
            controller: _password,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: r'V3Ry.S4F3-P@$$w0rD',
              helperText: helperPassword,
            ),
          ),
          RadioListTile(
            title: Text('Broadcast'),
            value: ESPTouchPacket.broadcast,
            groupValue: _packet,
            onChanged: setPacket,
            activeColor: color,
          ),
          RadioListTile(
            title: Text('Multicast'),
            value: ESPTouchPacket.multicast,
            groupValue: _packet,
            onChanged: setPacket,
            activeColor: color,
          ),
          TaskParameterDetails(
            color: color,
            expectedTaskResults: _expectedTaskResults,
            intervalGuideCode: _intervalGuideCode,
            intervalDataCode: _intervalDataCode,
            timeoutGuideCode: _timeoutGuideCode,
            timeoutDataCode: _timeoutDataCode,
            repeat: _repeat,
            portListening: _portListening,
            portTarget: _portTarget,
            waitUdpReceiving: _waitUdpReceiving,
            waitUdpSending: _waitUdpSending,
            thresholdSucBroadcastCount: _thresholdSucBroadcastCount,
          ),
          Center(
            child: RaisedButton(
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

  void setPacket(ESPTouchPacket packet) {
    setState(() {
      _packet = packet;
    });
  }
}

class TaskRoute extends StatefulWidget {
  final ESPTouchTask task;

  TaskRoute({this.task});

  @override
  State<StatefulWidget> createState() {
    return TaskRouteState();
  }
}

class TaskRouteState extends State<TaskRoute> {
  Stream<ESPTouchResult> _stream;
  StreamSubscription<ESPTouchResult> _streamSubscription;

  @override
  void initState() {
    _stream = widget.task.execute();
    _streamSubscription = _stream.listen((value) {
      // TODO(smaho): Don't use StreamBuilder and listen in the same example
      print('Received value in TaskRouteState $value');
    });
    super.initState();
  }

  @override
  dispose() {
    _streamSubscription?.cancel();
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
    return Center(
      child: Text(
        s,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  copyValue(BuildContext context, String label, String v) {
    return () {
      Clipboard.setData(ClipboardData(text: v));
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Copied $label to clipboard: $v')));
    };
  }

  Widget noneState(BuildContext context) {
    return Text('None');
  }

  Widget resultList(BuildContext context) {
    return ListView.builder(
      itemCount: _results.length,
      itemBuilder: (_, index) {
        final result = _results.toList(growable: false)[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onLongPress: copyValue(context, 'BSSID', result.bssid),
                child: Row(
                  children: <Widget>[
                    Text('BSSID: ', style: Theme.of(context).textTheme.body2),
                    Text(result.bssid,
                        style: TextStyle(fontFamily: 'monospace')),
                  ],
                ),
              ),
              GestureDetector(
                onLongPress: copyValue(context, 'IP', result.ip),
                child: Row(
                  children: <Widget>[
                    Text('IP: ', style: Theme.of(context).textTheme.body2),
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

  final Set<ESPTouchResult> _results = Set();

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
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                ),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                _results.add(snapshot.data);
                return resultList(context);
              case ConnectionState.none:
                return noneState(context);
              case ConnectionState.done:
                return resultList(context);
              case ConnectionState.waiting:
                return waitingState(context);
            }
          },
          stream: _stream,
        ),
      ),
    );
  }
}
