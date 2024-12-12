import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int selectedIndex = 0; // Track selected tab

  void _onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/01.png'), 
        ),
        title: const Text(
          'MyGram',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.black),
            tooltip: "Add Post",
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            tooltip: "Notifications",
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print("Selected: $value");
            },
            icon: const Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: "Profile", child: Text("Profile")),
                PopupMenuItem(value: "Settings", child: Text("Settings")),
                PopupMenuItem(value: "Logout", child: Text("Logout")),
              ];
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabBarButton('All', 0),
                _buildTabBarButton('Following', 1),
                _buildTabBarButton('Videos', 2),
              ],
            ),
          ),
        ),
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.add, size: 30, color: Colors.black),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Your Story',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(height: 1, color: Colors.grey[300]),
            _buildPost(
              username: "Rizu2250",
              avatarInitial: "K",
              postImageUrl: 'https://www.fightersgeneration.com/nf2/char/dbfz/goku-ssb/goku-super-saiyan-blue-anime.gif',
              caption: "Goku UltraInstinct",
            ),
            _buildPost(
              username: "Kishore ",
              avatarInitial: "J",
              postImageUrl: 'https://media2.giphy.com/media/U3UP4fTE6QfuoooLaC/source.gif',
              caption: "Goku UltraInstinct Max!",
            ),
          ],
        ),
      ),
    );
  }

  // TabBar Button Widget
  Widget _buildTabBarButton(String label, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Post Widget
  Widget _buildPost({
    required String username,
    required String avatarInitial,
    required String postImageUrl,
    required String caption,
  }) {
    return Post(
      username: username,
      avatarInitial: avatarInitial,
      postImageUrl: postImageUrl,
      caption: caption,
    );
  }
}

class Post extends StatefulWidget {
  final String username;
  final String avatarInitial;
  final String postImageUrl;
  final String caption;

  Post({
    required this.username,
    required this.avatarInitial,
    required this.postImageUrl,
    required this.caption,
  });

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  int likeCount = 0;
  int commentCount = 0;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Text(widget.avatarInitial),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(widget.username, style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              print("Post action: $value");
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: "Edit", child: Text("Edit")),
                PopupMenuItem(value: "Delete", child: Text("Delete")),
                PopupMenuItem(value: "Share", child: Text("Share")),
              ];
            },
          ),
        ),
        Image.network(
          widget.postImageUrl,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.caption,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
        Divider(height: 1, color: Colors.grey[300]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Like Button
              IconButton(
                onPressed: () {
                  setState(() {
                    isLiked = !isLiked; // Toggle like status
                    likeCount = isLiked ? likeCount + 1 : likeCount - 1;
                  });
                },
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black,
                ),
              ),
              Text('$likeCount', style: TextStyle(color: Colors.black)),
              // Comment Button
              IconButton(
                onPressed: () {
                  // Navigate to comments page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CommentPage()),
                  );
                },
                icon: Icon(Icons.comment_outlined, color: Colors.black),
              ),
              Text('$commentCount', style: TextStyle(color: Colors.black)),
              IconButton(
                onPressed: () {
                  print("Share tapped");
                },
                icon: Icon(Icons.share_outlined, color: Colors.black),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: Colors.grey[300]),
      ],
    );
  }
}

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();
  List<String> comments = []; // List to store comments

  void _addComment(String comment) {
    setState(() {
      comments.add(comment); // Add comment to the list
      _commentController.clear(); // Clear the text field
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Comments',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                        title: Text(
                          comments[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.blue),
                      onPressed: () {
                        if (_commentController.text.isNotEmpty) {
                          _addComment(_commentController.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
