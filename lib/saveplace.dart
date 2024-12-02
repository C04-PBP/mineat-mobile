import 'package:flutter/material.dart';

class CookItYourselfScreen extends StatefulWidget {
  final String title;
  const CookItYourselfScreen({required this.title, super.key});

  @override
  State<CookItYourselfScreen> createState() => _CookItYourselfScreenState();
}

class _CookItYourselfScreenState extends State<CookItYourselfScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitleOverlay = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 500 && !_showTitleOverlay) {
        setState(() {
          _showTitleOverlay = true;
        });
      } else if (_scrollController.offset <= 500 && _showTitleOverlay) {
        setState(() {
          _showTitleOverlay = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Gradient
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ingredients.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Title Overlay (appears on scroll)
          if (_showTitleOverlay)
            Positioned(
              top: 40,
              left: 20,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          // Content Positioned at Bottom
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add navigation or functionality here
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white,
                //     foregroundColor: Colors.black,
                //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   ),
                //   child: Text('Search available restaurant'),
                // ),
              ],
            ),
          ),

          const Positioned(
            bottom: 30,
            right: 0,
            left: 0,
            child: Center(
                child: Text(
              "Get started",
              style: TextStyle(color: Colors.white),
            )),
          ),

          // Optional Profile Icon
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                // Profile icon functionality
                print("Profile icon tapped");
              },
            ),
          ),
        ],
      ),
    );
  }
}
