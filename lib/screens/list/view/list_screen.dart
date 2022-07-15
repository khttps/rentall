import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/widgets/widgets.dart';

import '../bloc/list_bloc.dart';

class ListArguments {
  final String listName;
  final String? userId;

  const ListArguments({
    required this.listName,
    this.userId,
  });
}

class ListScreen extends StatefulWidget {
  static const routeName = '/list';
  final ListArguments args;

  const ListScreen({
    required this.args,
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
      LoadList(collection: widget.args.listName, userId: widget.args.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.args.listName).tr()),
      body: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          if (state.status == ListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == ListStatus.success &&
              state.rentals!.isNotEmpty) {
            return RentalsList(rentals: state.rentals!);
          } else {
            return const EmptyList();
          }
        },
      ),
    );
  }
}
