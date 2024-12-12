import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _allTitles = [
    'Story', 'Highlights', 'Live Users', 'Competition', 'Clubs', 'Stranger Chat', 'TV', 'Podcast'
  ];
  late List<String> _filteredTitles;

  // Define a map for icons associated with each title
  final Map<String, IconData> _titleIcons = {
    'Story': Icons.book,
    'Highlights': Icons.star,
    'Live Users': Icons.people,
    'Competition': Icons.price_change,
    'Clubs': Icons.group,
    'Stranger Chat': Icons.chat,
    'TV': Icons.tv,
    'Podcast': Icons.headset,
  };

  @override
  void initState() {
    super.initState();
    _filteredTitles = _allTitles; // Initialize filtered titles with all titles
    _searchController.addListener(_filterTiles); // Add listener to handle search input changes
  }

  // Filter titles based on search query
  void _filterTiles() {
    setState(() {
      _filteredTitles = _allTitles
          .where((title) => title.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: _buildSearchBar(), // Search Bar on Top
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: _filteredTitles.map((title) {
            return _buildTile(_titleIcons[title]!, title); // Pass the correct icon for each title
          }).toList(),
        ),
      ),
    );
  }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _searchController,
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

  // Tile Widget for Grid
  Widget _buildTile(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
