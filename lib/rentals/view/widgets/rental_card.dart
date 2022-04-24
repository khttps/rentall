import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../screens.dart';
import '../../../data/model/rental.dart';

class RentalCard extends StatelessWidget {
  final Rental rental;
  const RentalCard({required this.rental, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: rental,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0.0, 2.0),
              blurRadius: 3,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(3.0)),
              child: CachedNetworkImage(
                imageUrl: rental.images[0],
                placeholder: (c, u) => const Center(
                  child: CircularProgressIndicator(),
                ),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rental.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${rental.regionId}, '
                    '${tr('governorates.${rental.governorate}')}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    DateFormat('d MMM, yyyy').format(
                      rental.createdAt!.toDate(),
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
