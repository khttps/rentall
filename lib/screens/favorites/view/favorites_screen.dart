import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/screens/favorites/bloc/favorites_bloc.dart';

import 'package:rentall/widgets/widgets.dart';

import '../../../data/models/models.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state.status == FavouritesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == FavouritesStatus.success &&
              state.favourites!.isNotEmpty) {
            return RentalsList(rentals: state.favourites!);
          } else {
            return const EmptyList();
          }
        },
      ),
    );
  }
}
