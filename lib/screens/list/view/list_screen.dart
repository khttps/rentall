import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/widgets/widgets.dart';

import '../bloc/list_bloc.dart';

class ListScreen extends StatefulWidget {
  static const routeName = '/list';
  final String listName;
  const ListScreen({
    required this.listName,
    Key? key,
  }) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListBloc>(context).add(
      LoadList(collection: widget.listName.toLowerCase()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.listName)),
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
    );
  }
}
