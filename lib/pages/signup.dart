import 'package:flutter/material.dart';
import 'package:subadmin/pages/splashScreen.dart';

import '../model/signupinput.dart';
import '../services/auth.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _signup() async{
    String username = _usernameController.text;
    String password = _passwordController.text;
    String phoneNumber = _phoneNumberController.text;
    String address = _addressController.text;

    // Perform signup logic here
    
    SignUpInput input = new SignUpInput();
    AuthService auth = AuthService();

    input.name = username;
    input.password = password;
    input.phoneNumber = int.parse(phoneNumber);
    input.address = address;

    await auth.signUpRequest(input).then((value) =>
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                      (route) => false));
    // Optional: Navigate to a different page after signup

    // Clear the text fields
    _usernameController.clear();
    _passwordController.clear();
    _phoneNumberController.clear();
    _addressController.clear();
  }
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
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
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signup,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
