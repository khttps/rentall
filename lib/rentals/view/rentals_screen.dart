import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs.dart';
import '../../data/model/governorate.dart';
import '../../data/model/property_type.dart';
import 'widgets/widgets.dart';

class RentalsScreen extends StatelessWidget {
  const RentalsScreen({Key? key}) : super(key: key);

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
          title: SizedBox(
            height: 42.0,
            child: BlocBuilder<RentalsBloc, RentalsState>(
              builder: (context, state) {
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  children: [
                    ActionChip(
                      avatar: const Icon(
                        Icons.expand_more,
                        color: Colors.black,
                        size: 20.0,
                      ),
                      label:
                          Text('governorates.${state.governorate.index}').tr(),
                      labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
                      onPressed: () async => await _showFiltersBottomSheet(
                        context,
                        itemCount: 28,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              BlocProvider.of<RentalsBloc>(context).add(
                                SetRegionFilter(
                                  governorate: Governorate.values[index],
                                ),
                              );
                              Navigator.pop(context);
                            },
                            title: Text(
                              'governorates.${Governorate.values[index].value}',
                            ).tr(),
                            contentPadding: const EdgeInsetsDirectional.only(
                              start: 8.0,
                            ),
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    ActionChip(
                      avatar: const Icon(
                        Icons.expand_more,
                        color: Colors.black,
                        size: 20.0,
                      ),
                      label: Text(
                        'propertyType.${state.type.value}',
                      ).tr(),
                      labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
                      onPressed: () async => await _showFiltersBottomSheet(
                        context,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              BlocProvider.of<RentalsBloc>(context).add(
                                SetPropertyTypeFilter(
                                  type: PropertyType.values[index],
                                ),
                              );
                              Navigator.pop(context);
                            },
                            title: Text(
                              'propertyType.${PropertyType.values[index].index}',
                            ).tr(),
                            contentPadding: const EdgeInsetsDirectional.only(
                              start: 8.0,
                            ),
                            dense: true,
                            visualDensity: VisualDensity.compact,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    ActionChip(
                        avatar: const Icon(
                          Icons.expand_more,
                          color: Colors.black,
                          size: 20.0,
                        ),
                        label: const Text(
                          'Price',
                        ),
                        labelPadding:
                            const EdgeInsetsDirectional.only(end: 8.0),
                        onPressed: () {}),
                    const SizedBox(width: 8.0),
                    ActionChip(
                        avatar: const Icon(
                          Icons.expand_more,
                          color: Colors.black,
                          size: 20.0,
                        ),
                        label: const Text(
                          'Sort',
                        ),
                        labelPadding:
                            const EdgeInsetsDirectional.only(end: 8.0),
                        onPressed: () {}),
                    const SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'More Filters',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<RentalsBloc>(context).add(const GetRentals());
        },
        child: BlocConsumer<RentalsBloc, RentalsState>(
          listener: (context, state) {
            if (state.status == LoadStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state.status == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if ((state.status == LoadStatus.success &&
                    state.rentals!.isNotEmpty) ||
                state.status == LoadStatus.reloading) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                itemCount: state.rentals!.length,
                separatorBuilder: (c, i) => const SizedBox(height: 8.0),
                itemBuilder: (context, index) {
                  return RentalCard(rental: state.rentals![index]);
                },
              );
            } else {
              return Stack(
                children: [
                  ListView(),
                  const Center(child: Text('Nothing to see here.')),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _showFiltersBottomSheet(
    BuildContext context, {
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
  }) =>
      showModalBottomSheet(
        context: context,
        builder: (c) => Container(
          constraints: const BoxConstraints(maxHeight: 350.0, minHeight: 180.0),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: itemCount,
            separatorBuilder: (c, i) => const Divider(height: 0),
            itemBuilder: itemBuilder,
          ),
        ),
      );
}
