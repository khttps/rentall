import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'no_image.dart';

import '../data/models/rental.dart';
import '../screens/screens.dart';

class RentalCard extends StatelessWidget {
  final Rental rental;
  const RentalCard({required this.rental, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width / 3;
    final region = rental.region != null ? '${rental.region},' : '';

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: rental,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.0, 1.0),
              blurRadius: 3.0,
              color: Colors.grey.withOpacity(0.6),
            )
          ],
        ),
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rental.images.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: rental.images[0],
                    height: height,
                    width: height,
                    placeholder: (c, u) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    fit: BoxFit.cover,
                  )
                : NoImage(dimension: height),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 12.0,
                ),
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
                      '$region ${tr('governorates.${rental.governorate.index}')}',
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
                    const Spacer(),
                    Text(
                      '${rental.price} EGP / ${rental.rentPeriod?.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
