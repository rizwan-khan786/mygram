import 'package:flutter/material.dart';

class GifShortsPage extends StatelessWidget {
  final List<String> gifUrls = [
    'https://media.giphy.com/media/JIX9t2j0ZTN9S/giphy.gif',
    'https://media.giphy.com/media/3o6Zt5tG3Bz1lbjW6I/giphy.gif',
    'https://media.giphy.com/media/d31w3d4s5sXgFO/giphy.gif',
    'https://media.giphy.com/media/VxLz6bmR3YFPw/giphy.gif',
    'https://media.giphy.com/media/l0K4eU9z6jTT1jdZG/giphy.gif',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GIF Shorts'),
        backgroundColor: Colors.black,
      ),
      body: GifShortsList(gifUrls: gifUrls),
    );
  }
}

class GifShortsList extends StatelessWidget {
  final List<String> gifUrls;

  const GifShortsList({required this.gifUrls});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gifUrls.length,
      itemBuilder: (context, index) {
        return RandomGifCard(url: gifUrls[index]);
      },
    );
  }
}

class RandomGifCard extends StatefulWidget {
  final String url;

  const RandomGifCard({required this.url});

  @override
  _RandomGifCardState createState() => _RandomGifCardState();
}

class _RandomGifCardState extends State<RandomGifCard> {
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          // Display GIF
          Image.network(
            widget.url,
            width: double.infinity,
            height: screenHeight * 0.75, // Adjust height for GIF display
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Icon(Icons.error));
            },
          ),
          // Buttons for Like, Comment, and Share on the right
          Positioned(
            top: 0,
            right: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Like Button
                IconButton(
                  icon: Icon(Icons.thumb_up_alt_outlined, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      likeCount++;  // Increment like count
                    });
                    print('Liked: ${widget.url}, Total Likes: $likeCount');
                  },
                ),
                Text(
                  '$likeCount Likes',
                  style: TextStyle(color: Colors.white),
                ),
                // Comment Button
                IconButton(
                  icon: Icon(Icons.comment_outlined, color: Colors.white),
                  onPressed: () {
                    _showCommentDialog(context);
                  },
                ),
                // Share Button
                IconButton(
                  icon: Icon(Icons.share_outlined, color: Colors.white),
                  onPressed: () {
                    print('Shared: ${widget.url}');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to show a comment dialog
  void _showCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController commentController = TextEditingController();

        return AlertDialog(
          title: Text('Add a Comment'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: 'Enter your comment'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Post'),
              onPressed: () {
                // Handle posting the comment (e.g., save or print)
                print('Comment posted: ${commentController.text}');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
