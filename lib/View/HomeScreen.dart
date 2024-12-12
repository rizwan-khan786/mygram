import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygram/View/Chats.dart';
import 'package:mygram/View/ProfileScreen.dart';
import 'package:mygram/View/Youtube.dart';

import 'ExplorerScreen.dart';
import 'HomeContent.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       
        body: Obx(() {
          switch (controller.selectedIndex.value) {
            case 0:
              return HomeContent();
            case 1:
              return ExploreScreen();
            case 2:
              return GifShortsPage();
              // return Center(child: _buildTextScreen('Clips Screen'));
            case 3:
              return ChatsPage();
              // return Center(child: _buildTextScreen('Chats Screen'));
            case 4:
              return ProfileScreen();
              // return Center(child: _buildTextScreen('Account Screen'));
            default:
              return ExploreScreen();
          }
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTabIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue, // Selected icon/text color
            unselectedItemColor: Colors.grey, // Unselected icon/text color
            showUnselectedLabels: true, // Keep unselected labels visible
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                activeIcon: Icon(Icons.home, color: Colors.blue),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                activeIcon: Icon(Icons.search, color: Colors.blue),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_fill),
                activeIcon: Icon(Icons.play_circle_fill, color: Colors.blue),
                label: 'Clips',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                activeIcon: Icon(Icons.chat, color: Colors.blue),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                activeIcon: Icon(Icons.account_circle, color: Colors.blue),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300], // Light grey background for the search bar
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          
          hintText: 'Search...',
          
          hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
          prefixIcon: const Icon(Icons.search, color: Colors.blue),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}