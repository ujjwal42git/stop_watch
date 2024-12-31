import 'package:flutter/material.dart';
import 'dart:async'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StopWatch(),
    );
  }
}

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int _seconds = 0;
  bool _isRunning = false;
  late Timer _timer;

  void _startStopWatch() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopStopWatch() {
    _timer.cancel();
  }

  void _resetStopWatch() {
    _timer.cancel();
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _seconds ~/ 60;
    int remainingSeconds = _seconds % 60;

    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$minutes:${remainingSeconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_isRunning) {
                        _stopStopWatch();
                      } else {
                        _startStopWatch();
                      }
                      _isRunning = !_isRunning;
                    });
                  },
                  child: Text(_isRunning ? 'Stop' : 'Start'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopWatch,
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
