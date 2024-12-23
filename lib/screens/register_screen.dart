import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mineat/api/device.dart';
import 'package:mineat/screens/login_screen.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController username = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController passwordConfirm = TextEditingController();

    final request = context.watch<CookieRequest>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey.shade200,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Sign up to get started',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(-7, -7),
                      blurRadius: 8,
                      spreadRadius: -5,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(7, 7),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(-7, -7),
                      blurRadius: 8,
                      spreadRadius: -5,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(7, 7),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(-7, -7),
                      blurRadius: 8,
                      spreadRadius: -5,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(7, 7),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: passwordConfirm,
                    decoration: InputDecoration(
                      labelText: 'Password Confirmation',
                      border: InputBorder.none,
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  final response = await request.postJson(
                      "$device/flutter/register/",
                      jsonEncode({
                        "username": username.text,
                        "password1": password.text,
                        "password2": passwordConfirm.text,
                      }));
                  if (context.mounted) {
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Successfully registered!'),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen(
                                  username: "None",
                                  isLoggedIn: false,
                                )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Failed to register!'),
                        ),
                      );
                    }
                  }
                  // Handle registration action
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(7, 7),
                        blurRadius: 8,
                        spreadRadius: -5,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(-7, -7),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Already have an account? Log In',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
