import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/screens/home/bloc/home_bloc.dart';
import 'package:rentall/screens/home/view/widgets/floating_action_menu.dart';

import '../../../widgets/widgets.dart';
import '../../blocs.dart';
import '../../screens.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  var _currentIndex = 0;
  final _screens = const [
    RentalsScreen(),
    NotificationsScreen(),
    MenuScreen(),
  ];

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadUser());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                  onTap: (index) {
                    _animationController.reset();
                    setState(() => _currentIndex = index);
                  },
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
                  child: AnimatedIcon(
                    icon: AnimatedIcons.add_event,
                    progress: _animation,
                  ),
                  onPressed: () {
                    _animationController.isCompleted
                        ? _animationController.reverse()
                        : _animationController.forward();
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return FloatingActionMenu(
              animation: _animation,
              items: [
                FloatingItem(
                  title: const Text(
                    'Create Alert',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(Icons.notification_add, color: Colors.white),
                  onPressed: () {
                    if (state is NoUser) {
                      Navigator.pushNamed(context, AuthScreen.routeName);
                    } else if (state is UserOnly || state is UserWithHost) {
                      Navigator.pushNamed(context, AlertScreen.routeName);
                    }
                  },
                ),
                FloatingItem(
                  title: const Text(
                    'Lodge',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(Icons.hotel, color: Colors.white),
                  onPressed: () {
                    if (state is NoUser) {
                      Navigator.pushNamed(context, AuthScreen.routeName);
                    } else if (state is UserOnly || state is UserWithHost) {
                      Navigator.pushNamed(context, AlertScreen.routeName);
                    }
                  },
                ),
                FloatingItem(
                  title: const Text(
                    'New Rental',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    if (state is UserWithHost) {
                      Navigator.pushNamed(context, PublishScreen.routeName);
                    } else if (state is UserOnly) {
                      Navigator.pushNamed(
                        context,
                        OrganizationScreen.routeName,
                      );
                    } else if (state is NoUser) {
                      Navigator.pushNamed(
                        context,
                        AuthScreen.routeName,
                      );
                    }
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
