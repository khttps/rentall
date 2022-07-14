import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rentall/screens/blocs.dart';
import 'package:rentall/widgets/error_snackbar.dart';
import 'package:rentall/widgets/loading_widget.dart';

import '../../screens.dart';
import 'widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/sign_in';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _pageController = PageController();
  final _screenController = ScrollController();

  @override
  void dispose() {
    _pageController.dispose();
    _screenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            _showSuccessSnackbar(context, message: 'Signed in successfully!');
          }
          if (state is SignUpSuccess) {
            _showSuccessSnackbar(context, message: 'Signed up successfully!');
          }
          if (state is EmailSent) {
            Navigator.pushNamed(
              context,
              PasswordSentScreen.routeName,
              arguments: state.email,
            );
          }
          if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackbar(message: state.message),
            );
          }
        },
        builder: (context, state) {
          return LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                ListView(
                  controller: _screenController,
                  children: [
                    Image.asset(
                      'assets/images/sign_in.png',
                      fit: BoxFit.cover,
                      height: constraints.maxWidth / 2,
                    ),
                    SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          AuthForm(
                            label: 'Sign In',
                            onSubmit: (value) {
                              BlocProvider.of<AuthBloc>(context).add(
                                SignInPressed(
                                  email: value['email'],
                                  password: value['password'],
                                ),
                              );
                            },
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _pageController.animateToPage(
                                    3,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                  _screenController.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: const Text(
                                  'Forgot Pasword',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _pageController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                  _screenController.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                          AuthForm(
                            label: 'Sign Up',
                            onSubmit: (value) {
                              BlocProvider.of<AuthBloc>(context).add(
                                SignUpPressed(
                                  email: value['email'],
                                  password: value['password'],
                                ),
                              );
                            },
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _pageController.animateToPage(
                                    0,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                  _screenController.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ],
                          ),
                          ForgotPasswordForm(
                            onSubmit: (email) {
                              if (email != null) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  ForgotPassword(
                                    email: email,
                                  ),
                                );
                              }
                              _pageController.animateToPage(
                                0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                              _screenController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                if (state is AuthLoading) const LoadingWidget()
              ],
            );
          });
        },
      ),
    );
  }

  void _showSuccessSnackbar(BuildContext context, {required String message}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      HomeScreen.routeName,
      (route) => false,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
