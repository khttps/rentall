import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomNavigationBar(
          elevation: 0,
          selectedFontSize: 8.0,
          unselectedFontSize: 0.0,
          iconSize: 26.0,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Rentalls',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: FloatingActionButton.small(
                elevation: 0,
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
        ),
      ),
    );
  }
}
