import 'package:flutter/material.dart';

import '../data/models/rental.dart';
import 'widgets.dart';

class RentalsList extends StatelessWidget {
  final List<Rental> rentals;
  const RentalsList({required this.rentals, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      shrinkWrap: true,
      itemCount: rentals.length,
      separatorBuilder: (c, i) => const Divider(thickness: 1.0, height: 0.0),
      itemBuilder: (context, index) {
        return RentalCard(rental: rentals[index]);
      },
    );
  }
}
