import 'package:flutter/material.dart';

import '../../screens.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;
  final _screens = [
    RentalsScreen(),
    Center(child: Text('Notifications')),
    Center(child: Text('Menu')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBar(),
        elevation: 2.0,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(1.0, 2.0),
              blurRadius: 5,
            )
          ],
        ),
        padding: const EdgeInsetsDirectional.only(end: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: BottomNavigationBar(
                elevation: 0.0,
                selectedFontSize: 8.0,
                unselectedFontSize: 8.0,
                iconSize: 30.0,
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Rentalls',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Menu',
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: FloatingActionButton(
                mini: true,
                elevation: 0,
                child: const Icon(Icons.add),
                onPressed: () =>
                    Navigator.pushNamed(context, PublishScreen.routeName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
