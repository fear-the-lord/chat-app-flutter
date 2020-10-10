import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  //By making an instance static, we make it class wide and
  // thus we don't need an object of the class to access it.
  // It will be same throughout the class, won't change for any object of the class.
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

// In order to use a ticker, we need to upskill this state class.
class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // In order to create custom animation we need 3 things,
  // A ticker, Animation Controller, Animation Value.

  // Step 1: Create a variable of type animation controller.
  AnimationController controller;
  Animation animation, animation1;

  @override
  void initState() {
    super.initState();

    // We will initialize our animation controller when the state gets created
    controller = AnimationController(
      duration: Duration(seconds: 1),
      // This is the ticker
      // This takes the object of the WelcomeScreenState itself
      vsync: this,
      // Curved animation cannot have an upper bound greater than 1
//      upperBound: 100,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );

    animation1 = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    // This is going to start our animation and proceed it forward
    controller.forward();
    // This will decrease the size of the animation
    // controller.reverse(from: 1.0);
    // checks if an animation is completed or not
//    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        // Do something
//        controller.reverse(from: 1.0);
//      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
//      }
//    });
    controller.addListener(() {
      // The controller value ticks between 0 and 1 in 60 seconds.
      // We can use this value for different purposes
      setState(() {});
//      print(controller.value);
    });
  }

  @override
  void dispose() {
    // Releases memory
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation1.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value * 100,
                  ),
                ),
                TyperAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
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
                    //Go to login screen.
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
                    //Go to registration screen.
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
