// The code imports necessary packages and files for the Flutter application.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'gridview_menu.dart';
import 'listview_balance.dart';

// This is the HomePage class, which extends StatefulWidget. It represents the home page of the app and takes a savedEmail parameter. It creates a state object _HomePageState.

class HomePage extends StatefulWidget {
  const HomePage(this.savedEmail, {super.key});
  final String? savedEmail;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String? name;
  SharedPreferences? sharedPreferences;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('user')
        .where('email', isEqualTo: widget.savedEmail)
        .limit(1)
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.docs;

    if (documents.isNotEmpty) {
      Map<String, dynamic> data = documents[0].data();
      isLoaded = true;
      name = data['name'];
    }
  }

  // This is the state class _HomePageState for the HomePage widget. It holds the current index of the bottom navigation bar (_currentIndex), the user's name (name), a SharedPreferences instance (sharedPreferences), and a flag to track if data is loaded (isLoaded).
  // The initState method is overridden to call the getData method, which retrieves user data from Firestore based on the saved email.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          UserBalances(name),
          const UserMenu(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        elevation: 5.0,
        backgroundColor: Colors.purple[400],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        iconSize: 24,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      ),
    );
  }
}

// The build method builds the UI for the HomePage widget. It returns a Scaffold widget with an IndexedStack as the body, which displays either UserBalances or UserMenu based on the _currentIndex value.

// The bottomNavigationBar property sets up a BottomNavigationBar widget with navigation items, which allow switching between different pages. The _currentIndex is updated when an item is tapped.

// Overall, this code sets up the home page of an app with a bottom navigation bar and two different views based on the