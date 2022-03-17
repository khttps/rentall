import 'package:flutter/material.dart';
import 'package:rentall/src/widgets/widgets.dart';
import '../screens.dart';

class Home extends StatefulWidget {
  static const routeName = 'home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();
  var _currentIndex = 0;
  final _screens = const [
    // Categories(),
    Rentalls(),
    Notifications(),
    SizedBox.shrink(),
    Menu(),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Search()),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        iconSize: 28.0,
        elevation: 5.0,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.business_rounded),
            label: 'Rentalls',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.notifications_rounded),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: FloatingActionButton.small(
              elevation: 0,
              onPressed: () {},
              child: const Icon(Icons.add_rounded),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
