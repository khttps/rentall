import 'package:easy_localization/easy_localization.dart';
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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _screens = const [
    RentalsScreen(),
    MenuScreen(),
  ];

  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;
  late AnimationController _animationController;

  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(
      const LoadUser(),
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    )..addListener(() {
        setState(() {});
      });

    final curvedAnimation = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _animationController,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curvedAnimation);

    _colorAnimation = ColorTween(
      begin: Colors.grey.shade600,
      end: Colors.blueGrey,
    ).animate(curvedAnimation);
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
          centerTitle: true,
          title: InkWell(
            child: const SearchBar(enabled: false),
            onTap: () {
              _animationController.reset();
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
                flex: 2,
                child: BottomNavigationBar(
                  elevation: 0.0,
                  selectedFontSize: 0.0,
                  unselectedFontSize: 0.0,
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
                      icon: Icon(Icons.home),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: '',
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    color: _colorAnimation.value,
                    progress: _animation,
                    size: 30.0,
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
                    'map',
                    style: TextStyle(color: Colors.white),
                  ).tr(),
                  icon: const Icon(Icons.map, color: Colors.white),
                  onPressed: () {
                    _animationController.reset();
                    Navigator.pushNamed(context, MapScreen.routeName);
                  },
                ),
                FloatingItem(
                  title: const Text(
                    'new_rental',
                    style: TextStyle(color: Colors.white),
                  ).tr(),
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    _animationController.reset();
                    if (state is UserWithHost) {
                      Navigator.pushNamed(context, PublishScreen.routeName);
                    } else if (state is UserOnly ||
                        state is UserOnlyEmailUnverified) {
                      Navigator.pushNamed(
                        context,
                        HostScreen.routeName,
                      );
                    } else if (state is NoUser) {
                      Navigator.pushNamed(
                        context,
                        AuthScreen.routeName,
                      );
                    }
                    // else if (state is UserOnlyEmailUnverified) {
                    //   Navigator.pushNamed(
                    //     context,
                    //     VerifyEmailScreen.routeName,
                    //     arguments: false,
                    //   );
                    // }
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
