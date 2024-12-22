import 'package:flutter/material.dart';
import 'package:mineat/screens/food_details_screen.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  final List<Map<String, dynamic>> foodsInTheRestaurant;
  final List<Map<String, dynamic>> restaurantAvailable;
  final bool heroOrNot;
  final String username;
  const RestaurantDetailsScreen({
    required this.item,
    required this.heroOrNot,
    required this.foodsInTheRestaurant,
    required this.restaurantAvailable,
    required this.username,
    super.key,
  });

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;
  bool _showAll = false;

  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 500 && !_showAppBarTitle) {
        setState(() {
          _showAppBarTitle = true;
        });
      } else if (_scrollController.offset <= 500 && _showAppBarTitle) {
        setState(() {
          _showAppBarTitle = false;
        });
      }
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.item['foodsInTheRestaurant']);
    print(widget.item["title"]);
    final int itemsToShow =
        _showAll ? widget.item['foodsInTheRestaurant']?.length ?? 0 : 1 * 2;
    return Hero(
      tag: widget.heroOrNot ? widget.item['title'] : "None",
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new, // Use a custom arrow icon
                  color: _showAppBarTitle
                      ? Colors.black
                      : Colors.white, // Customize the color
                ),
                onPressed: () {
                  Navigator.pop(
                      context); // Navigate back to the previous screen
                },
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.6,
              floating: false,
              pinned: true,
              title: _showAppBarTitle
                  ? Text(
                      widget.item['title'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
              actions: [],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.item['imageUrl']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
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
                      bottom: 16,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.item['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.item['district'],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.item['address'],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Positioned(
                    //   top: 40,
                    //   left: 20,
                    //   child: AnimatedOpacity(
                    //     duration: Duration(milliseconds: 300),
                    //     opacity: _showAppBarTitle ? 0.0 : 1.0,
                    //     child: RichText(
                    //       text: const TextSpan(
                    //         style: TextStyle(
                    //           fontSize: 40,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //         children: [
                    //           TextSpan(
                    //             text: 'Min',
                    //             style: TextStyle(
                    //                 color: Color(0xffbb0000),
                    //                 fontSize: 40), // Red color
                    //           ),
                    //           TextSpan(
                    //             text: 'eat',
                    //             style: TextStyle(
                    //                 color: Color(0xffffd700),
                    //                 fontSize: 40), // Gold color
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      top: 40,
                      right: 20,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: _showAppBarTitle ? 0.0 : 1.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            // Add navigation or functionality for the profile button here
                            print("Profile icon tapped");
                          },
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 40,
                    //   left: 20,
                    //   child: IconButton(
                    //     icon: Icon(
                    //       Icons.arrow_back_ios,
                    //       color: Colors.grey.shade300,
                    //       size: 30,
                    //     ),
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'This is a detailed description of the dish. '
                                'Ayam Balado is a traditional Indonesian dish made with chicken and spicy chili sauce. '
                                'It is known for its bold and rich flavors, perfect for those who enjoy spicy foods. '
                                'Served with rice, this dish is popular across Indonesia and loved by many.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Text(
                                  'Foods Available',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 3 / 2,
                                  ),
                                  itemCount: itemsToShow
                                      .clamp(
                                        0,
                                        widget.item['foodsInTheRestaurant']?.length ?? 0
                                      )
                                      .toInt(),
                                  itemBuilder: (context, index) {
                                    final item =
                                        widget.item['foodsInTheRestaurant'];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FoodDetailsScreen(
                                              foodsInTheRestaurant:
                                                  widget.item['foodsInTheRestaurant'],
                                              restaurantAvailable:
                                                  widget.restaurantAvailable,
                                              heroOrNot: true,
                                              item: item,
                                              username: widget.username,
                                              allFood: [],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(item['imageUrl']!),
                                            fit: BoxFit.cover,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color:
                                                  Theme.of(context).shadowColor,
                                              offset: const Offset(6, 6),
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          alignment: Alignment.bottomLeft,
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.6),
                                                Colors.transparent,
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          child: Text(
                                            item['title']!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 5),
                              if (widget.item['foodsInTheRestaurant']
                                      ?.length ?? 0 >
                                  4) // Only show button if needed
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Center the button horizontally
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _showAll = !_showAll;
                                        });
                                      },
                                      child: Text(
                                          _showAll ? 'Show Less' : 'Show More',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey.shade800)),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
