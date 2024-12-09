import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mineat/api/food_service.dart';
import 'package:mineat/screens/food_details_screen.dart';
import 'package:mineat/screens/forum_screen.dart';
import 'package:mineat/screens/home_screen.dart';
import 'package:mineat/screens/restaurant_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> allFood = [];
  final List<Map<String, dynamic>> allRestaurant = [
    {
      "title": "Taman Surya",
      "address": "Jl. Tamansiswa No. 15",
      "district": "Padang Utara",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipMucy2GYqlxcQZpn6g9OzG8CXFFHCZYpduAxKE2=s1360-w1360-h1020"
    },
    {
      "title": "Kubang Hayuda",
      "address": "Jl. Prof. M. Yamin SH No. 138B, Padang",
      "district": "Padang Barat",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipPE1fJpyuCWE2eMPbYKPL5zD-eTKPbvM_MJ6bmD=s680-w680-h510"
    },
    {
      "title": "VII Koto Talago",
      "address": "Jl. Jhoni Anwar No.Kelurahan No.17, Padang",
      "district": "Padang Utara",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipMfCv5oU_RRNSg_BgK9lA9FLaMSABN1CUDTAO0S=s680-w680-h510"
    },
    {
      "title": "Pagi Sore",
      "address": "Jl. Pondok No. 143, Padang",
      "district": "Padang Barat",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipPnRTwAUA2u2RmeR8LBzhCnJypZgAmLF7tC2v3g=s1360-w1360-h1020"
    },
    {
      "title": "Sing A Song",
      "address": "Jl. Perintis Kemerdekaan No. 4C, Padang",
      "district": "Padang Timur",
      "imageUrl":
          "https://lh5.googleusercontent.com/p/AF1QipMyIWWaWJjrU-Kzv0PSXfHT59mmGQlZ5kwmRtKT=w408-h544-k-no"
    },
  ];

  late List<String> allTitles;
  late List<String> allImageUrls;

  @override
  void initState() {
    super.initState();


    fetchData();
  }

  Future<void> fetchData() async {

    await FoodService.fetchFoodData();


    final foods = FoodService.getFoodData();

    if (foods != null) {
      setState(() {
        allFood = foods;


        allTitles = allFood.map((food) => food['title'].toString()).toList();
        allImageUrls =
            allFood.map((food) => food['imageUrl'].toString()).toList();
      });
    } else {
      print('Error: Food data is null or not found');
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getScreen(int index) {
    if (index == 0) {
      return HomeScreen(
        allFood: allFood,
        allRestaurant: allRestaurant,
      );
    } else if (index == 1) {
      return RestaurantScreen(
        allRestaurant: allRestaurant,
        allFood: allFood,
      );
    } else if (index == 2) {
      return ForumScreen(allFood: allFood);
    } else {
      return const Center(child: Text('Unknown screen'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: selectedIndex, // Make highlights for the selected page
          onTap: onItemTapped,
          backgroundColor: Theme.of(context).bottomAppBarTheme.color,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.graph_square_fill),
              label: "Stats",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: "Search",
            ),
          ],
        ),
      ),
      body: _getScreen(selectedIndex),
    );
  }
}
