import 'package:audioplayers/audio_cache.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({this.payload, this.scheduleNotification});

  final String payload;
  final Function scheduleNotification;

  @override
  State<StatefulWidget> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  String _payload;
  SharedPreferences prefs;

  setPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    setPref();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: CircularCountDownTimer(
              duration: 30,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.purple.shade100,
              fillColor: Colors.deepPurple,
              strokeWidth: 5.0,
              countdownTextStyle: TextStyle(
                  fontSize: 60.0,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
              reverseOrder: true,
              onCountDownComplete: () {
                final player = AudioCache();
                player.play('note1.wav');
                widget.scheduleNotification(
                    interval: int.parse(prefs.getString('interval')),
                    title: 'Handwash Reminder',
                    body:
                        "${prefs.getString('name')} it's time to wash your hands");

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondRoute(),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset('images/Splash Screen.png'),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 30.0),
//              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 150.0),
              child: Text(
                'Well done! \n Your hands must be squeaky clean.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
