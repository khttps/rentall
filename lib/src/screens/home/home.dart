import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
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
    Rentals(),
    Notifications(),
    SizedBox.shrink(),
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
        selectedFontSize: 8.0,
        unselectedFontSize: 8.0,
        elevation: 12.0,
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
            icon: FloatingActionButton(
              mini: true,
              elevation: 0,
              child: const Icon(Icons.add_rounded),
              onPressed: () {},
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
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
