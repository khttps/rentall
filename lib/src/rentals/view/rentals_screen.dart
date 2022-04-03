import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/bloc.dart';
import '../data/data.dart';
import 'widgets/widgets.dart';

class RentalsScreen extends StatelessWidget {
  const RentalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RentalsBloc>(
      builder: (context, bloc, widget) {
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
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  children: [
                    StreamBuilder<int?>(
                        stream: bloc.region,
                        builder: (context, snapshot) {
                          return ActionChip(
                            avatar: const Icon(
                              Icons.expand_more,
                              color: Colors.black,
                              size: 20.0,
                            ),
                            label: Text('governorates.${snapshot.data}').tr(),
                            labelPadding:
                                const EdgeInsetsDirectional.only(end: 8.0),
                            onPressed: () async =>
                                await _showFiltersBottomSheet(
                              context,
                              itemCount: 28,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    bloc.add(
                                      index == 0
                                          ? const ClearRegionFilter()
                                          : FilterRentalsByRegion(
                                              governorateId: index),
                                    );
                                    Navigator.pop(context);
                                  },
                                  title: Text('governorates.$index').tr(),
                                  contentPadding:
                                      const EdgeInsetsDirectional.only(
                                    start: 8.0,
                                  ),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                );
                              },
                            ),
                          );
                        }),
                    const SizedBox(width: 4.0),
                    StreamBuilder<RentalType?>(
                        stream: bloc.type,
                        builder: (context, snapshot) {
                          return ActionChip(
                            avatar: const Icon(
                              Icons.expand_more,
                              color: Colors.black,
                              size: 20.0,
                            ),
                            label: Text(
                              'propertyType.${snapshot.data?.index}',
                            ).tr(),
                            labelPadding:
                                const EdgeInsetsDirectional.only(end: 8.0),
                            onPressed: () async =>
                                await _showFiltersBottomSheet(
                              context,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    bloc.add(
                                      index == 0
                                          ? const ClearPropertyTypeFilter()
                                          : FilterRentalsByPropertyType(
                                              type: RentalType.values[index],
                                            ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  title: Text('propertyType.$index').tr(),
                                  contentPadding:
                                      const EdgeInsetsDirectional.only(
                                    start: 8.0,
                                  ),
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                );
                              },
                            ),
                          );
                        }),
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
                        ))
                  ],
                ),
              ),
            ),
          ],
          body: RefreshIndicator(
            onRefresh: () async {
              bloc.add(const GetRentals());
            },
            child: StreamBuilder<BlocState>(
              stream: bloc.rentals,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.status == LoadStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state?.status == LoadStatus.loaded) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8.0),
                    shrinkWrap: true,
                    itemCount: state?.data!.length,
                    separatorBuilder: (c, i) => const SizedBox(height: 8.0),
                    itemBuilder: (context, index) {
                      return RentalCard(rental: state?.data![index]);
                    },
                  );
                } else {
                  return ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      const Center(child: Text('Nothing to see here.')),
                    ],
                  );
                }
              },
            ),
          ),
        );
      },
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
