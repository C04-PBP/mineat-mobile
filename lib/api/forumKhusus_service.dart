import 'dart:convert';
import 'package:http/http.dart' as http;

class ForumKhususService {
  static List<Map<String, dynamic>>? _forumKhususData;

  static Future<void> fetchForumKhususData(int id) async {
    if (_forumKhususData != null) return;

    final url = 'http://10.0.2.2:8000/forum/$id/json/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> responseData = json.decode(response.body);

        _forumKhususData = responseData.map((item) {
          return {
            'title': item['title'],
            'imageUrl': item['imageUrl'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load forumKhusus data');
      }
    } catch (error) {
      print('Error fetching forumKhusus data: $error');
    }
  }

  static List<Map<String, dynamic>>? getForumKhususData() {
    return _forumKhususData;
  }

  static void clearForumKhususData() {
    _forumKhususData = null;
  }
}


// cara make:

// import 'package:mineat/api/forumKhusus_service.dart';

// List<Map<String, dynamic>> allForumKhusus = [];

// bool isLoading = true;

// @override
//   void initState() {
//     super.initState();

//     fetchData();
//   }

// Future<void> fetchData() async {
//     await ForumKhususService.fetchForumKhususData();

//     final forumKhususs = ForumKhususService.getForumKhususData();

//     if (forumKhususs!.isNotEmpty) {
//       setState(() {
//         allForumKhusus = forumKhususs;
//         isLoading = false;
//       });
//     } else {
//       print('Error: ForumKhusus data is null or not found');
//     }
//   }

// Masukkan ke bagian manggil data

// if (isLoading) {
      //   return const Center(child: CircularProgressIndicator());
      // }