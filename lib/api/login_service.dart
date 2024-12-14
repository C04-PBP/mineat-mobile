// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class LoginProvider extends ChangeNotifier {
//   final String loginUrl = 'http://127.0.0.1:8000/fnb/flutter/login/';
//   final String logoutUrl = 'http://127.0.0.1:8000/fnb/flutter/logout/';
  
//   String? _cookies;

//   // Create an instance of FlutterSecureStorage
//   final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

//   String? get cookies => _cookies;

//   // Method to perform login and store cookies
//   Future<void> postLoginData(String username, String password) async {
//     try {
//       Map<String, String> requestBody = {
//         'username': username,
//         'password': password,
//       };

//       final response = await http.post(
//         Uri.parse(loginUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode(requestBody),
//       );

//       if (response.statusCode == 200) {
//         // Extract cookies from Set-Cookie header
//         final cookies = response.headers['set-cookie'];
//         if (cookies != null) {
//           // Store the cookies securely
//           await _secureStorage.write(key: 'cookies', value: cookies);
          
//           // Set cookies in the provider
//           _cookies = cookies;
//           notifyListeners();  // Notify listeners that the state has changed

//           print('Login successful, cookies stored securely.');
//         }
//       } else {
//         throw Exception('Failed to post login data');
//       }
//     } catch (error) {
//       print('Error fetching login: $error');
//     }
//   }

//   // Method to perform logout and clear stored cookies
//   Future<void> logout() async {
//     try {
//       // Send a request to log out from the server
//       final response = await http.post(
//         Uri.parse(logoutUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         print('Logout successful, clearing cookies.');
//       } else {
//         print('Failed to log out from the server');
//       }

//       // Clear cookies from secure storage
//       await _secureStorage.delete(key: 'cookies');

//       // Clear the cookies in the provider
//       _cookies = null;
//       notifyListeners();

//     } catch (error) {
//       print('Error during logout: $error');
//     }
//   }

//   // Method to load cookies when the app starts
//   Future<void> loadCookies() async {
//     try {
//       _cookies = await _secureStorage.read(key: 'cookies');
//       notifyListeners();
//     } catch (error) {
//       print('Error loading cookies: $error');
//     }
//   }

//   // Method to send data with cookies (if available)
//   Future<void> sendDataWithCookies(String data) async {
//     try {
//       if (_cookies != null) {
//         final response = await http.post(
//           Uri.parse('http://your-django-server.com/submit_data'),
//           headers: {
//             'Content-Type': 'application/json',
//             'Cookie': _cookies!,  // Send cookies stored securely
//           },
//           body: json.encode({'data': data}),
//         );

//         if (response.statusCode == 200) {
//           print('Data submitted successfully');
//         } else {
//           print('Failed to submit data');
//         }
//       } else {
//         print('No cookies found');
//       }
//     } catch (error) {
//       print('Error submitting data: $error');
//     }
//   }
// }
