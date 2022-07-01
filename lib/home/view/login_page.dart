import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rentall/bloc/loginBloc/login_bloc.dart';
import 'package:rentall/bloc/loginBloc/login_event.dart';
import 'package:rentall/bloc/loginBloc/login_state.dart';
import 'package:rentall/data/repository/user_repository.dart';

class LoginPageMasrter extends StatelessWidget {
  late UserRepository userrepo;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(userrepo: userrepo),
      child: LoginPage(),
    );
    throw UnimplementedError();
  }
}

class LoginPage extends StatelessWidget {
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  late LoginBloc loginbloc;
  @override
  Widget build(BuildContext context) {
    loginbloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('SignIn')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Rentall",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.redAccent,
                )),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccessState) {
                  navigateToHomeScreen(context, state.user);
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginInitialState) {
                    return buildInitialUi();
                  } else if (state is LoginLoadingState) {
                    return buildLoadingUi();
                  } else if (state is LoginSuccessState) {
                    return Container();
                  } else if (state is LoginFailedState) {
                    return buildFailureUi(state.message);
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(0.5),
              child: TextField(
                controller: mailcontroller,
                decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: "E-mail",
                    hintText: "E-mail"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: TextField(
                controller: passcontroller,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Password",
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    color: Colors.cyan,
                    child: Text("SignIn"),
                    textColor: Colors.white,
                    onPressed: () async {
                      loginbloc.add(LoginButtonPressedEvent(
                          email: mailcontroller.text,
                          password: passcontroller.text));
                    },
                  ),
                ),
                const Text('Not a member?'),
                TextButton(
                  child: const Text('Sign Up',
                      style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          color: Colors.blue)),
                  onPressed: () {
                    //navigateToSignUpScreen(context);
                  },
                )
              ],
            ),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.google),
                  iconSize: 50,
                  color: Colors.redAccent,
                ),
                IconButton(
                  onPressed: () async {
                    loginbloc.add(LoginByGoogleEvent());
                  },
                  icon: Icon(Icons.facebook),
                  iconSize: 50,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

Widget buildInitialUi() {
  return Container(
    padding: EdgeInsets.all(5.0),
    child: Text(
      "Enter Login Credentials",
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.teal,
      ),
    ),
  );
}

Widget buildLoadingUi() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildFailureUi(String message) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(5.0),
        child: Text(
          "Fail $message",
          style: TextStyle(color: Colors.red),
        ),
      ),
      buildInitialUi(),
    ],
  );
}

void navigateToHomeScreen(BuildContext context, User user) {
  /*Navigator to home page*/
}

void navigateToSignUpScreen(BuildContext context) {
  /*Navigator to sign up page*/
}
