import 'dart:convert';
import 'package:http/http.dart' as http;
class ReviewService {
  static List<Map<String, dynamic>>? _reviewData;
  static Future<void> fetchReviewData(String id) async {
    if (_reviewData != null) return;
    final url = 'http://10.0.2.2:8000/review/$id/json/';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> responseData = json.decode(response.body);
        _reviewData = responseData.map((item) {
          return {
            'reviewer': item['user'],
            'rating': item['rating'],
            'content': item['text'],
            'timeAgo': item['time_created'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load review data');
      }
    } catch (error) {
      print('Error fetching review data: $error');
    }
  }
  static List<Map<String, dynamic>>? getReviewData() {
    return _reviewData;
  }
  static void clearReviewData() {
    _reviewData = null;
  }
}