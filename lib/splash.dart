import 'package:flutter/material.dart';
import 'package:newprojecttodo/firstpage.dart';
import 'package:newprojecttodo/loginpage.dart';
import 'package:newprojecttodo/taskprovider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNext();
  }

  void moveToNext() async {
    await Future.delayed(Duration(seconds: 2));
    final bool isloggedin = await gettingBoolData();
    if (isloggedin) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Firstpage(),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("TODO LIST APPLICATION",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 50,
                    color: Color.fromARGB(255, 43, 90, 47),
                  )),
            )
          ],
        ),
      ]),
    );
  }
}
