import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Amplify Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyAPI(),
        AmplifyDataStore(),
      ]);
      await Amplify.configure(amplifyconfig);
      print("Amplify configured successfully");
    } catch (e) {
      print("Error configuring Amplify: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Amplify Flutter Demo"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              final result = await Amplify.Auth.signIn(
                username: "your_username",
                password: "your_password",
              );
              if (result.isSignedIn) {
                print("User is signed in!");
              }
            } catch (e) {
              print("SignIn failed: $e");
            }
          },
          child: Text("Sign In"),
        ),
      ),
    );
  }
}
