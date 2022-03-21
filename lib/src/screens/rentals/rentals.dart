import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/enums/enums.dart';
import '../blocs.dart';
import 'widgets/filter_action_chip.dart';
import 'widgets/rental_card.dart';

class Rentals extends StatelessWidget {
  const Rentals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => BlocProvider.of<RentalsBloc>(context).add(
        const GetRentals(),
      ),
      child: NestedScrollView(
        headerSliverBuilder: (c, i) => [
          SliverAppBar(
            snap: true,
            floating: true,
            titleSpacing: 0.0,
            toolbarHeight: 48.0,
            forceElevated: true,
            backgroundColor: Colors.blueGrey.shade300,
            title: SizedBox(
              height: 42.0,
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    FilterActionChip(
                      label: 'Region',
                      onPressed: _showRegionDialog,
                    ),
                    const SizedBox(width: 8.0),
                    FilterActionChip(
                      label: 'Property Type',
                      onPressed: _showPropertyTypeDialog,
                    ),
                  ]),
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<RentalsBloc>(context).add(
              const GetRentals(),
            );
          },
          child: BlocBuilder<RentalsBloc, RentalsState>(
            builder: (context, state) {
              if (state is RentalsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is RentalsLoaded) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: state.rentals.length,
                  itemBuilder: (context, index) {
                    return RentalCard(rental: state.rentals[index]);
                  },
                );
              } else {
                return const Center(child: Text('Error'));
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showRegionDialog(BuildContext context) async => showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text('Choose Region'),
          children: List.generate(
            27,
            (index) => SimpleDialogOption(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('governorates.${index + 1}').tr(),
                  const Divider(color: Colors.black45),
                ],
              ),
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<RentalsBloc>(context).add(
                  GetRentals(governorateId: index + 1),
                );
              },
            ),
          ),
        ),
      );

  Future<void> _showPropertyTypeDialog(BuildContext context) async =>
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text('Choose Property Type'),
          children: List.generate(
            PropertyType.values.length - 1,
            (index) => SimpleDialogOption(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('propertyType.${index + 1}').tr(),
                  const Divider(color: Colors.black45),
                ],
              ),
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<RentalsBloc>(context).add(
                  GetRentals(propertyType: PropertyType.values[index]),
                );
              },
            ),
          ),
        ),
      );
}
