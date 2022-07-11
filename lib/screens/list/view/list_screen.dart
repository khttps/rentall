import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/injector.dart';
import 'package:rentall/widgets/widgets.dart';

import '../bloc/list_bloc.dart';

class ListScreen extends StatelessWidget {
  static const routeName = '/favorites';
  final String listName;
  const ListScreen({
    required this.listName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListBloc>(
      create: (context) => sl()
        ..add(
          LoadList(collection: listName.toLowerCase()),
        ),
      child: Scaffold(
        appBar: AppBar(title: Text(listName)),
        body: BlocBuilder<ListBloc, ListState>(
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
      ),
    );
  }
}
