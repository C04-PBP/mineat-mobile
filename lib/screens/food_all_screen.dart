import 'package:flutter/material.dart';
import 'package:mineat/screens/food_details_screen.dart';

class FoodAllScreen extends StatefulWidget {
  final String appBarTitle;
  final List<Map<String, dynamic>> foodItems;

  // Constructor takes a list of food items with title and imageUrl
  const FoodAllScreen(
      {super.key, required this.appBarTitle, required this.foodItems});

  @override
  _FoodAllScreenState createState() => _FoodAllScreenState();
}

class _FoodAllScreenState extends State<FoodAllScreen> {
  List<Map<String, dynamic>> filteredFoodItems = [];

  final List<Map<String, dynamic>> restaurantItems = [
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

  @override
  void initState() {
    super.initState();
    filteredFoodItems = widget.foodItems;
  }

  void _filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredFoodItems = widget.foodItems;
      });
    } else {
      setState(() {
        filteredFoodItems = widget.foodItems
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
          title: Text(
            widget.appBarTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
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
                    hintText: 'Search for a cuisine...',
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
                    mainAxisSpacing: 20, // Space between rows
                    childAspectRatio: 8 /
                        6, // Aspect ratio for each grid item to match your design
                  ),
                  itemCount: filteredFoodItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredFoodItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FoodDetailsScreen(
                              foodsInTheRestaurant: widget.foodItems,
                              heroOrNot: true,
                              item: item,
                              restaurantAvailable: restaurantItems,
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
                          // boxShadow: [
                          //   BoxShadow(
                          //     blurRadius: 4,
                          //     color: Theme.of(context).shadowColor,
                          //     offset: const Offset(6, 6),
                          //   ),
                          // ],
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
