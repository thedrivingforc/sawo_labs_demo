import 'package:flutter/material.dart';
import 'package:sawo/sawo.dart';

import 'package:sawo_labs_demo/credentials.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Sawo sawo = new Sawo(
    apiKey: Credentials.apiKey,
    secretKey: Credentials.secretKey,
  );
// User Payload
  String user = "";
  void payloadCallback(context, payload) {
    if (payload == null || (payload is String && payload.length == 0)) {
      payload = "Login Failed :(";
    }
    setState(() {
      user = payload;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SAWO Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("UserData :- $user"),
              ElevatedButton(
                onPressed: () {
                  sawo.signIn(
                    context: context,
                    identifierType: 'email',
                    callback: payloadCallback,
                  );
                },
                child: Text('Email Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  sawo.signIn(
                    context: context,
                    identifierType: 'phone_number_sms',
                    callback: payloadCallback,
                  );
                },
                child: Text('Phone Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
