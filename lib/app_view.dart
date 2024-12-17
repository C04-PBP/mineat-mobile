import 'package:flutter/material.dart';
import 'package:mineat/screens/main_screen.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Mineat",
        theme: ThemeData(
          colorScheme: ColorScheme.light(
              surface: Colors.grey.shade100,
              onSurface: Colors.black,
              primary: Color(0xffbb0000),
              secondary: Color(0xffffd700)),
          shadowColor: Colors.grey.shade300,
          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.dark(
              surface: const Color.fromARGB(255, 25, 25, 25),
              onSurface: Colors.grey.shade100,
              primary: Color(0xffbb0000),
              secondary: Color(0xffffd700)),
          shadowColor: Colors.black,
          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black),
        ),
        home: MainScreen(username: "None",),
      ),
    );
  }
}
