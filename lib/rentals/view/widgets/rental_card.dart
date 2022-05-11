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
              child: rental.images.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: rental.images[0],
                      placeholder: (c, u) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    )
                  : const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Colors.grey,
                      ),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rental.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${rental.region}, '
                      '${tr('governorates.${rental.governorate.index}')}',
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
