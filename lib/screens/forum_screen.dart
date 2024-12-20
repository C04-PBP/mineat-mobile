import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mineat/api/device.dart';
import 'package:mineat/screens/forum_details_screen.dart';
import 'package:mineat/api/forumUmum_service.dart';
import 'package:mineat/api/forum.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:mineat/screens/login_screen.dart';

class ForumScreen extends StatefulWidget {
  final String username;
  final bool isLoggedIn;
  final List<Map<String, dynamic>> allFood;
  const ForumScreen({
    super.key,
    required this.allFood,
    required this.username,
    required this.isLoggedIn,
  });

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  List<Forum> allForum = [];
  List<Forum> searchFilteredForums = [];
  List<Forum> checkboxFilteredForums = [];
  List<Forum> filteredForums = [];
  bool isLoading = true;
  bool showUnansweredOnly = false;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _textController = TextEditingController();
  String _title = "";
  String _text = "";

  @override
  void initState() {
    super.initState();
    searchFilteredForums = allForum;
    checkboxFilteredForums = allForum;
    filteredForums = allForum;
    fetchData();
    print('ok masuk pak');
  }

  Future<List<Forum>> fetchForum(CookieRequest request) async {
    final response = await request.get('$device/forum/json/');
    
    var data = response;
    
    List<Forum> listForum = [];
    for (var d in data) {
      if (d != null) {
        listForum.add(Forum.fromJson(d));
      }
    }
    return listForum;
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    final request = CookieRequest();
    final forums = await fetchForum(request);

    if (forums.isNotEmpty) {
      setState(() {
        allForum = forums;
        searchFilteredForums = allForum;
        checkboxFilteredForums = allForum;
        filteredForums = allForum;
        isLoading = false;
      });
    } else {
      print('Error: ForumUmum data is null or not found');
    }
  }

  void _filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        searchFilteredForums = allForum;
      } else {
        searchFilteredForums = allForum
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
            
        if (searchFilteredForums.isEmpty) {
          filteredForums = [];
          return;
        }
      }
    _combineFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      if (!showUnansweredOnly) {
        checkboxFilteredForums = allForum;
      } else {
        checkboxFilteredForums = allForum
            .where((forum) => forum.replyCount == 1)
            .toList();
      }
      _combineFilters();
    });
  }

  void _combineFilters() {
    setState(() {
      if (searchFilteredForums.isEmpty) {
        filteredForums = checkboxFilteredForums;
      }
      else if (checkboxFilteredForums.isEmpty) {
        filteredForums = searchFilteredForums;
      }
      else {
        filteredForums = searchFilteredForums
            .where((forum) => checkboxFilteredForums.contains(forum))
            .toList();
      }
    });
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
    final request = context.watch<CookieRequest>();
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
            widget.isLoggedIn ? Padding(
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // _addForum(_titleController.text, _textController.text);
                          final response = await request.postJson(
                            "$device/forum/create-flutter/",
                            jsonEncode(<String, String>{
                                // 'user': widget.username,
                                'title': _titleController.text,
                                'text': _textController.text,
                            }),
                          );
                          if (context.mounted) {
                              if (response['status'] == 'success') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                  content: Text("Forum baru berhasil disimpan!"),
                                  ));
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(builder: (context) => ForumScreen(allFood: [],)),
                                  // );
                              } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content:
                                          Text("Terdapat kesalahan, silakan coba lagi."),
                                  ));
                              }
                          }
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
            )  : Padding(
              padding: const EdgeInsets.all(20),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black), // Default text style for the whole text
                  children: <TextSpan>[
                    TextSpan(text: 'Please '), // Normal text
                    TextSpan(
                      text: 'log in', // Clickable text
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to the login page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(username: '',), // Assuming LoginScreen is your login page widget
                            ),
                          );
                        },
                    ),
                    TextSpan(text: ' to add a new forum.'), // Normal text
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Checkbox(
                    value: showUnansweredOnly,
                    onChanged: (bool? value) {
                      setState(() {
                        showUnansweredOnly = value ?? false;
                        _applyFilters();
                      });
                    },
                  ),
                  const Text('Show Unanswered Discussions Only'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FutureBuilder<List<Forum>>(
                  future: fetchForum(request), // Pastikan ini memanggil fungsi fetch yang benar
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.forum,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "No forums available",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Start a new discussion by creating a forum",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // Jika data ada, gunakan dalam GridView
                      // filteredForums = snapshot.data!;//.cast<Map<String, dynamic>>();
                      if (allForum.isEmpty) {
                        allForum = snapshot.data!;
                        searchFilteredForums = allForum;
                        checkboxFilteredForums = allForum;
                        filteredForums = allForum;
                      }
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 20,
                          childAspectRatio: 3.5 / 1,
                        ),
                        itemCount: filteredForums.length,
                        itemBuilder: (context, index) {
                          final item = filteredForums[index];
                          final backgroundImage = _getMatchingImage(item.title); // Fungsi ini harus didefinisikan di tempat lain
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => ForumDetailsScreen(
                                    forum: item,
                                    backgroundImage: backgroundImage,
                                    isLoggedIn: widget.isLoggedIn,
                                  ),
                                  transitionDuration: const Duration(milliseconds: 300),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Hero(
                              tag: item.title,
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
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
                                            image: DecorationImage(
                                              image: backgroundImage!.startsWith('http')
                                                  ? NetworkImage(backgroundImage)
                                                  : AssetImage(backgroundImage) as ImageProvider,
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
                                              right: Radius.circular(12),
                                            ),
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
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.title,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    "first reply: ${item.text}",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 30),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  item.timeCreated,
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
                                                  "by: ${item.user}",
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
                      );
                    } else {
                      // Tampilkan pesan ini jika tidak ada data yang diterima
                      return const Center(child: Text("No forums available"));
                    }
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
