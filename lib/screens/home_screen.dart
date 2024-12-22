import 'package:flutter/material.dart';
import 'package:mineat/screens/gege/cook_it_yourself_details_screen.dart';
import 'package:mineat/screens/food_all_screen.dart';
import 'package:mineat/screens/food_details_screen.dart';
import 'package:mineat/screens/gege/ingredient_all_screen.dart';
import 'package:mineat/screens/login_screen.dart';
import 'package:mineat/screens/profile_screen.dart';
import 'package:mineat/widgets/top_picks_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final bool isLoggedIn;
  final List<Map<String, dynamic>> allFood;
  final List<Map<String, dynamic>> allRestaurant;
  const HomeScreen({
    super.key,
    required this.allFood,
    required this.allRestaurant,
    required this.username,
    required this.isLoggedIn,
  });
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late List<Map<String, dynamic>> stackData = [
    ...widget.allFood.where((food) =>
        food['title'] != null &&
        food['title']!.toLowerCase().contains('gulai ayam')),
    ...widget.allFood.where((food) =>
        food['title'] != null &&
        food['title']!.toLowerCase().contains('rendang')),
    ...widget.allFood.where((food) =>
        food['title'] != null &&
        food['title']!.toLowerCase().contains('ayam goreng')),
  ];
  final List<Map<String, dynamic>> cardData = [];

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

  late PageController _pageController;
  late PageController _pageControllerStack;
  late List<Map<String, dynamic>> loopedCardData;
  var filteredChickens;
  var filteredBeefs;
  var filteredSeafoods;
  var filteredVegetarians;
  late List<Map<String, dynamic>> uniqueIngredientsList;
  int currentPage = 0;
  final ScrollController _scrollController = ScrollController();
  bool _showAppBarTitle = false;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _pageControllerStack = PageController(initialPage: 0);

    cardData.addAll(
      widget.allFood.where((item) {
        final title = item['title']?.toLowerCase() ?? '';
        return title.contains('rendang') ||
            title.contains('ayam balado') ||
            title.contains('ayam goreng');
      }).toList(),
    );

    // Duplicate items to create a looped effect for Foods
    filteredChickens = widget.allFood
        .where(
          (item) =>
              item['title']!.toLowerCase().contains('ayam') ||
              item['ingredients']!.toLowerCase().contains('chicken'),
        )
        .toList();

    filteredBeefs = widget.allFood
        .where(
          (item) =>
              item['title']!.toLowerCase().contains('daging') ||
              item['ingredients']!.toLowerCase().contains('beef') ||
              item['ingredients']!.toLowerCase().contains('cow') ||
              item['ingredients']!.toLowerCase().contains('meat'),
        )
        .toList();

    filteredSeafoods = widget.allFood
        .where(
          (item) =>
              item['title']!.toLowerCase().contains('ikan') ||
              item['title']!.toLowerCase().contains('cumi') ||
              item['title']!.toLowerCase().contains('kakap') ||
              item['title']!.toLowerCase().contains('kepiting') ||
              item['title']!.toLowerCase().contains('teri') ||
              item['title']!.toLowerCase().contains('udang') ||
              item['title']!.toLowerCase().contains('lele') ||
              item['ingredients']!.toLowerCase().contains('fish') ||
              item['ingredients']!.toLowerCase().contains('squid') ||
              item['ingredients']!.toLowerCase().contains('snapper') ||
              item['ingredients']!.toLowerCase().contains('crab') ||
              item['ingredients']!.toLowerCase().contains('anchovies') ||
              item['ingredients']!.toLowerCase().contains('shrimp') ||
              item['ingredients']!.toLowerCase().contains('prawns') ||
              item['ingredients']!.toLowerCase().contains('catfish'),
        )
        .toList();

    filteredVegetarians = widget.allFood
        .where(
          (item) =>
              !item['title']!.toLowerCase().contains('ayam') &&
              !item['title']!.toLowerCase().contains('daging') &&
              !item['title']!.toLowerCase().contains('ikan') &&
              !item['title']!.toLowerCase().contains('cumi') &&
              !item['title']!.toLowerCase().contains('kakap') &&
              !item['title']!.toLowerCase().contains('kepiting') &&
              !item['title']!.toLowerCase().contains('teri') &&
              !item['title']!.toLowerCase().contains('udang') &&
              !item['title']!.toLowerCase().contains('lele') &&
              // !item['ingredients']!.toLowerCase().contains('milk') &&
              // !item['ingredients']!.toLowerCase().contains('egg') &&
              !item['ingredients']!.toLowerCase().contains('eels') &&
              !item['ingredients']!.toLowerCase().contains('duck') &&
              !item['ingredients']!.toLowerCase().contains('dishes') &&
              !item['ingredients']!.toLowerCase().contains('mutton') &&
              !item['ingredients']!.toLowerCase().contains('chicken') &&
              !item['ingredients']!.toLowerCase().contains('beef') &&
              !item['ingredients']!.toLowerCase().contains('cow') &&
              !item['ingredients']!.toLowerCase().contains('meat') &&
              !item['ingredients']!.toLowerCase().contains('fish') &&
              !item['ingredients']!.toLowerCase().contains('squid') &&
              !item['ingredients']!.toLowerCase().contains('snapper') &&
              !item['ingredients']!.toLowerCase().contains('crab') &&
              !item['ingredients']!.toLowerCase().contains('anchovies') &&
              !item['ingredients']!.toLowerCase().contains('shrimp') &&
              !item['ingredients']!.toLowerCase().contains('prawns') &&
              !item['ingredients']!.toLowerCase().contains('catfish'),
        )
        .toList();

    List<Map<String, dynamic>> getUniqueIngredients(
        List<Map<String, dynamic>> foodList) {
      final Set<String> uniqueIngredients = {};

      for (var food in foodList) {
        final ingredients =
            food['ingredients']!.split(','); // Split ingredients by comma
        for (var ingredient in ingredients) {
          final trimmedIngredient = ingredient.trim(); // Trim whitespace
          if (trimmedIngredient.isNotEmpty) {
            uniqueIngredients.add(trimmedIngredient);
          }
        }
      }

      // Convert the Set of unique ingredients into a List of Maps
      return uniqueIngredients
          .map((ingredient) => {'ingredient': ingredient})
          .toList();
    }

    uniqueIngredientsList = getUniqueIngredients(widget.allFood);

    loopedCardData = [
      cardData.last,
      ...cardData,
      cardData.first,
    ];
    _pageController = PageController(initialPage: 3, viewportFraction: 0.85);
    _pageController.addListener(() {
      if (_pageController.page == loopedCardData.length - 1) {
        _pageController.jumpToPage(1);
      } else if (_pageController.page == 0) {
        _pageController.jumpToPage(loopedCardData.length - 2);
      }
    });

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

    _rotationController = AnimationController(
      duration: const Duration(seconds: 100), // Set rotation duration
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pageControllerStack.removeListener(() {});
    _pageController.removeListener(() {});
    _pageControllerStack.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            floating: false,
            pinned: true,
            title: _showAppBarTitle
                ? const Text(
                    "Mineat",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : null,
            actions: [],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
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
                                      FoodDetailsScreen(
                                foodsInTheRestaurant: widget.allFood.sublist(4),
                                heroOrNot: false,
                                item: item,
                                restaurantAvailable: restaurantItems,
                                username: widget.username,
                                allFood: widget.allFood,
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
                              bottom: 70,
                              left: 20,
                              right: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Align(
  alignment: Alignment.center,
  child: Text(
    item['title']!
        .split(' ') // Split the title into words
        .map((word) => word[0].toUpperCase() + word.substring(1)) // Capitalize first letter of each word
        .join(' '), // Join the words back into a single string
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
                                      item['description'],
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
                        effect: const ExpandingDotsEffect(
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
                      duration: const Duration(milliseconds: 300),
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
                      duration: const Duration(milliseconds: 300),
                      opacity: _showAppBarTitle ? 0.0 : 1.0,
                      child: IconButton(
                        icon: const Icon(
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
            delegate: SliverChildListDelegate(
              [
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
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TopPicksWidget(
                        allRestaurant: widget.allRestaurant,
                        allFood: widget.allFood,
                        pageController: _pageController,
                        loopedCardData: loopedCardData,
                        callerScreen: "home",
                        username: widget.username,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      FoodAllScreen(
                                    appBarTitle: "Cuisines",
                                    foodItems: widget.allFood,
                                    username: widget.username,
                                    allFood: widget.allFood,
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
                            child: const Row(
                              children: [
                                Text(
                                  "All Cuisines",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 24,
                                ), // Replace with arrow_left for a left arrow
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Filter items containing "ayam" in the title
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodAllScreen(
                                        appBarTitle: "Chicken",
                                        foodItems: filteredChickens,
                                        username: widget.username,
                                        allFood: widget.allFood,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      colors: [
                                        Colors.grey.shade800,
                                        const Color.fromARGB(255, 231, 211, 32)
                                            .withOpacity(0.65)
                                            .withAlpha(255),
                                      ],
                                      focal: Alignment.centerLeft,
                                      focalRadius: 10,
                                    ),
                                    // LinearGradient(
                                    //   colors:
                                    // ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Theme.of(context).shadowColor,
                                        offset: const Offset(6, 6),
                                      ),
                                    ],
                                  ),
                                  child: Text("Chicken"),
                                ),
                              ),
                            ),
                            const SizedBox(
                                width:
                                    16), // Adds 20px space between containers
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodAllScreen(
                                        appBarTitle: "Beef",
                                        foodItems: filteredBeefs,
                                        username: widget.username,
                                        allFood: widget.allFood,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      colors: [
                                        Colors.grey.shade800,
                                        const Color(0xFFD32F2F)
                                            .withOpacity(0.65),
                                      ],
                                      focal: Alignment.centerLeft,
                                      focalRadius: 10,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Theme.of(context).shadowColor,
                                        offset: const Offset(6, 6),
                                      ),
                                    ],
                                  ), // Adds 20px padding inside the container
                                  child: const Text("Beef"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Filter items containing "ayam" in the title
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodAllScreen(
                                        appBarTitle: "Seafood",
                                        foodItems: filteredSeafoods,
                                        username: widget.username,
                                        allFood: widget.allFood,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      colors: [
                                        Colors.grey.shade800,
                                        const Color.fromARGB(255, 59, 174, 227)
                                            .withOpacity(0.7),
                                      ],
                                      focal: Alignment.centerLeft,
                                      focalRadius: 10,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Theme.of(context).shadowColor,
                                        offset: const Offset(6, 6),
                                      ),
                                    ],
                                  ), // Adds 20px padding inside the container
                                  child: const Text("Seafood"),
                                ),
                              ),
                            ),
                            const SizedBox(
                                width:
                                    16), // Adds 20px space between containers
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Filter items containing "ayam" in the title
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodAllScreen(
                                        appBarTitle: "Vegetarian",
                                        foodItems: filteredVegetarians,
                                        username: widget.username,
                                        allFood: widget.allFood,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      colors: [
                                        Colors.grey.shade800,
                                        const Color.fromARGB(255, 98, 210, 102)
                                            .withOpacity(0.8),
                                      ],
                                      focal: Alignment.centerLeft,
                                      focalRadius: 10,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Theme.of(context).shadowColor,
                                        offset: const Offset(6, 6),
                                      ),
                                    ],
                                  ), // Adds 20px padding inside the container
                                  child: const Text("Vegetarian"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Row(
                            children: [
                              Text(
                                "Feeling Broke?",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              // Icon(
                              //   Icons.arrow_forward_ios,
                              //   size: 24,
                              //   color: Colors.black,
                              // ), // Replace with arrow_left for a left arrow
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Choose your maximum budget.",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade700),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Filter items containing "ayam" in the title
                                  final filteredItems = widget.allFood
                                      .where((item) =>
                                          (item['price'] ?? 0) <= 20000)
                                      .toList();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodAllScreen(
                                        appBarTitle: "Under 20K",
                                        foodItems: filteredItems,
                                        username: widget.username,
                                        allFood: widget.allFood,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 140,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/20k.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color:
                                                Theme.of(context).shadowColor,
                                            offset: const Offset(6, 6),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                    const Positioned(
                                      bottom: 8,
                                      left: 8,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "20K",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Filter items containing "ayam" in the title
                                  final filteredItems = widget.allFood
                                      .where((item) =>
                                          (item['price'] ?? 0) <= 50000)
                                      .toList();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodAllScreen(
                                        appBarTitle: "Under 50 K",
                                        foodItems: filteredItems,
                                        username: widget.username,
                                        allFood: widget.allFood,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 140,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/50k.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color:
                                                Theme.of(context).shadowColor,
                                            offset: const Offset(6, 6),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                    const Positioned(
                                      bottom: 8,
                                      left: 8,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: const Text(
                                          "50K",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Filter items containing "ayam" in the title
                                  final filteredItems = widget.allFood
                                      .where((item) =>
                                          (item['price'] ?? 0) <= 100000)
                                      .toList();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodAllScreen(
                                        appBarTitle: "Under 100K",
                                        foodItems: filteredItems,
                                        username: widget.username,
                                        allFood: widget.allFood,
                                      ),
                                    ),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 140,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/100k.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color:
                                                Theme.of(context).shadowColor,
                                            offset: const Offset(6, 6),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                    const Positioned(
                                      bottom: 8,
                                      left: 8,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: const Text(
                                          "100K",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      IngredientAllScreen(
                                    ingredientItems: uniqueIngredientsList,
                                    foodItems: widget.allFood,
                                    username: widget.username,
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
                            child: const Row(
                              children: [
                                Text(
                                  "Cook it Yourself",
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
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
                      const SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      CookItYourselfScreen(
                                title: "you're \nCOOKing?",
                                ingredientItems: uniqueIngredientsList,
                                foodItems: widget.allFood,
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
                        child: Hero(
                          tag: "ingredient_expand",
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 1,
                            child: GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 10, right: 20, top: 10, left: 20),
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
                                child:
                                    // Image background
                                    ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  // child: RotationTransition(
                                  //   turns: _rotationController,
                                  child: Image.asset(
                                    'assets/images/ingredients2.png',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  // ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
