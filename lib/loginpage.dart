import 'package:flutter/material.dart';
import 'package:newprojecttodo/firstpage.dart';
import 'package:newprojecttodo/taskprovider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    String hardcodedUsername = "jithi";
    String hardcodedPassword = "jithi@123";

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), label: Text("Username")),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            child: TextField(
              obscureText: passwordVisible,
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                label: Text("Password"),
                alignLabelWithHint: false,
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: MaterialButton(
              color: Color.fromARGB(255, 29, 89, 43),
              onPressed: () async {
                if (hardcodedUsername == usernameController.text &&
                    hardcodedPassword == passwordController.text) {
                  await storingDatatoPreff(true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Firstpage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    content: Row(
                      children: const [
                        Icon(Icons.warning),
                        Text("Invalid Credentials !"),
                      ],
                    ),
                  ));
                }
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              height: 55,
              minWidth: 210,
            ),
          ),
        ],
      ),
    );
  }
}
