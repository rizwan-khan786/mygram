import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<Map<String, String>> privateChats = [
    {'name': 'John Doe', 'message': 'Hello, how are you?'},
    {'name': 'Jane Smith', 'message': 'Can we meet tomorrow?'},
  ];

  List<Map<String, String>> groupChats = [
    {'group': 'Flutter Devs', 'message': 'Next meeting is on Friday.'},
    {'group': 'Study Group', 'message': 'Don’t forget the assignment!'},
  ];

  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(_filterChats);
  }

  void _filterChats() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
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
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildChatsList(privateChats, 'name'),
                _buildChatsList(groupChats, 'group'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Center(
        child: Text(
          'Chats',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      bottom: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: 'Private'),
          Tab(text: 'Groups'),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
          hintText: 'Search Chats',
          hintStyle: TextStyle(color: Colors.blueAccent.withOpacity(0.6)),
          filled: true,
          fillColor: Colors.grey[300], // Use grey[300] color here
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildChatsList(List<Map<String, String>> chatData, String key) {
    List<Map<String, String>> filteredChats = chatData.where((chat) {
      if (_searchQuery.isEmpty) {
        return true;
      }
      return (chat.containsKey(key) &&
              chat[key]!.toLowerCase().contains(_searchQuery)) ||
          (chat['message']!.toLowerCase().contains(_searchQuery));
    }).toList();

    return ListView.builder(
      itemCount: filteredChats.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(filteredChats[index].containsKey(key)
                ? filteredChats[index][key]![0]
                : ''),
          ),
          title: Text(filteredChats[index].containsKey(key)
              ? filteredChats[index][key]!
              : ''),
          subtitle: Text(filteredChats[index]['message']!),
          onTap: () => _navigateToDetailsPage(filteredChats[index]),
        );
      },
    );
  }

  void _navigateToDetailsPage(Map<String, String> chatDetails) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          chatDetails: chatDetails,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _showEditDialog();
      },
      backgroundColor: Colors.blueAccent,
      child: Icon(Icons.edit),
    );
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add/Edit Chat',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 20),
                EditChatForm(onSave: (newChat) {
                  setState(() {
                    if (_tabController!.index == 0) {
                      privateChats.add(newChat);
                    } else {
                      groupChats.add(newChat);
                    }
                  });
                  Navigator.of(context).pop();
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EditChatForm extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  EditChatForm({required this.onSave});

  @override
  _EditChatFormState createState() => _EditChatFormState();
}

class _EditChatFormState extends State<EditChatForm> {
  late TextEditingController _nameController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name / Group Name',
            labelStyle: TextStyle(color: Colors.blueAccent),
            filled: true,
            fillColor: Colors.grey[300], // Use grey[300] color here
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _messageController,
          decoration: InputDecoration(
            labelText: 'Message',
            labelStyle: TextStyle(color: Colors.blueAccent),
            filled: true,
            fillColor: Colors.grey[300], // Use grey[300] color here
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Map<String, String> newChat = {
              'name': _nameController.text,
              'message': _messageController.text,
            };
            widget.onSave(newChat);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            elevation: 5, // Adding shadow for depth
            side: BorderSide(color: Colors.blueAccent, width: 2), // Border around the button
          ),
          child: Text(
            'Save Chat',
            style: TextStyle(
              fontSize: 18, // Larger text
              fontWeight: FontWeight.bold, // Bold text
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Map<String, String> chatDetails;

  DetailsPage({required this.chatDetails});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(chatDetails['name'] ?? chatDetails['group']!),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Name: ${chatDetails['name'] ?? chatDetails['group']}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Message: ${chatDetails['message']}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
