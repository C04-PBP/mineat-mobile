import 'package:flutter/material.dart';
import 'package:mineat/screens/admin_screen.dart';
import 'package:mineat/screens/login_screen.dart';
import 'package:mineat/screens/main_screen.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:mineat/api/device.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  const ProfileScreen({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade400,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                username,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(
                        username: username,
                        isLoggedIn: true,
                        isAdmin: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Theme.of(context).shadowColor,
                        offset: const Offset(6, 6),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/images/ingredients2.png'),
                      fit: BoxFit
                          .cover, // Adjusts the image to cover the container
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors
                            .white, // Ensures text is visible on the background
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: (username == 'admin') ? 30 : 20,
              ),
              if (username == "admin")
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminScreen()));
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
                        'Admin Page',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  final response = await request.logout(
                      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                      "$device/flutter/logout/");
                  String message = response["message"];
                  if (context.mounted) {
                    if (response['status']) {
                      String uname = response["username"];
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$message Sampai jumpa, $uname."),
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainScreen(
                                  username: "None",
                                  isLoggedIn: false,
                                )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    }
                  }
                },
                child: Container(
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
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
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
