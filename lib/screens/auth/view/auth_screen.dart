import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/sign_in';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blueGrey,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/sign_in.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                AuthForm(
                  label: 'Sign In',
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Pasword',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _controller.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                AuthForm(
                  label: 'Sign Up',
                  actions: [
                    TextButton(
                      onPressed: () {
                        _controller.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
