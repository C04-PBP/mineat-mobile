import 'dart:convert';
import 'package:http/http.dart' as http;

class forumUmumService {
  static List<Map<String, dynamic>>? _forumUmumData;

  static Future<void> fetchforumUmumData() async {
    if (_forumUmumData != null) return;

    final url = 'http://127.0.0.1:8000/forum/json/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> responseData = json.decode(response.body);

        _forumUmumData = responseData.map((item) {
          return {
            'title': item['title'],
            'imageUrl': item['imageUrl'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load forumUmum data');
      }
    } catch (error) {
      print('Error fetching forumUmum data: $error');
    }
  }

  static List<Map<String, dynamic>>? getforumUmumData() {
    return _forumUmumData;
  }

  static void clearforumUmumData() {
    _forumUmumData = null;
  }
}


// cara make:

// import 'package:mineat/api/forumUmum_service.dart';

// List<Map<String, dynamic>> allForumUmum = [];

// bool isLoading = true;

// @override
//   void initState() {
//     super.initState();

//     fetchData();
//   }

// Future<void> fetchData() async {
//     await ForumUmumService.fetchForumUmumData();

//     final forumUmums = ForumUmumService.getForumUmumData();

//     if (forumUmums!.isNotEmpty) {
//       setState(() {
//         allForumUmum = forumUmums;
//         isLoading = false;
//       });
//     } else {
//       print('Error: ForumUmum data is null or not found');
//     }
//   }

// Masukkan ke bagian manggil data

// if (isLoading) {
      //   return const Center(child: CircularProgressIndicator());
      // }
