import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mineat/api/food_service.dart';
import 'package:mineat/api/restaurant_service.dart';
import 'package:mineat/screens/food_details_screen.dart';
import 'package:mineat/screens/forum_screen.dart';
import 'package:mineat/screens/home_screen.dart';
import 'package:mineat/screens/restaurant_screen.dart';

class MainScreen extends StatefulWidget {
  final bool isLoggedIn;
  final bool isAdmin;
  final String username;
  const MainScreen(
      {super.key,
      required this.username,
      this.isLoggedIn = false,
      this.isAdmin = false});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> allFood = [];
  List<Map<String, dynamic>> allRestaurant = [];

  late List<String> allTitles;
  late List<String> allImageUrls;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchData();
    fetchRestaurantData();
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
        isLoading = false;
      });
    } else {
      isLoading = false;
    }
  }

  Future<void> fetchRestaurantData() async {
    await RestaurantService.fetchRestaurantData();

    final restaurants = RestaurantService.getRestaurantData();

    if (restaurants!.isNotEmpty) {
      setState(() {
        allRestaurant = restaurants;
        isLoading = false;
      });
    } else {
      print('Error: Restaurant data is null or not found');
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget _getScreen(int index) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (index == 0) {
      return HomeScreen(
        isLoggedIn: widget.isLoggedIn,
        username: widget.username,
        allFood: allFood,
        allRestaurant: allRestaurant,
      );
    } else if (index == 1) {
      return RestaurantScreen(
        isLoggedIn: widget.isLoggedIn,
        username: widget.username,
        allRestaurant: allRestaurant,
        allFood: allFood,
      );
    } else if (index == 2) {
      return ForumScreen(
        isLoggedIn: widget.isLoggedIn,
        username: widget.username,
        allFood: allFood,
      );
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
