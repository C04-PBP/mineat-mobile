import 'package:flutter/material.dart';
import 'package:mineat/screens/restaurant_details_screen.dart';

class RestaurantAllScreen extends StatefulWidget {
  final List<Map<String, dynamic>> restaurantItems;
  final String username;

  // Constructor takes a list of food items with title and imageUrl
  const RestaurantAllScreen(
      {super.key, required this.restaurantItems, required this.username});

  @override
  _RestaurantAllScreenState createState() => _RestaurantAllScreenState();
}

class _RestaurantAllScreenState extends State<RestaurantAllScreen> {
  List<Map<String, dynamic>> filteredRestaurantItems = [];

  @override
  void initState() {
    super.initState();
    filteredRestaurantItems = widget.restaurantItems;
  }

  void _filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredRestaurantItems = widget.restaurantItems;
      });
    } else {
      setState(() {
        filteredRestaurantItems = widget.restaurantItems
            .where((item) =>
                item['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // Unfocuses the search bar when tapping outside
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Restaurants',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          surfaceTintColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: SizedBox(
                height: 40, // Reducing the height of the search bar
                child: TextField(
                  onChanged: _filterSearchResults,
                  decoration: InputDecoration(
                    hintText: 'Search for a restaurant',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 0, // Space between columns
                    mainAxisSpacing: 20.0, // Space between rows
                    childAspectRatio: 8 / 6,
                  ),
                  itemCount: filteredRestaurantItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredRestaurantItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    RestaurantDetailsScreen(
                              restaurantAvailable: widget.restaurantItems,
                              username: widget.username,
                              foodsInTheRestaurant: [],
                              heroOrNot: true,
                              item: item,
                              username: widget.username,
                            ),
                            transitionDuration: const Duration(
                                milliseconds: 300), // Optional for smoothness
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Hero(
                          tag: item['title']!,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(item['imageUrl']!),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Theme.of(context).shadowColor,
                                        offset: const Offset(6, 6),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.8),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title']!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
