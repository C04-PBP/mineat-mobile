import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mineat/api/device.dart';
import 'package:mineat/api/food_service.dart';

class RestaurantService {
  static List<Map<String, dynamic>>? _restaurantData;

  static Future<void> fetchRestaurantData() async {
    if (_restaurantData != null) return;

    final url = '$device/restaurant/json/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> responseData = json.decode(response.body);

        

        _restaurantData = responseData.map((item) {
          final foodsInTheRestaurant =
              FoodService.parseFoodData(item['foodsInTheRestaurant']);

          return {
            'title': item['title'],
            "address": item['address'],
            "district": item['district'],
            "imageUrl": item['imageUrl'],
            "foodsInTheRestaurant": foodsInTheRestaurant
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

  static List<Map<String, dynamic>> parseRestaurantData(
      List<dynamic> restaurant) {
    List<Map<String, dynamic>> restaurantsInTheDistrict =
        restaurant.map((item) {
      List<Map<String, dynamic>>? foodsInTheRestaurant =
          FoodService.parseFoodData(item['foodsInTheRestaurant']);
      return {
        'title': item['title'],
        "address": item['address'],
        "district": item['district'],
        "imageUrl": item['imageUrl'],
        "foodsInTheRestaurant": foodsInTheRestaurant
      };
    }).toList();
    return restaurantsInTheDistrict;
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