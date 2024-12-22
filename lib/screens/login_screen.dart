import 'package:flutter/material.dart';
import 'package:mineat/api/device.dart';
import 'package:mineat/app_view.dart';
import 'package:mineat/mineat.dart';
import 'package:mineat/screens/main_screen.dart';
import 'package:mineat/screens/profile_screen.dart';
import 'package:mineat/screens/register_screen.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends StatelessWidget {
  final String username;
  final bool isLoggedIn;
  const LoginScreen({
    super.key,
    required this.username,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    const bool isAdmin = false;
    final request = context.watch<CookieRequest>();
    final TextEditingController username = TextEditingController();
    final TextEditingController password = TextEditingController();

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
                'Welcome Back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Log in to your account',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 32),
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  var loginData = {
                    "username": username.text,
                    "password": password.text,
                  };
                  final response =
                      await request.login("$device/flutter/login/", loginData);
                  if (request.loggedIn) {
                    String message = response['message'];
                    String uname = response['username'];
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                  username: uname,
                                )),
                      );
                      // ScaffoldMessenger.of(context)
                      //   ..hideCurrentSnackBar()
                      //   ..showSnackBar(
                      //     SnackBar(
                      //         content:
                      //             Text("$message Selamat datang, $uname.")),
                      //   );
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => MainScreen(
                      //             username: uname,
                      //             isLoggedIn: true,
                      //             isAdmin: false,
                      //           )),
                      // );
                      // ScaffoldMessenger.of(context)
                      //   ..hideCurrentSnackBar()
                      //   ..showSnackBar(
                      //     SnackBar(
                      //         content:
                      //             Text("$message Selamat datang, $uname.")),
                      //   );
                    }
                  } else {
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Login Gagal'),
                          content: Text(response['message']),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    'Don’t have an account? Register',
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
