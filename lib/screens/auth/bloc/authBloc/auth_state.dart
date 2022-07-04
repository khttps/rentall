import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {}

// 3 states
// 1- for initial state
// 2- for authenticated user
// 3- for unauthenticated user

class AuthInitialState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AuthenticatedState extends AuthState {
  User? user;

  AuthenticatedState({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UnauthenticatedState extends AuthState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
