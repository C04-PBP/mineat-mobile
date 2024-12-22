import 'package:flutter/material.dart';
import 'package:mineat/api/review_service.dart';
import 'package:mineat/screens/ratings_and_reviews_all_screen.dart';
import 'package:mineat/screens/restaurant_details_screen.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  final List<Map<String, dynamic>> restaurantAvailable;
  final List<Map<String, dynamic>> foodsInTheRestaurant;
  final bool heroOrNot;
  final String username;
  const FoodDetailsScreen(
      {required this.item,
      required this.restaurantAvailable,
      required this.heroOrNot,
      required this.foodsInTheRestaurant,
      required this.username,
      super.key});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  late PageController _pageController;
  bool _showAppBarTitle = false;
  bool _showAll = false;
  // final rating = 3.5;
  int _myRating = 0;
  // bool _isReviewBoxVisible = false;
  bool _isTapToRateVisible = true;
  bool _isReviewSubmitted = false;
  int _countRateError = 0;
  bool _isButtonVisible = false;
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _reviewTitleController = TextEditingController();
  final TextEditingController _reviewTextController = TextEditingController();

  int _currentPageIndex = 0;

  // Hardcoded data for each page
  bool isLoading = true;
  List<Map<String, dynamic>> reviewsData = [
    {
      'title': 'Amazing Food',
      'rating': 5,
      'reviewer': 'Zac Gauthier',
      'timeAgo': '5y ago',
      'content': 'The best food I’ve ever had. Highly recommend it!',
      'response': 'We\'re thrilled you enjoyed your experience! Thank you!',
    },
    {
      'title': 'Delicious',
      'rating': 4,
      'reviewer': 'Anna Smith',
      'timeAgo': '2y ago',
      'content': 'Great food, but the service could be faster.',
      'response': 'We appreciate your feedback and will improve.',
    },
    {
      'title': 'Good Experience',
      'rating': 4,
      'reviewer': 'John Doe',
      'timeAgo': '1y ago',
      'content': 'The ambiance was nice, and the food was good.',
      'response': 'Thank you for your kind words!',
    },
    {
      'title': 'Not bad',
      'rating': 3,
      'reviewer': 'Emily Clark',
      'timeAgo': '6mo ago',
      'content': 'The food was okay, but the portion sizes are too small.',
      'response': 'We\'ll work on improving portion sizes. Thank you!',
    },
    {
      'title': 'Disappointing',
      'rating': 2,
      'reviewer': 'Jake Williams',
      'timeAgo': '3mo ago',
      'content': 'Service was slow, and the food was cold.',
      'response': 'We’re sorry to hear this. We’re working to improve!',
    },
    {
      'title': 'Could be better',
      'rating': 3,
      'reviewer': 'Sarah Johnson',
      'timeAgo': '1mo ago',
      'content': 'The desserts were great, but the main course wasn’t.',
      'response': 'Thank you for the feedback. We’ll improve!',
    },
  ];

  final List<Map<String, dynamic>> reviewsDataHelpful = [
    {
      'title': 'Amazing Food',
      'rating': 5,
      'reviewer': 'Zac Gauthier',
      'timeAgo': '5y ago',
      'content': 'The best food I’ve ever had. Highly recommend it!',
      'response': 'We\'re thrilled you enjoyed your experience! Thank you!',
    },
    {
      'title': 'Delicious',
      'rating': 4,
      'reviewer': 'Anna Smith',
      'timeAgo': '2y ago',
      'content': 'Great food, but the service could be faster.',
      'response': 'We appreciate your feedback and will improve.',
    },
    {
      'title': 'Good Experience',
      'rating': 4,
      'reviewer': 'John Doe',
      'timeAgo': '1y ago',
      'content': 'The ambiance was nice, and the food was good.',
      'response': 'Thank you for your kind words!',
    },
  ];

  final List<Map<String, dynamic>> foodsYouMightLikeData = [
    {
      "title": "Gulai tambusu",
      "price": 38000,
      "ingredients":
          "Cow intestines, eggs, tofu, coconut milk, turmeric, garlic, chilies, lemongrass, kaffir lime leaves,",
      "description":
          "gulai of cow intestines usually filled with eggs and tofu",
      "imageUrl":
          "https://asset.kompas.com/crops/bcpcDBgw82mDYr495vYWQBLff4A=/0x352:667x797/750x500/data/photo/2022/08/12/62f5e26894a4f.jpg"
    },
    {
      "title": "Kalio Ayam",
      "price": 35000,
      "ingredients":
          "Chicken, Coconut milk, Cooking oil, Garlic (minced), Shallots (sliced), Turmeric, Ginger (sliced), Lemongrass, Red chilies (sliced), Salt, Sugar, Water",
      "description":
          "similar to rendang; while rendang is rather dry, kalio is watery and light-colored",
      "imageUrl":
          "https://asset.kompas.com/crops/mCb4rnN344JdAyqQs9i1IJWktRU=/0x379:667x823/750x500/data/photo/2021/05/11/609a2c750cdc5.jpg"
    },
    {
      "title": "Kepiting Saus Padang",
      "price": 75000,
      "ingredients":
          "Crab, chilies, shallots, garlic, lemongrass, turmeric, lime leaves, salt, oil,",
      "description":
          "seafood dish of crab served in hot and spicy Padang sauce",
      "imageUrl":
          "https://www.tokomesin.com/wp-content/uploads/2015/10/kepiting-saos-padang-tokomesin.jpg"
    },
    {
      "title": "Dendeng balado",
      "price": 52000,
      "ingredients":
          "Thin beef slices, red chilies, shallots, garlic, tomatoes, lime leaves, salt, oil,",
      "description": "Thin crispy beef with chili",
      "imageUrl":
          "https://www.sasa.co.id/medias/page_medias/resep_dendeng_balado.jpg"
    },
    {
      "title": "Ayam lado ijo",
      "price": 42000,
      "ingredients":
          "Chicken, green chilies, shallots, garlic, lime leaves, salt, oil,",
      "description": "chicken in green chili",
      "imageUrl":
          "https://static.promediateknologi.id/crop/6x262:1075x1659/750x500/webp/photo/p1/1005/2024/01/28/Screenshot_20240128_195516_Instagram-3462551055.jpg"
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.75);
    fetchData();
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
    _reviewTitleController.addListener(() {
      setState(() {
        _isButtonVisible = _reviewTitleController.text.isNotEmpty ||
            _reviewTextController.text.isNotEmpty;
      });
    });
    // _reviewTextController.addListener(() {
    //   setState(() {
    //     _isButtonVisible = _reviewTitleController.text.isNotEmpty ||
    //         _reviewTextController.text.isNotEmpty;
    //   });
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _reviewController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    print('masuk');
    await ReviewService.fetchReviewData(widget.item["id"]);  //butuh id makanannya

    final reviews = ReviewService.getReviewData();

    if (reviews!.isNotEmpty) {
      setState(() {
        reviewsData = reviews;
        isLoading = false;
      });
    } else {
      print('Error: Review data is null or not found');
    }
  }


  void _handleRatingTap(int rating) {
    setState(() {
      _myRating = rating;
      _isTapToRateVisible = false;
      // _isReviewBoxVisible = true; // Show the review box
    });
  }

  void _handleSubmitReview() {
    String title = _reviewTitleController.text.trim();
    String reviewContent = _reviewTextController.text.trim();
    if (_myRating == 0) {
      setState(() {
        _isReviewSubmitted = false;
      });
    }
    if (_myRating == 0) {
      setState(() {
        _countRateError += 1;
      });
    }

    if ((title.isNotEmpty || reviewContent.isNotEmpty) && _myRating != 0) {
      setState(() {
        _isReviewSubmitted = true;
        _countRateError = -1;
        // Determine the response based on the rating
        String response = _myRating <= 3
            ? "We’re sorry to hear this. We’re working to improve!"
            : "We’re thrilled you enjoyed your experience! Thank you!";

        // Add the new review to the reviewsData
        reviewsData.removeWhere((review) => review['reviewer'] == 'YOU');
        reviewsData.insert(0, {
          'title': title.isEmpty ? '' : title,
          'rating':
              _myRating > 0 ? _myRating : 5, // Default to 5 stars if no rating
          'reviewer': 'YOU',
          'timeAgo': 'now',
          'content': reviewContent,
          'response': response, // Add the appropriate response
        });

        // Clear the input fields
        _reviewTitleController.clear();
        _reviewTextController.clear();
      });

      // Dismiss the keyboard
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final int itemsToShow =
        _showAll ? widget.restaurantAvailable.length : 1 * 2;
    double averageRating = reviewsData.isNotEmpty
        ? reviewsData
                .map((review) => review['rating'] as int)
                .reduce((a, b) => a + b) /
            reviewsData.length
        : 0.0;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // Unfocuses the search bar when tapping outside
      },
      child: Hero(
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
                        widget.item['title'].endsWith("stack")
                            ? widget.item['title'].substring(
                                0, widget.item['title'].length - "stack".length)
                            : widget.item['title'],
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
                        bottom: 24,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.item['title'].endsWith("stack")
                                    ? widget.item['title'].substring(
                                        0,
                                        widget.item['title'].length -
                                            "stack".length)
                                    : widget.item['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.item['description'],
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.item['price'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
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
                  delegate: SliverChildListDelegate([
                Padding(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        // color: Colors.white,
                        // padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20, top: 20),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                widget.item['description'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 20),
                              child: Text(
                                'Ingredients',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                widget.item['ingredients'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Text(
                                'Available restaurants',
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
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                itemCount: itemsToShow.clamp(
                                    0, widget.restaurantAvailable.length),
                                itemBuilder: (context, index) {
                                  final item =
                                      widget.restaurantAvailable[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurantDetailsScreen(
                                            restaurantAvailable:
                                                widget.restaurantAvailable,
                                            foodsInTheRestaurant:
                                                widget.foodsInTheRestaurant,
                                            heroOrNot: true,
                                            item: item,
                                            username: widget.username,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
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
                            if (widget.restaurantAvailable.length >
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
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RatingsAndReviewsAllScreen(
                                              reviewsData: reviewsData),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Ratings & Reviews',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    averageRating.toStringAsFixed(
                                        1), // Display the average rating
                                    style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Row(
                                        children: List.generate(5, (index) {
                                          if (index < averageRating.floor()) {
                                            // Fully filled stars
                                            return Icon(
                                              Icons.star,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              size: 30,
                                            );
                                          } else if (index ==
                                              averageRating.floor()) {
                                            // Partially filled star
                                            double fractionalPart =
                                                averageRating -
                                                    averageRating.floor();
                                            return Stack(
                                              children: [
                                                Icon(
                                                  Icons.star_border,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  size: 30,
                                                ),
                                                ClipRect(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    widthFactor: fractionalPart,
                                                    child: Icon(
                                                      Icons.star,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            // Empty stars
                                            return Icon(
                                              Icons.star_border,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              size: 30,
                                            );
                                          }
                                        }),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(width: 20),
                                          Text(
                                            "${reviewsData.length} Ratings",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Text(
                                "Most Helpful Reviews",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Review Card
                            Padding(
                              padding: EdgeInsets.zero,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: reviewsDataHelpful.length,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPageIndex = index;
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    final review = reviewsDataHelpful[index];
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            offset: const Offset(4, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            review['title'],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Row(
                                                children: List.generate(
                                                  review['rating'],
                                                  (index) => Icon(
                                                    Icons.star,
                                                    size: 16,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                "${review['timeAgo']} • ${review['reviewer']}",
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            review['content'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          const Text(
                                            "Chef Response",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            review['response'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Tap to Rate Section
                            if (_isTapToRateVisible && _countRateError == 0)
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      "Tap to Rate",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (!_isTapToRateVisible && _isReviewSubmitted)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: const Text(
                                      "Thanks for Rating!",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (!_isTapToRateVisible && !_isReviewSubmitted)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: const Text(
                                      "Submit your Review",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (_isTapToRateVisible && _countRateError > 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: const Text(
                                      "Choose your rating first!",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                (index) => GestureDetector(
                                  onTap: () => _handleRatingTap(index + 1),
                                  child: Icon(
                                    index < _myRating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: index < _myRating
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.primary,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_isReviewSubmitted) {
                                            _isReviewSubmitted = false;

                                            // Populate the TextFields with the previously submitted review
                                            _reviewTitleController.text =
                                                reviewsData.first['title'];
                                            _reviewTextController.text =
                                                reviewsData.first['content'];
                                          }
                                        });
                                      },
                                      child: SizedBox(
                                        height:
                                            200, // Fixed height for both conditions
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: _isReviewSubmitted
                                                ? Colors.grey.shade100
                                                : Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: _isReviewSubmitted
                                                    ? Colors.white
                                                    : Colors.grey.shade500,
                                                offset: const Offset(-7, -7),
                                                blurRadius: 8,
                                                spreadRadius:
                                                    _isReviewSubmitted ? 0 : -5,
                                              ),
                                              BoxShadow(
                                                color: _isReviewSubmitted
                                                    ? Colors.grey.shade500
                                                    : Colors.white,
                                                offset: const Offset(7, 7),
                                                blurRadius: 8,
                                                spreadRadius:
                                                    _isReviewSubmitted ? -5 : 0,
                                              ),
                                            ],
                                          ),
                                          child: AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            child: !_isReviewSubmitted
                                                ? Column(
                                                    key: const ValueKey('form'),
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            _reviewTitleController,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Review Title',
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey
                                                                  .shade400),
                                                        ),
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        maxLines: 1,
                                                      ),
                                                      Divider(
                                                          height: 1,
                                                          color: Colors
                                                              .grey.shade300),
                                                      TextField(
                                                        controller:
                                                            _reviewTextController,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Write your review here (optional)',
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey
                                                                  .shade400),
                                                        ),
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                        maxLines: 3,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      if (_isButtonVisible) // Show button only when there's text
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  // Reset the star rating
                                                                  _myRating = 0;
                                                                  // Remove the specific review by matching reviewer and timeAgo
                                                                  reviewsData.removeWhere(
                                                                      (review) =>
                                                                          review[
                                                                              'reviewer'] ==
                                                                          'YOU');
                                                                  // Clear the text fields and reset visibility
                                                                  _reviewTitleController
                                                                      .clear();
                                                                  _reviewTextController
                                                                      .clear();
                                                                  _isButtonVisible =
                                                                      false;
                                                                  _isTapToRateVisible =
                                                                      true;
                                                                  _countRateError =
                                                                      0;
                                                                });

                                                                // Unfocus the keyboard
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              },
                                                              icon: Icon(
                                                                Icons.close,
                                                                size: 30,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),
                                                            ),
                                                            IconButton(
                                                              onPressed:
                                                                  _handleSubmitReview,
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 24,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  )
                                                : Column(
                                                    key: const ValueKey(
                                                        'submitted'),
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                          height: 12),
                                                      Text(
                                                        reviewsData
                                                            .first['title'],
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children:
                                                                List.generate(
                                                              reviewsData.first[
                                                                  'rating'],
                                                              (index) => Icon(
                                                                Icons.star,
                                                                size: 16,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 8),
                                                          Text(
                                                            "${reviewsData.first['timeAgo']} • ${reviewsData.first['reviewer']}",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        reviewsData
                                                            .first['content'],
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      const Text(
                                                        "Chef Response",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        reviewsData
                                                            .first['response'],
                                                        style: const TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Foods you might like',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: PageView.builder(
                                controller: PageController(
                                  initialPage: 2,
                                  viewportFraction: 0.5,
                                ),
                                itemCount: foodsYouMightLikeData.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentPageIndex = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  final item = foodsYouMightLikeData[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FoodDetailsScreen(
                                            foodsInTheRestaurant:
                                                widget.foodsInTheRestaurant,
                                            restaurantAvailable:
                                                widget.restaurantAvailable,
                                            heroOrNot: true,
                                            item: item,
                                            username: widget.username,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
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
                                                Colors.black.withOpacity(0.5),
                                                Colors.transparent,
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
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
