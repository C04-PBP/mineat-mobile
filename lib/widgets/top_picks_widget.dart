// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:mineat/screens/food_details_screen.dart';
import 'package:mineat/screens/restaurant_details_screen.dart';

class TopPicksWidget extends StatefulWidget {
  final PageController pageController;
  final List<Map<String, dynamic>> loopedCardData;
  final String callerScreen;
  final List<Map<String, dynamic>> allFood;
  final List<Map<String, dynamic>> allRestaurant;
  final String username;
  TopPicksWidget({
    super.key,
    required this.pageController,
    required this.loopedCardData,
    required this.callerScreen,
    required this.allFood,
    required this.allRestaurant,
    required this.username,
  });

  @override
  State<TopPicksWidget> createState() => _TopPicksWidgetState();
}

class _TopPicksWidgetState extends State<TopPicksWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 1.9,
      child: PageView.builder(
        controller: widget.pageController,
        itemCount: widget.loopedCardData.length,
        itemBuilder: (context, index) {
          final item = widget.loopedCardData[index];
          if (widget.callerScreen.contains("home")) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FoodDetailsScreen(
                          foodsInTheRestaurant: widget.allFood.sublist(4),
                      heroOrNot: true,
                      item: item,
                      restaurantAvailable: widget.allRestaurant,
                      username: widget.username,
                    ),
                    transitionDuration: const Duration(
                        milliseconds: 300), // Optional for smoothness
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 16, top: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Theme.of(context).shadowColor,
                      offset: const Offset(6, 6),
                    ),
                  ],
                ),
                child: Hero(
                  tag: item['title']!,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Stack(
                      children: [
                        // Image background
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item['imageUrl']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error)
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // Gradient overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.6),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        // Text overlay
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (widget.callerScreen.contains("restaurant")) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        RestaurantDetailsScreen(
                          restaurantAvailable: widget.allRestaurant,
                      foodsInTheRestaurant: widget.allFood,
                      heroOrNot: true,
                      item: item,
                      username: widget.username,
                    ),
                    transitionDuration: const Duration(
                        milliseconds: 300), // Optional for smoothness
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, right: 16, top: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Theme.of(context).shadowColor,
                      offset: const Offset(6, 6),
                    ),
                  ],
                ),
                child: Hero(
                  tag: item['title']!,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Stack(
                      children: [
                        // Image background
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item['imageUrl']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        // Gradient overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.6),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        // Text overlay
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
