import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mineat/api/device.dart';

class LocationService {
  static List<Map<String, dynamic>>? _locationData;

  static Future<void> fetchLocationData() async {
    if (_locationData != null) return;

    final url = '$device/location/json/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final List<dynamic> responseData = json.decode(response.body);

        _locationData = responseData.map((item) {
          return {
            'title': item['title'],
            'imageUrl': item['imageUrl'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load location data');
      }
    } catch (error) {
      print('Error fetching location data: $error');
    }
  }

  static List<Map<String, dynamic>>? getLocationData() {
    return _locationData;
  }

  static void clearLocationData() {
    _locationData = null;
  }
}

// cara make:

// import 'package:mineat/api/location_service.dart';

// List<Map<String, dynamic>> allLocation = [];

// bool isLoading = true;

// @override
//   void initState() {
//     super.initState();

//     fetchData();
//   }

// Future<void> fetchData() async {
//     await LocationService.fetchLocationData();

//     final locations = LocationService.getLocationData();

//     if (locations!.isNotEmpty) {
//       setState(() {
//         allLocation = locations;
//         isLoading = false;
//       });
//     } else {
//       print('Error: Location data is null or not found');
//     }
//   }

// Masukkan ke bagian manggil data

// if (isLoading) {
      //   return const Center(child: CircularProgressIndicator());
      // }