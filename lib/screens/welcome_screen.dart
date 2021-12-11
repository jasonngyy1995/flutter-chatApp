import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

// with SingleTicker.. => enable the class's state to act as a singleTicketProvider
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  // Animation needs 3 elements -> 1. Ticker, 2. Animation Controller, 3. Animation value
  AnimationController controller;
  Animation animation;

  @override
  // when state created
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      // provide TickerProvider
      // this => current state object will provide
      vsync: this,
    );
    
    animation = ColorTween(begin: Colors.white, end: Colors.blueAccent).animate(controller);

    // proceed animation forward
    // from 0 to 1
    controller.forward();

    controller.addListener(() {
      setState(() {});
      //print(animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                // begin appearance of hero animation
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    // to use curve, upperBound can't be more than 1.0, to increase the size of logo, multiply it by 100
                      // height: animation.value * 100,
                    height: 60.0,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// EXAMPLE
// animation = CurvedAnimation(parent: controller, curve: Curves.ease);
//
// // callback
// animation.addStatusListener((status) {
// if (status == AnimationStatus.completed) {
// controller.reverse(from: 1.0);
// // because once reverse() finished -> AnimationStatus.dismissed
// } else if (status == AnimationStatus.dismissed) {
// controller.forward();
// }
// });