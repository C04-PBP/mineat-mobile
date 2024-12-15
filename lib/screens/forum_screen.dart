import 'package:flutter/material.dart';
import 'package:mineat/screens/forum_details_screen.dart';
import 'package:mineat/api/forumUmum_service.dart';

class ForumScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allFood;
  const ForumScreen({super.key, required this.allFood});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  List<Map<String, dynamic>> filteredForums = [];
  List<Map<String, dynamic>> allForum = []; // Tempat menyimpan forum yang dinamis
  bool isLoading = true;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredForums = allForum;
    fetchData();
    print('ok masuk pak');
  }

  Future<void> fetchData() async {
    await ForumUmumService.fetchForumUmumData();

    final forumUmums = ForumUmumService.getForumUmumData();

    if (forumUmums!.isNotEmpty) {
      setState(() {
        allForum = forumUmums;
        isLoading = false;
      });
    } else {
      print('Error: ForumUmum data is null or not found');
    }
  }

  void _filterSearchResults(String query) {
    // if (isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    if (query.isEmpty) {
      setState(() {
        filteredForums = allForum;
      });
    } else {
      setState(() {
        filteredForums = allForum
            .where((item) =>
                item['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  void _addForum(String title, String text) {
    final newForum = {
      "user": "Anonymous", // User bisa disesuaikan jika ada fitur login
      "title": title,
      "time_created": DateTime.now().toString().split(' ')[0],
      "text": text,
    };

    setState(() {
      allForum.insert(0, newForum); // Tambahkan forum baru di posisi awal
      filteredForums = allForum;
    });

    // Kosongkan form setelah submit
    _titleController.clear();
    _textController.clear();
  }


  String? _getMatchingImage(String forumTitle) {
    for (var food in widget.allFood) {
      if (forumTitle.toLowerCase().contains(food['title'].toLowerCase())) {
        return food['imageUrl'];
      }
    }
    return 'assets/images/ingredients2.png'; // Return null if no match is found
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
            'Forum',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          surfaceTintColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add a new forum",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: "Discussion Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a discussion name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        labelText: "Comment",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a comment";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addForum(_titleController.text, _textController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: SizedBox(
                height: 40, // Reducing the height of the search bar
                child: TextField(
                  onChanged: _filterSearchResults,
                  decoration: InputDecoration(
                    hintText: 'Search for a topic',
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
                    crossAxisCount: 1, // Number of columns
                    crossAxisSpacing: 0, // Space between columns
                    mainAxisSpacing: 20, // Space between rows
                    childAspectRatio: 3.5 /
                        1, // Aspect ratio for each grid item to match your design
                  ),
                  itemCount: filteredForums.length,
                  itemBuilder: (context, index) {
                    final item = filteredForums[index];
                    final backgroundImage = _getMatchingImage(item['title']);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ForumDetailsScreen(
                              forum: item,
                              backgroundImage: backgroundImage,
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
                        tag: item['title'],
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Theme.of(context).shadowColor,
                                  offset: const Offset(6, 6),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Background image with gradient for the left 2/5 part
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.horizontal(
                                          right: Radius.circular(12)),
                                      image: DecorationImage(
                                        image: backgroundImage!
                                                .startsWith('http') // Check if URL
                                            ? NetworkImage(backgroundImage)
                                            : AssetImage(backgroundImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.horizontal(
                                          left: Radius.circular(12),
                                          right: Radius.circular(12)),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.white,
                                          Colors.white.withOpacity(0.4),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                ),
                                // Content of the card
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['title']!,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "first reply: ${item['text']}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                              maxLines: 2, // Limit to 2 lines
                                              overflow: TextOverflow
                                                  .ellipsis, // Add ellipsis if text overflows
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            item['time_created'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(2, 2),
                                                  blurRadius: 8,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "by: ${item['user']}",
                                            style: const TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: 14,
                                              color: Colors.black,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(2, 2),
                                                  blurRadius: 8,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
