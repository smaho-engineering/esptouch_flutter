import 'package:flutter/material.dart';

class TaskParameterDetails extends StatelessWidget {
  const TaskParameterDetails({
    Key key,
    @required this.color,
    @required TextEditingController expectedTaskResults,
    @required TextEditingController intervalGuideCode,
    @required TextEditingController intervalDataCode,
    @required TextEditingController timeoutGuideCode,
    @required TextEditingController timeoutDataCode,
    @required TextEditingController repeat,
    @required TextEditingController portListening,
    @required TextEditingController portTarget,
    @required TextEditingController waitUdpReceiving,
    @required TextEditingController waitUdpSending,
    @required TextEditingController thresholdSucBroadcastCount,
  })  : _expectedTaskResults = expectedTaskResults,
        _intervalGuideCode = intervalGuideCode,
        _intervalDataCode = intervalDataCode,
        _timeoutGuideCode = timeoutGuideCode,
        _timeoutDataCode = timeoutDataCode,
        _repeat = repeat,
        _portListening = portListening,
        _portTarget = portTarget,
        _waitUdpReceiving = waitUdpReceiving,
        _waitUdpSending = waitUdpSending,
        _thresholdSucBroadcastCount = thresholdSucBroadcastCount,
        super(key: key);

  final Color color;
  final TextEditingController _expectedTaskResults;
  final TextEditingController _intervalGuideCode;
  final TextEditingController _intervalDataCode;
  final TextEditingController _timeoutGuideCode;
  final TextEditingController _timeoutDataCode;
  final TextEditingController _repeat;
  final TextEditingController _portListening;
  final TextEditingController _portTarget;
  final TextEditingController _waitUdpReceiving;
  final TextEditingController _waitUdpSending;
  final TextEditingController _thresholdSucBroadcastCount;

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
        _OptionalIntegerField(
          controller: _expectedTaskResults,
          labelText: 'Expected task results (count)',
          hintText: 1,
          helperText: 'The number of devices you expect to scan.',
        ),
        _OptionalIntegerField(
          controller: _intervalGuideCode,
          labelText: 'Interval guide code (ms)',
          hintText: 8,
        ),
        _OptionalIntegerField(
          controller: _intervalDataCode,
          labelText: 'Interval data code (ms)',
          hintText: 8,
        ),
        _OptionalIntegerField(
          controller: _timeoutGuideCode,
          labelText: 'Timeout guide code (ms)',
          hintText: 2000,
        ),
        _OptionalIntegerField(
          controller: _timeoutDataCode,
          labelText: 'Timeout data code (ms)',
          hintText: 4000,
        ),
        _OptionalIntegerField(
          controller: _repeat,
          labelText: 'Repeat',
          hintText: 1,
        ),
        // TODO: mac and ip length are skipped for now.
        _OptionalIntegerField(
          controller: _portListening,
          labelText: 'Listen on port',
          hintText: 18266,
        ),
        _OptionalIntegerField(
          controller: _portTarget,
          labelText: 'Target port',
          hintText: 7001,
        ),
        _OptionalIntegerField(
          controller: _waitUdpReceiving,
          labelText: 'Wait UDP receiving (ms)',
          hintText: 15000,
        ),
        _OptionalIntegerField(
          controller: _waitUdpSending,
          labelText: 'Wait UDP sending (ms)',
          hintText: 45000,
        ),
        _OptionalIntegerField(
          controller: _thresholdSucBroadcastCount,
          labelText: 'Broadcast count success threshold',
          hintText: 1,
        ),
      ],
    );
  }
}

class _OptionalIntegerField extends StatelessWidget {
  const _OptionalIntegerField({
    Key key,
    @required this.controller,
    @required this.labelText,
    @required this.hintText,
    this.helperText,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final int hintText;
  final String helperText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: (String value) {
        value = value.trim();
        if (value == '') {
          return null;
        }
        int v = int.tryParse(value, radix: 10);
        if (v == null) {
          return 'Please enter an integer number';
        }
      },
      autovalidate: true,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText.toString(),
        helperText: helperText,
      ),
    );
  }
}
