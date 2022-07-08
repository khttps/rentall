import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/widgets.dart';
import '../../blocs.dart';
import '../../screens.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SearchBar(
          prefix: InkWell(
            child: const Icon(Icons.arrow_back),
            onTap: () => Navigator.pop(context),
          ),
          enabled: true,
          onChanged: (value) => BlocProvider.of<SearchBloc>(context).add(
            SearchStarted(keyword: value),
          ),
        ),
        elevation: 2.0,
      ),
      body: BlocConsumer<SearchBloc, SearchState>(listener: (context, state) {
        if (state.status == SearchStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            ErrorSnackbar(message: state.message!),
          );
        }
      }, builder: (context, state) {
        if (state.status == SearchStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == SearchStatus.loaded) {
          final results = state.results!;
          return ListView.separated(
            padding: const EdgeInsets.all(4.0),
            itemCount: results.length,
            separatorBuilder: (c, i) => const Divider(thickness: 1.0),
            itemBuilder: (context, index) {
              final result = results[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: result.images.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: result.images[0],
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                      )
                    : const NoImage(dimension: 20.0),
                title: Text(result.title),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments: result,
                  );
                },
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
