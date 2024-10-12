import 'package:api_calling/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elevated Button Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
            print('Button Pressed');
          },
          child: Text('Press Me'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            elevation: 5, // Shadow effect
          ),
        ),
      ),
    );
  }
}