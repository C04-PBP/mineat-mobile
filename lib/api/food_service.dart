import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mineat/api/device.dart';

class FoodService {
  static List<Map<String, dynamic>>? _foodData;

  static Future<void> fetchFoodData() async {
    if (_foodData != null) return;

    final url = '$device/fnb/json/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> responseData = json.decode(response.body);

        _foodData = responseData.map((item) {
          String imageUrl = item['imageUrl'];
          String decodedImageUrl = Uri.decodeComponent(imageUrl);
          imageUrl = decodedImageUrl.replaceFirst("/https:", "https:/");

          return {
            'id': item['id'],
            'title': item['title'],
            'price': item['price'],
            'description': item['description'],
            'ingredients': item['ingredients'],
            'imageUrl': imageUrl,
          };
        }).toList();
      } else {
        throw Exception('Failed to load food data');
      }
    } catch (error) {
      print('Error fetching food data: $error');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchFoodData2() async {
    final url = '$device/fnb/json/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> responseData = json.decode(response.body);

        // Transform the JSON data into a list of maps
        final foodData = responseData.map<Map<String, dynamic>>((item) {
          String imageUrl = item['imageUrl'];
          String decodedImageUrl = Uri.decodeComponent(imageUrl);
          imageUrl = decodedImageUrl.replaceFirst("/https:", "https:/");

          return {
            'id': item['id'],
            'title': item['title'],
            'price': item['price'],
            'description': item['description'],
            'ingredients': item['ingredients'],
            'imageUrl': imageUrl,
          };
        }).toList();

        return foodData;
      } else {
        throw Exception('Failed to load food data');
      }
    } catch (error) {
      print('Error fetching food data: $error');
      throw Exception('Error fetching food data');
    }
  }

  static List<Map<String, dynamic>>? getFoodData() {
    return _foodData;
  }

  static void clearFoodData() {
    _foodData = null;
  }

  static Future<bool> deleteFoodData(String id) async {
    try {
      final response =
          await http.delete(Uri.parse("$device/fnb/delete_flutter/$id/"));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static List<Map<String, dynamic>> parseFoodData(List<dynamic> food) {
    List<Map<String, dynamic>> restaurantFood = food.map((item) {
      String imageUrl = item['imageUrl'];
      String decodedImageUrl = Uri.decodeComponent(imageUrl);
      imageUrl = decodedImageUrl.replaceFirst("/https:", "https:/");

      return {
        'id': item['id'],
        'title': item['title'],
        'price': item['price'],
        'description': item['description'],
        'ingredients': item['ingredients'],
        'imageUrl': imageUrl,
      };
    }).toList();
    return restaurantFood;
  }

  static Future<Map<String, dynamic>?> updateFoodData({
    required String id,
    required String name,
    required String description,
    required String price,
    required String imageUrl,
    String? ingredients, // Optional field for ingredients
  }) async {
    final url = Uri.parse(
        '$device/fnb/update_flutter/$id/'); // Update the endpoint as needed

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': name,
          'description': description,
          'price': price,
          'imageUrl': imageUrl,
          'ingredients': ingredients ?? '', // Send an empty string if null
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(
            'Failed to update food data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error updating food data: $e');
      return null;
    }
  }
}
