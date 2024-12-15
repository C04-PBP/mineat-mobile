import 'dart:convert';
import 'package:http/http.dart' as http;

class RestaurantService {
  static List<Map<String, dynamic>>? _restaurantData;

  static Future<void> fetchRestaurantData() async {
    if (_restaurantData != null) return;

    final url = 'http://10.0.2.2:8000/restaurant/json/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> responseData = json.decode(response.body);

        _restaurantData = responseData.map((item) {
          return {
            'title': item['title'],
            "address": item['address'],
            "district": item['district'],
            "imageUrl": item['imageUrl']
          };
        }).toList();
      } else {
        throw Exception('Failed to load restaurant data');
      }
    } catch (error) {
      print('Error fetching restaurant data: $error');
    }
  }

  static List<Map<String, dynamic>>? getRestaurantData() {
    return _restaurantData;
  }

  static void clearRestaurantData() {
    _restaurantData = null;
  }
}


// cara make:

// import 'package:mineat/api/restaurant_service.dart';

// List<Map<String, dynamic>> allRestaurant = [];

// bool isLoading = true;

// @override
//   void initState() {
//     super.initState();

//     fetchData();
//   }

// Future<void> fetchData() async {
//     await RestaurantService.fetchRestaurantData();

//     final restaurants = RestaurantService.getRestaurantData();

//     if (restaurants!.isNotEmpty) {
//       setState(() {
//         allRestaurant = restaurants;
//         isLoading = false;
//       });
//     } else {
//       print('Error: Restaurant data is null or not found');
//     }
//   }

// Masukkan ke bagian manggil data

// if (isLoading) {
      //   return const Center(child: CircularProgressIndicator());
      // }