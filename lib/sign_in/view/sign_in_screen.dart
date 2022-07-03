import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rentall/sign_in/view/widgets/widgets.dart';

import '../../menu/view/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign_in';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              physics: NeverScrollableScrollPhysics(),
              children: [
                SignInForm(
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
                SignInForm(
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
