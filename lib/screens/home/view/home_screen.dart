import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/widgets.dart';
import '../../blocs.dart';
import '../../screens.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;
  final _screens = const [
    RentalsScreen(),
    NotificationsScreen(),
    MenuScreen(),
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadUser());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
            child: const SearchBar(enabled: false),
            onTap: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          ),
          actions: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    if (state is Authenticated) {
                      Navigator.pushNamed(context, AlertScreen.routeName);
                    } else {
                      Navigator.pushNamed(context, AuthScreen.routeName);
                    }
                  },
                  child: Column(
                    children: const [
                      Expanded(child: Icon(Icons.notification_add)),
                      Expanded(child: Text('Create Alert'))
                    ],
                  ),
                );
              },
            ),
            const SizedBox(width: 10.0)
          ],
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
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Expanded(
                    flex: 1,
                    child: FloatingActionButton(
                      mini: true,
                      elevation: 0,
                      child: const Icon(Icons.add),
                      onPressed: () {
                        if (state is UserWithHost) {
                          Navigator.pushNamed(context, PublishScreen.routeName);
                        } else if (state is UserOnly) {
                          Navigator.pushNamed(
                              context, OrganizationScreen.routeName);
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
