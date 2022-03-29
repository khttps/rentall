import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';

class FiltersBar extends StatelessWidget {
  const FiltersBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                label: Text('governorates.${state.governorateId}').tr(),
                labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
                onPressed: () async => await _showFiltersBottomSheet(
                  context,
                  itemCount: 28,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        BlocProvider.of<RentalsBloc>(context)
                            .add(const ClearRegionFilter());
                        Navigator.pop(context);
                      },
                      title: Text('governorates.$index').tr(),
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
                  'propertyType.${state.propertyType?.index}',
                ).tr(),
                labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
                onPressed: () async => await _showFiltersBottomSheet(
                  context,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: Text('propertyType.$index').tr(),
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
                  labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
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
                  labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
                  onPressed: () {}),
              const SizedBox(width: 8.0),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'More Filters',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          );
        },
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
