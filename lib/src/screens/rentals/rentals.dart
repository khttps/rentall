import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/src/screens/rentals/widgets/filters_bar.dart';
import '../blocs.dart';
import 'widgets/rental_card.dart';

class Rentals extends StatelessWidget {
  const Rentals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (c, i) => [
        SliverAppBar(
          snap: true,
          floating: true,
          titleSpacing: 0.0,
          toolbarHeight: 48.0,
          forceElevated: true,
          backgroundColor: Colors.blueGrey.shade300,
          title: const FiltersBar(),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<RentalsBloc>(context).add(
            const FilterRentals(),
          );
        },
        child: BlocConsumer<RentalsBloc, RentalsState>(
          listener: ((context, state) {
            if (state.status == LoadStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error!)),
              );
            }
          }),
          builder: (context, state) {
            if (state.status == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == LoadStatus.loaded) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                shrinkWrap: true,
                itemCount: state.rentals!.length,
                separatorBuilder: (c, i) => const SizedBox(height: 8.0),
                itemBuilder: (context, index) {
                  return RentalCard(rental: state.rentals![index]);
                },
              );
            } else {
              return const Center(child: Text('Nothing to see here.'));
            }
          },
        ),
      ),
    );
  }
}
