import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:rentall/widgets/widgets.dart';

import '../../../data/models/models.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: RentalsList(
        rentals: [
          Rental(
            userId: '',
            title: 'title',
            address: 'address',
            area: 100,
            governorate: Governorate.alexandria,
            price: 100,
            hostPhone: 'hostPhone',
            propertyType: PropertyType.apartment,
            createdAt: Timestamp.now(),
          )
        ],
      ),
    );
  }
}
