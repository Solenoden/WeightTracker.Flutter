import 'package:flutter/material.dart';
import 'package:weight_tracker_app/services/authorization_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailAddress = '';
  String password = '';

  void loginUser() {
    final authService = AuthorizationService();
    authService.loginUser(emailAddress, password).then((value) => {
      // TODO: Create logic to navigate to the rest of the application
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Weight Tracker'),
        buildEmailInput(),
        buildPasswordInput(),
        SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(40),
            ),
            onPressed: () => loginUser(),
            child: Text('LOGIN'),
          ),
        )
      ],
    );
  }

  Widget buildEmailInput() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email Address',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => setState(() => emailAddress = value),
        ),
      );

  Widget buildPasswordInput() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
          onChanged: (value) => setState(() => password = value),
        ),
      );
}
