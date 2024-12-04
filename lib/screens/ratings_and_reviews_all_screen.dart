import 'package:flutter/material.dart';

class RatingsAndReviewsAllScreen extends StatefulWidget {
  final List<Map<String, dynamic>> reviewsData;

  const RatingsAndReviewsAllScreen({required this.reviewsData, Key? key})
      : super(key: key);

  @override
  _RatingsAndReviewsAllScreenState createState() =>
      _RatingsAndReviewsAllScreenState();
}

class _RatingsAndReviewsAllScreenState
    extends State<RatingsAndReviewsAllScreen> {
  late List<Map<String, dynamic>> sortedReviews;
  String _selectedSortOption = 'Most Favourable';

  @override
  void initState() {
    super.initState();
    sortedReviews =
        List.from(widget.reviewsData); // Initialize with original data
    _sortReviews(); // Apply initial sorting
  }

  void _sortReviews() {
    switch (_selectedSortOption) {
      // case 'Most Recent':
      //   sortedReviews.sort((a, b) => b['timeAgo'].compareTo(a['timeAgo']));
      //   break;
      // case 'Least Recent':
      //   sortedReviews.sort((a, b) => a['timeAgo'].compareTo(b['timeAgo']));
      //   break;
      case 'Most Favourable':
        sortedReviews.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'Most Critical':
        sortedReviews.sort((a, b) => a['rating'].compareTo(b['rating']));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the average rating
    double averageRating = sortedReviews.isNotEmpty
        ? sortedReviews
                .map((review) => review['rating'] as int)
                .reduce((a, b) => a + b) /
            sortedReviews.length
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ratings & Reviews',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overall Rating Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        averageRating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "out of 5",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: 
                    Column(
                      children: List.generate(5, (index) {
                        return Row(
                          children: [
                            Text(
                              "${5 - index}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: calculateStarPercentage(
                                    sortedReviews, 5 - index),
                                color: Theme.of(context).colorScheme.primary,
                                backgroundColor: Colors.grey.shade300,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Sorting Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${sortedReviews.length} Ratings",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    value: _selectedSortOption,
                    icon: Icon(Icons.arrow_drop_down_rounded,
                        color: Theme.of(context).colorScheme.primary), // iOS-style dropdown arrow
                    iconSize: 34,
                    // underline: Container(
                    //   height: 1,
                    //   color: Colors.grey.shade300, // Thin underline
                    // ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    dropdownColor:
                        Colors.white, // iOS-style dropdown background
                    borderRadius: BorderRadius.circular(10), // Rounded dropdown
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSortOption = newValue;
                          _sortReviews();
                        });
                      }
                    },
                    items: <String>[
                      // 'Most Recent',
                      // 'Least Recent',
                      'Most Favourable',
                      'Most Critical'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              // Reviews List
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: sortedReviews.length,
                itemBuilder: (context, index) {
                  final review = sortedReviews[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              review['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${review['timeAgo']} • ${review['reviewer']}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: List.generate(
                            review['rating'],
                            (starIndex) => Icon(
                              Icons.star,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          review['content'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Chef Response",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          review['response'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateStarPercentage(
      List<Map<String, dynamic>> reviewsData, int starRating) {
    if (reviewsData.isEmpty) return 0.0;

    final totalReviews = reviewsData.length;
    final starCount =
        reviewsData.where((review) => review['rating'] == starRating).length;

    return starCount / totalReviews;
  }
}
