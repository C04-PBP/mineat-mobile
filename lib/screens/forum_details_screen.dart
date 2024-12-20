import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mineat/api/device.dart';
import 'package:mineat/api/forum.dart';
import 'package:mineat/api/forumKhusus_service.dart';
import 'package:mineat/api/forum_replies.dart';
import 'package:mineat/screens/login_screen.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ForumDetailsScreen extends StatefulWidget {
  final Forum forum;
  final String backgroundImage;
  final bool isLoggedIn;

  const ForumDetailsScreen(
      {Key? key, required this.forum, required this.backgroundImage, required this.isLoggedIn})
      : super(key: key);

  @override
  State<ForumDetailsScreen> createState() => _ForumDetailsScreenState();
}

class _ForumDetailsScreenState extends State<ForumDetailsScreen> {
  late ScrollController _scrollController;
  bool _showAppBarTitle = false;

  List<ForumReplies> allReplies = [];
  // final _replyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  String _text = "";

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 120 && !_showAppBarTitle) {
        setState(() {
          _showAppBarTitle = true;
        });
      } else if (_scrollController.offset <= 120 && _showAppBarTitle) {
        setState(() {
          _showAppBarTitle = false;
        });
      }
    });
    fetchData();
    print("masuk bos");
  }

  Future<List<ForumReplies>> fetchReply(CookieRequest request) async {
    final response = await request.get('$device/forum/${widget.forum.id}/json/');
    // print('Forum ID is: ${widget.forum.id}');
    // if(widget.forum.id == null) {
    //   throw Exception('Forum ID is null');
    // }

    var data = response;
    
    List<ForumReplies> listReplies = [];
    for (int i = 1; i < data.length; i++) {
      var d = data[i];
      if (d != null) {
        listReplies.add(ForumReplies.fromJson(d));
      }
    }
    return listReplies;
  }

  Future<void> fetchData() async {
    // await ForumKhususService.fetchForumKhususData();
    // final forumKhususs = ForumKhususService.getForumKhususData();
    final request = CookieRequest();
    final replies = await fetchReply(request);

    if (replies.isNotEmpty) {
      setState(() {
        allReplies = replies;
        isLoading = false;
      });
    } else {
      print('Error: ForumKhusus data is null or not found');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  
  // void _addReply(String text) {
  //   final newReply = {
  //     "user": "Anonymous", // Bisa diganti dengan username pengguna yang login
  //     "text": text,
  //     "time_created": DateTime.now().toString().split(' ')[0], // Format tanggal
  //   };

  //   setState(() {
  //     replies.insert(0, newReply); // Tambahkan komentar di posisi teratas
  //   });

  //   _textController.clear(); // Bersihkan field input
  // }


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      // tag: 'forum_details_${widget.forum.id}_${widget.forum.title}',
      // child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new, // Use a custom arrow icon
                  color: Colors.white, // Customize the color
                ),
                onPressed: () {
                  Navigator.pop(
                      context); // Navigate back to the previous screen
                },
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              pinned: true,
              floating: false,
              title: _showAppBarTitle
                  ? Text(
                      widget.forum.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  : null,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: widget.backgroundImage.startsWith('http')
                              ? NetworkImage(widget.backgroundImage)
                              : AssetImage(widget.backgroundImage)
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.12,
                      left: 0,
                      right: 0,
                      child: Text(
                        widget.forum.title,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Started by',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(7, 7),
                          blurRadius: 8,
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.forum.user,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              widget.forum.timeCreated,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.forum.text,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Replies',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: allReplies.length,
                  itemBuilder: (context, index) {
                    final reply = allReplies[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(-7, -7),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(7, 7),
                            blurRadius: 8,
                            spreadRadius: -5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                reply.user,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Spacer(),
                              Text(
                                reply.timeCreated,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            reply.text,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
                ),
                if (widget.isLoggedIn) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Add a comment',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _textController,
                            decoration: const InputDecoration(
                              hintText: 'Write your comment...',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a comment';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final response = await request.postJson(
                                  "$device/forum/${widget.forum.id}/create-replies-flutter/",
                                  jsonEncode(<String, String>{
                                    'forum_id': widget.forum.id.toString(),
                                    'text': _textController.text,
                                  }),
                                );
                                if (context.mounted) {
                                  if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("Comment successfully added!"),
                                    ));
                                    fetchData(); // Reload replies to show the new comment
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("An error occurred, please try again."),
                                    ));
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Submit Comment'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  Padding(
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
                          TextSpan(text: ' to add a new reply.'), // Normal text
                        ],
                      ),
                    ),
                  )
                ]
              ]),
            ),
          ],
        ),
      // ),
    );
  }
}
