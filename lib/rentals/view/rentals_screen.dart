import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs.dart';
import '../../data/model/governorate.dart';
import '../../data/model/property_type.dart';
import '../../data/model/rent_period.dart';
import '../../widgets/widgets.dart';
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
                        itemCount: Governorate.values.length - 1,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              context.read<RentalsBloc>().add(SetRegionFilter(
                                    governorate: Governorate.values[index],
                                  ));
                              Navigator.pop(context);
                            },
                            title: Text(
                              'governorates.$index',
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
                        'propertyType.${state.type?.value == null ? null : state.type?.index}',
                      ).tr(),
                      labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
                      onPressed: () async => await _showFiltersBottomSheet(
                        context,
                        itemCount: PropertyType.values.length - 1,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              context.read<RentalsBloc>().add(
                                    SetPropertyTypeFilter(
                                      type: PropertyType.values[index],
                                    ),
                                  );
                              Navigator.pop(context);
                            },
                            title: Text(
                              'propertyType.$index',
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
                      label: Text(state.priceText),
                      labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
                      onPressed: () async => await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return PriceForm(
                            from: state.priceFrom,
                            to: state.priceTo,
                            onApply: (from, to) {
                              context.read<RentalsBloc>().add(
                                    SetPriceFilter(
                                      priceFrom: from,
                                      priceTo: to,
                                    ),
                                  );
                            },
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
                        'rentPeriod.${state.period?.value == null ? null : state.period?.index}',
                      ).tr(),
                      labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
                      onPressed: () async => await _showFiltersBottomSheet(
                        context,
                        itemCount: RentPeriod.values.length - 1,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              context.read<RentalsBloc>().add(
                                    SetPeriodFilter(
                                      period: RentPeriod.values[index],
                                    ),
                                  );
                              Navigator.pop(context);
                            },
                            title: Text(
                              'rentPeriod.$index',
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
          final bloc = context.read<RentalsBloc>()..add(const GetRentals());
          await bloc.stream.first;
        },
        child: BlocConsumer<RentalsBloc, RentalsState>(
          listener: (context, state) {
            if (state.status == RentalsLoadStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                ErrorSnackbar(message: state.error!),
              );
            }
          },
          builder: (context, state) {
            if (state.status == RentalsLoadStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if ((state.status == RentalsLoadStatus.success &&
                    state.rentals!.isNotEmpty) ||
                state.status == RentalsLoadStatus.reloading) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                shrinkWrap: true,
                itemCount: state.rentals!.length,
                separatorBuilder: (c, i) =>
                    const Divider(thickness: 1.0, height: 0.0),
                itemBuilder: (context, index) {
                  return RentalCard(rental: state.rentals![index]);
                },
              );
            } else {
              return const EmptyList();
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
          constraints: const BoxConstraints(maxHeight: 350.0),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: itemCount,
            separatorBuilder: (c, i) => const Divider(height: 0),
            itemBuilder: itemBuilder,
          ),
        ),
      );
}
