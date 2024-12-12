import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygram/View/HomeScreen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/bgImage.jpeg',
      'title': 'Post',
      'description': 'Join us and share you life experience, Post picture and videos',
    },
    {
      'image': 'assets/2.jpeg',
      'title': 'Chat',
      'description': 'Have conversations with friends, with text, image, video, audio, gif, stickers etc messages',
    },
    {
      'image': 'assets/bgImage.jpeg',
      'title': 'Calls',
      'description': 'Audio and video to talk long with your friends and family',
    },
    {
      'image': 'assets/3.jpeg',
      'title': 'Live',
      'description': 'Go live with your followers to share.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for carousel
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return _buildOnboardingPage(
                imagePath: onboardingData[index]['image']!,
              );
            },
          ),

          // Indicator, Title, Description, and Sign In button at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                      (index) => _buildIndicator(index == _currentIndex),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      onboardingData[_currentIndex]['title']!,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.075, // Responsive font size
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  SizedBox(height: 8),

                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      onboardingData[_currentIndex]['description']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04, // Responsive font size
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Sign In button
                  InkWell(
                    onTap: () {
                      Get.offAll(HomeScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02,
                        horizontal: MediaQuery.of(context).size.width * 0.3, // Responsive width
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.05, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage({required String imagePath}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blueAccent : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
