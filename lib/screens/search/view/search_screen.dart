import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBar(),
        elevation: 2.0,
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (c, i) => const Divider(thickness: 1.0),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Title'),
            // leading: CachedNetworkImage(imageUrl: ''),
            onTap: () {},
          );
        },
      ),
    );
  }
}
