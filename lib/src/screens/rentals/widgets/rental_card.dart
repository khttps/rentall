import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../data/models/models.dart';
import '../../screens.dart';

class RentalCard extends StatelessWidget {
  final Rental rental;
  const RentalCard({required this.rental, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        RentalDetails.routeName,
        arguments: rental,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0.0, 1.0),
              blurRadius: 3,
            )
          ],
        ),
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
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${rental.regionId}, ${tr('governorates.${rental.governorateId}')}',
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
