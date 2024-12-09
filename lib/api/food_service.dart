import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodService {
  static List<Map<String, dynamic>>? _foodData;


  static Future<void> fetchFoodData() async {

    if (_foodData != null) return;

    final url = 'http://127.0.0.1:8000/fnb/json/'; 

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> responseData = json.decode(response.body);


        _foodData = responseData.map((item) {
          return {
            'title': item['title'],
            'price': item['price'],
            'description': item['description'],
            'ingredients': item['ingredients'],  
            'imageUrl': item['imageUrl'],
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
