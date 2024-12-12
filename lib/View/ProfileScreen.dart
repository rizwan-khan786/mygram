import 'dart:math';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final int postsCount = 20;
  final int followersCount = 150;
  final int followingCount = 120;

  final List<IconData> profileIcons = [
    Icons.star,
    Icons.thumb_up,
    Icons.face,
    Icons.access_alarm,
    Icons.bookmark,
    Icons.favorite,
    Icons.local_cafe,
    Icons.home,
    Icons.notifications,
    Icons.camera_alt,
  ];

  @override
  Widget build(BuildContext context) {
    final randomIcon = profileIcons[Random().nextInt(profileIcons.length)];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              print('Settings tapped');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Profile Picture with Random Icon
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade300,
                child: Icon(
                  randomIcon,
                  size: 40,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              // Username
              const Text(
                'rizwan4693',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              // Stats: Posts, Followers, Following
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStats(postsCount.toString(), 'Posts'),
                    _buildStats(followersCount.toString(), 'Followers'),
                    _buildStats(followingCount.toString(), 'Following'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Posts and Mentioned Tabs
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DefaultTabController(
                  length: 2,  // Two tabs: Posts and Mentions
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.post_add,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 8),
                                const Text('Posts'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.comment,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 8),
                                const Text('Mentions'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 250,
                        child: TabBarView(
                          children: [
                            _buildGridView('https://media.giphy.com/media/JIX9t2j0ZTN9S/giphy.gif'), // Posts
                            _buildGridView('https://media.giphy.com/media/fxsFVlXYIj9s/giphy.gif'), // Mentions
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStats(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildGridView(String gifUrl) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,  // 3 columns for the grid
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Image.network(
          gifUrl,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Your Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: 'Rizwan',
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: 'rizwan4693@gmail.com',
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: '+1234567890',
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print('Profile saved');
                },
                child: const Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
