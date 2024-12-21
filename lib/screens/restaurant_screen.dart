import 'package:flutter/material.dart';
import 'package:mineat/screens/district_all_screen.dart';
import 'package:mineat/screens/district_details_screen.dart';
import 'package:mineat/screens/food_details_screen.dart';
import 'package:mineat/screens/login_screen.dart';
import 'package:mineat/screens/profile_screen.dart';
import 'package:mineat/screens/restaurant_all_screen.dart';
import 'package:mineat/screens/restaurant_details_screen.dart';
import 'package:mineat/widgets/top_picks_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mineat/api/restaurant_service.dart';
import 'package:mineat/api/location_service.dart';

class RestaurantScreen extends StatefulWidget {
  final String username;
  final bool isLoggedIn;
  final List<Map<String, dynamic>> allRestaurant;
  final List<Map<String, dynamic>> allFood;
  const RestaurantScreen({
    required this.username,
    required this.allRestaurant,
    required this.allFood,
    required this.isLoggedIn,
    super.key,
  });

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final List<Map<String, dynamic>> stackData = [
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
  ];

  final List<Map<String, dynamic>> cardData = [
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
      "title": "Taman Surya",
      "address": "Jl. Tamansiswa No. 15",
      "district": "Padang Utara",
      "imageUrl":
          "https://lh3.googleusercontent.com/p/AF1QipMucy2GYqlxcQZpn6g9OzG8CXFFHCZYpduAxKE2=s1360-w1360-h1020"
    },
  ];

  final List<Map<String, String>> cardDataDistrict = [
    {
      "title": "Padang Utara",
      "imageUrl":
          "https://lh5.googleusercontent.com/p/AF1QipOjtH1F3dIPa_q_CFqrBKr0u03o0CCRSWdyr5kb=w426-h240-k-no"
    },
    {
      "title": "Pauh",
      "imageUrl":
          "https://lh5.googleusercontent.com/p/AF1QipNpQE2jm9yWKsEmqpcPCTYy-HvIWfIPvOJsWTuP=w408-h271-k-no"
    },
    {
      "title": "Bungus Teluk Kabung",
      "imageUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Lubuak_hitam.jpg/375px-Lubuak_hitam.jpg"
    },
  ];

  bool isLoading = true;

  List<Map<String, dynamic>> allDistrict = [];

  List<Map<String, dynamic>> allRestaurant = [];

  late PageController _pageControllerStack;
  late PageController _pageController;
  final PageController _pageControllerDistrict =
      PageController(initialPage: 0, viewportFraction: 0.75);
  late List<Map<String, dynamic>> loopedCardData;
  late List<Map<String, dynamic>> loopedCardDataRestaurant;
  int currentPage = 0;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;
  @override
  void initState() {
    super.initState();

    fetchRestaurantData();
    fetchLocationData();
    _pageControllerStack = PageController();

    // Duplicate items to create a looped effect for Foods
    loopedCardData = [
      cardData.last,
      ...cardData,
      cardData.first,
    ];
    _pageController = PageController(initialPage: 2, viewportFraction: 0.85);
    _pageController.addListener(() {
      if (_pageController.page == loopedCardData.length - 1) {
        _pageController.jumpToPage(1);
      } else if (_pageController.page == 0) {
        _pageController.jumpToPage(loopedCardData.length - 2);
      }
    });

    // Duplicate items to create a looped effect for Restaurants

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

  Future<void> fetchLocationData() async {
    await LocationService.fetchLocationData();

    final locations = LocationService.getLocationData();

    if (locations!.isNotEmpty) {
      setState(() {
        allDistrict = locations;
        isLoading = false;
      });
    } else {
      print('Error: Location data is null or not found');
    }
  }

  @override
  void dispose() {
    _pageControllerStack.removeListener(() {});
    _pageController.removeListener(() {});
    _pageControllerStack.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(controller: _scrollController, slivers: [
      SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.6,
        floating: false,
        pinned: true,
        title: _showAppBarTitle
            ? Text(
                "Restaurant",
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
              PageView.builder(
                onPageChanged: (int index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                controller: _pageControllerStack,
                itemCount: stackData.length,
                itemBuilder: (context, index) {
                  final item = stackData[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  RestaurantDetailsScreen(
                            restaurantAvailable:
                                widget.allRestaurant.sublist(0),
                            foodsInTheRestaurant: widget.allFood
                                .sublist(widget.allFood.length - 10),
                            item: item,
                            heroOrNot: false,
                          ),
                          transitionDuration: const Duration(
                              milliseconds: 300), // Optional for smoothness
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(item['imageUrl']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.50),
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
                          bottom: 50,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  item['title']!,
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
                                  item['district'],
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                bottom:
                    20, // Adjust this value to control how far up the page the indicator appears
                left: 0,
                right: 0,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageControllerStack,
                    count: stackData.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 7,
                      dotWidth: 7,
                      activeDotColor: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _showAppBarTitle ? 0.0 : 1.0,
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Min',
                          style: TextStyle(
                              color: Color(0xffbb0000),
                              fontSize: 40), // Red color
                        ),
                        TextSpan(
                          text: 'eat',
                          style: TextStyle(
                              color: Color(0xffffd700),
                              fontSize: 40), // Gold color
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                      if (widget.isLoggedIn) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                    username: widget.username,
                                  )),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                    username: widget.username,
                                    isLoggedIn: widget.isLoggedIn,
                                  )),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Top Picks",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TopPicksWidget(
                allRestaurant: allRestaurant,
                allFood: widget.allFood.sublist(widget.allFood.length - 5),
                pageController: _pageController,
                loopedCardData: loopedCardData,
                callerScreen: "restaurant",
              ),
              const SizedBox(height: 45),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  RestaurantAllScreen(
                            restaurantItems: allRestaurant,
                          ),
                          transitionDuration: const Duration(
                              milliseconds: 300), // Optional for smoothness
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          "All Restaurants",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 24,
                        ), // Replace with arrow_left for a left arrow
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(height: 35),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DistrictAllScreen(
                            restaurantsInTheDistrict: widget.allRestaurant,
                            districtItems: allDistrict,
                          ),
                          transitionDuration: const Duration(
                              milliseconds: 300), // Optional for smoothness
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Text(
                          "District",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 24,
                        ), // Replace with arrow_left for a left arrow
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.3,
                child: PageView.builder(
                  controller: _pageControllerDistrict,
                  itemCount: cardDataDistrict.length + 1,
                  itemBuilder: (context, index) {
                    if (index == cardDataDistrict.length) {
                      return SizedBox(
                        width: 50,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DistrictDetailsScreen(
                                    restaurantsInTheDistrict:
                                        widget.allRestaurant,
                                    title: "All Districts",
                                    imageUrl: "",
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          DistrictAllScreen(
                                        restaurantsInTheDistrict:
                                            widget.allRestaurant,
                                        districtItems: allDistrict,
                                      ),
                                      transitionDuration: const Duration(
                                          milliseconds:
                                              300), // Optional for smoothness
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return FadeTransition(
                                            opacity: animation, child: child);
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "Show all districts",
                                  style: TextStyle(
                                    fontSize: 20, // Adjust font size as needed
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .black, // Choose a color for the text
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Normal card display logic
                      final item = cardDataDistrict[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      DistrictDetailsScreen(
                                restaurantsInTheDistrict: widget.allRestaurant,
                                title: item['title']!,
                                imageUrl: item['imageUrl']!,
                              ),
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, right: 16, top: 10),
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
              ),
              const SizedBox(
                height: 5,
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.width / 1.1,
              //   child: PageView.builder(
              //     controller: _pageControllerRestaurant,
              //     itemCount: loopedCardDataRestaurant.length,
              //     itemBuilder: (context, index) {
              //       final item = loopedCardDataRestaurant[index];
              //       return GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             PageRouteBuilder(
              //               pageBuilder:
              //                   (context, animation, secondaryAnimation) =>
              //                       FoodDetailsScreen(
              //                 title: item['title']!,
              //                 imageUrl: item['imageUrl']!,
              //               ),
              //               transitionDuration: const Duration(
              //                   milliseconds: 300), // Optional for smoothness
              //               transitionsBuilder: (context, animation,
              //                   secondaryAnimation, child) {
              //                 return FadeTransition(
              //                     opacity: animation, child: child);
              //               },
              //             ),
              //           );
              //         },
              //         child: Container(
              //           margin: const EdgeInsets.only(
              //               bottom: 10, right: 16, top: 10),
              //           decoration: BoxDecoration(
              //             color: Colors.grey.shade200,
              //             borderRadius: BorderRadius.circular(12),
              //             boxShadow: [
              //               BoxShadow(
              //                 blurRadius: 4,
              //                 color: Colors.grey.shade300,
              //                 offset: const Offset(6, 6),
              //               ),
              //             ],
              //           ),
              //           child: Hero(
              //             tag: item['title']!,
              //             child: Stack(
              //               children: [
              //                 // Image background
              //                 ClipRRect(
              //                   borderRadius: BorderRadius.circular(12),
              //                   child: Image.network(
              //                     item['imageUrl']!,
              //                     fit: BoxFit.cover,
              //                     width: double.infinity,
              //                     height: double.infinity,
              //                   ),
              //                 ),
              //                 // Gradient overlay
              //                 Positioned.fill(
              //                   child: Container(
              //                     decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(12),
              //                       gradient: LinearGradient(
              //                         colors: [
              //                           Colors.transparent,
              //                           Colors.transparent,
              //                           Colors.black.withOpacity(0.6),
              //                         ],
              //                         begin: Alignment.topCenter,
              //                         end: Alignment.bottomCenter,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 // Text overlay
              //                 Align(
              //                   alignment: Alignment.bottomLeft,
              //                   child: Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Text(
              //                       item['title']!,
              //                       style: const TextStyle(
              //                         fontSize: 20,
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ]))
    ]));
  }
}
