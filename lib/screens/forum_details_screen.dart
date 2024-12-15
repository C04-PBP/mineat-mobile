import 'package:flutter/material.dart';
import 'package:mineat/api/forumKhusus_service.dart';

class ForumDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> forum;
  final String backgroundImage;

  const ForumDetailsScreen(
      {Key? key, required this.forum, required this.backgroundImage})
      : super(key: key);

  @override
  State<ForumDetailsScreen> createState() => _ForumDetailsScreenState();
}

class _ForumDetailsScreenState extends State<ForumDetailsScreen> {
  late ScrollController _scrollController;
  bool _showAppBarTitle = false;

  List<Map<String, dynamic>> replies = [];
  final _replyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
  }

  Future<void> fetchData() async {
    // await ForumKhususService.fetchForumKhususData();

    final forumKhususs = ForumKhususService.getForumKhususData();

    if (forumKhususs!.isNotEmpty) {
      setState(() {
        replies = forumKhususs;
        isLoading = false;
      });
    } else {
      print('Error: ForumKhusus data is null or not found');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _replyController.dispose();
    super.dispose();
  }

  
  void _addReply(String text) {
    final newReply = {
      "user": "Anonymous", // Bisa diganti dengan username pengguna yang login
      "text": text,
      "time_created": DateTime.now().toString().split(' ')[0], // Format tanggal
    };

    setState(() {
      replies.insert(0, newReply); // Tambahkan komentar di posisi teratas
    });

    _replyController.clear(); // Bersihkan field input
  }


  @override
  Widget build(BuildContext context) {
    // final List<Map<String, String>> dummyReplies = [
    //   {
    //     "user": "Ava",
    //     "text": "I totally agree with you!",
    //     "time_created": "2024, 10, 10"
    //   },
    //   {
    //     "user": "John",
    //     "text": "I had a different experience, but that's valid.",
    //     "time_created": "2024, 10, 11"
    //   },
    //   {
    //     "user": "Maria",
    //     "text": "Thanks for sharing your thoughts!",
    //     "time_created": "2024, 10, 12"
    //   },
    //   {
    //     "user": "Leo",
    //     "text": "I want to try this dish now!",
    //     "time_created": "2024, 10, 13"
    //   },
    //   {
    //     "user": "Emily",
    //     "text": "The topic is interesting, thank you!",
    //     "time_created": "2024, 10, 14"
    //   },
    // ];

    return Hero(
      tag: widget.forum['title'],
      child: Scaffold(
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
                      widget.forum['title'],
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
                        widget.forum['title'],
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
                              widget.forum['user']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${widget.forum['time_created']}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.forum['text']!,
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
                  itemCount: replies.length,
                  itemBuilder: (context, index) {
                    final reply = replies[index];
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
                                reply['user']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${reply['time_created']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            reply['text']!,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  },
                ),
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
                          controller: _replyController,
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _addReply(_replyController.text);
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
