import 'dart:convert';
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

  static List<Map<String, dynamic>>? getFoodData() {
    return _foodData;
  }

  static void clearFoodData() {
    _foodData = null;
  }
}
