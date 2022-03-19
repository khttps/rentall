import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/src/data/enums/enums.dart';
import '../../data/models/models.dart';
import '../blocs.dart';

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
            backgroundColor: Colors.blueGrey.shade300,
            floating: true,
            snap: true,
            toolbarHeight: 48.0,
            forceElevated: true,
            titleSpacing: 0.0,
            title: SizedBox(
              height: 42.0,
              child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _FilterChip(
                      label: 'Region',
                      onPressed: () async => await _showRegionDialog(context),
                    ),
                    const SizedBox(width: 8.0),
                    _FilterChip(
                      label: 'Property Type',
                      onPressed: () async =>
                          await _showPropertyTypeDialog(context),
                    ),
                  ]),
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () async =>
              BlocProvider.of<RentalsBloc>(context).add(const GetRentals()),
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
                    return _Rental(rental: state.rentals[index]);
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

class _FilterChip extends StatelessWidget {
  final String label;
  final Function() onPressed;
  const _FilterChip({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
      avatar: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      label: Text(label),
      onPressed: onPressed,
    );
  }
}

class _Rental extends StatelessWidget {
  final Rental rental;
  const _Rental({required this.rental, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0.0, 1.0),
                blurRadius: 3,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(4.0)),
              child: CachedNetworkImage(
                imageUrl: rental.images[0],
                placeholder: (c, u) => const Center(
                  child: CircularProgressIndicator(),
                ),
                height: 180.0,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text(
                rental.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${rental.regionId}, ${rental.governorateId}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    DateFormat('d/M/yyyy').format(rental.createdAt!.toDate()),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
