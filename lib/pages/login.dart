import 'package:flutter/material.dart';
import 'package:subadmin/pages/home.dart';
import 'package:subadmin/pages/signup.dart';

import '../const/constant.dart';
import '../model/signupinput.dart';
import '../services/auth.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _login() async {
      String phoneNumber = _phoneNumberController.text;
      String password = _passwordController.text;

      SignUpInput input = new SignUpInput();
      AuthService auth = AuthService();

      input.phoneNumber = int.parse(phoneNumber);
      input.password = password;
      await auth.signInRequest(input).then((value) =>
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false));
      // Optional: Navigate to a different page after login

      // Clear the text fields
      _phoneNumberController.clear();
      _passwordController.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupPage(),
                  ),
                );
              },
              child: Text(
                "Don't have an account? Create an account",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
