  // final rentals = [
  //   Rental(
  //     title: 'Ocean View in Dahab',
  //     address: '43 Dahab Street',
  //     images: const [
  //       'https://i.imgur.com/K39uR6o.jpeg',
  //       'https://i.imgur.com/F2QL5Pn.jpeg',
  //       'https://i.imgur.com/XdGiI.jpeg'
  //     ],
  //     area: 80,
  //     governorate: Governorate.southSinai,
  //     price: 250,
  //     hostPhone: '01143322567',
  //     createdAt: Timestamp.now(),
  //     propertyType: PropertyType.vacationHome,
  //     rentPeriod: RentPeriod.day,
  //   ),
  //   // Giza
  //   Rental(
  //     title: 'Roof Studio near Metro Station',
  //     description: 'Very nice studio',
  //     images: const [
  //       'https://i.imgur.com/K39uR6o.jpeg',
  //       'https://i.imgur.com/F2QL5Pn.jpeg',
  //       'https://i.imgur.com/XdGiI.jpeg'
  //     ],
  //     address: '3 Salah Salem',
  //     floorNumber: 6,
  //     rooms: 1,
  //     bathrooms: 1,
  //     furnished: true,
  //     area: 70,
  //     governorate: Governorate.giza,
  //     price: 1200,
  //     hostPhone: '01114400675',
  //     createdAt: Timestamp.fromDate(DateTime.parse('2022-04-15')),
  //     rentPeriod: RentPeriod.month,
  //     propertyType: PropertyType.apartment,
  //   ),
  //   Rental(
  //     title: 'Apartment in Faisal for Rent',
  //     description: 'Very nice apartment',
  //     images: const [
  //       'https://i.imgur.com/K39uR6o.jpeg',
  //       'https://i.imgur.com/F2QL5Pn.jpeg',
  //       'https://i.imgur.com/XdGiI.jpeg'
  //     ],
  //     address: '32 Eshreen Street',
  //     floorNumber: 13,
  //     rooms: 3,
  //     bathrooms: 1,
  //     furnished: true,
  //     area: 130,
  //     governorate: Governorate.giza,
  //     price: 3500,
  //     hostPhone: '010003344675',
  //     createdAt: Timestamp.fromDate(DateTime.parse('2022-05-01')),
  //     rentPeriod: RentPeriod.month,
  //     propertyType: PropertyType.apartment,
  //   ),
  //   Rental(
  //     title: 'Store in Dokki',
  //     address: '44 Mossadak Street',
  //     images: const [
  //       'https://i.imgur.com/K39uR6o.jpeg',
  //       'https://i.imgur.com/F2QL5Pn.jpeg',
  //       'https://i.imgur.com/XdGiI.jpeg'
  //     ],
  //     floorNumber: 0,
  //     bathrooms: 1,
  //     area: 50,
  //     governorate: Governorate.giza,
  //     price: 3000,
  //     hostPhone: '01033445566',
  //     createdAt: Timestamp.fromDate(DateTime.parse('2022-04-22')),
  //     rentPeriod: RentPeriod.month,
  //     propertyType: PropertyType.retailStore,
  //   ),
  //   // Cairo
  //   Rental(
  //     title: 'Roof Studio near Metro Station',
  //     description: 'Very nice studio',
  //     images: const [
  //       'https://i.imgur.com/K39uR6o.jpeg',
  //       'https://i.imgur.com/F2QL5Pn.jpeg',
  //       'https://i.imgur.com/XdGiI.jpeg'
  //     ],
  //     address: '3 Salah Salem',
  //     floorNumber: 6,
  //     rooms: 1,
  //     bathrooms: 1,
  //     furnished: true,
  //     area: 70,
  //     governorate: Governorate.cairo,
  //     price: 1200,
  //     hostPhone: '01114400675',
  //     createdAt: Timestamp.fromDate(DateTime.parse('2022-04-15')),
  //     rentPeriod: RentPeriod.month,
  //     propertyType: PropertyType.apartment,
  //   ),
  //   Rental(
  //     title: 'Apartment in Faisal for Rent',
  //     description: 'Very nice apartment',
  //     images: const [
  //       'https://i.imgur.com/K39uR6o.jpeg',
  //       'https://i.imgur.com/F2QL5Pn.jpeg',
  //       'https://i.imgur.com/XdGiI.jpeg'
  //     ],
  //     address: '32 Eshreen Street',
  //     floorNumber: 13,
  //     rooms: 3,
  //     bathrooms: 1,
  //     furnished: true,
  //     area: 130,
  //     governorate: Governorate.cairo,
  //     price: 3500,
  //     hostPhone: '010003344675',
  //     createdAt: Timestamp.fromDate(DateTime.parse('2022-05-01')),
  //     rentPeriod: RentPeriod.month,
  //     propertyType: PropertyType.apartment,
  //   ),
  //   Rental(
  //     title: 'Store in Dokki',
  //     address: '44 Mossadak Street',
  //     images: const [
  //       'https://i.imgur.com/K39uR6o.jpeg',
  //       'https://i.imgur.com/F2QL5Pn.jpeg',
  //       'https://i.imgur.com/XdGiI.jpeg'
  //     ],
  //     floorNumber: 0,
  //     bathrooms: 1,
  //     area: 50,
  //     governorate: Governorate.cairo,
  //     price: 3000,
  //     hostPhone: '01033445566',
  //     createdAt: Timestamp.fromDate(DateTime.parse('2022-04-22')),
  //     rentPeriod: RentPeriod.month,
  //     propertyType: PropertyType.retailStore,
  //   ),
  //   Rental(
  //     title: 'Roof Studio near Metro Station',
  //     description: 'Very nice studio',
  //     images: const [
  //       'https://i.imgur.com/K39uR6o.jpeg',
  //       'https://i.imgur.com/F2QL5Pn.jpeg',
  //       'https://i.imgur.com/XdGiI.jpeg'
  //     ],
  //     address: '3 Salah Salem',
  //     floorNumber: 6,
  //     rooms: 1,
  //     bathrooms: 1,
  //     furnished: true,
  //     area: 70,
  //     governorate: Governorate.cairo,
  //     price: 1200,
  //     hostPhone: '01114400675',
  //     createdAt: Timestamp.fromDate(DateTime.parse('2022-04-15')),
  //     rentPeriod: RentPeriod.month,
  //     propertyType: PropertyType.apartment,
  //   ),
  //   Rental(
  //     title: 'Apartment in Faisal for Rent',
  //     description: 'Very nice apartment',
  //     images: const [
  //       'https://i.imgur.com/K39uR6o.jpeg',
  //       'https://i.imgur.com/F2QL5Pn.jpeg',
  //       'https://i.imgur.com/XdGiI.jpeg'
  //     ],
  //     address: '32 Eshreen Street',
  //     floorNumber: 13,
  //     rooms: 3,
  //     bathrooms: 1,
  //     furnished: true,
  //     area: 130,
  //     governorate: Governorate.cairo,
  //     price: 3500,
  //     hostPhone: '010003344675',
  //     createdAt: Timestamp.fromDate(DateTime.parse('2022-05-01')),
  //     rentPeriod: RentPeriod.month,
  //     propertyType: PropertyType.apartment,
  //   ),
  //   Rental(
  //     title: 'Store in Dokki',
  //     address: '44 Mossadak Street',
  //     images: const [
  //       'https://i.imgur.com/K39uR6o.jpeg',
  //       'https://i.imgur.com/F2QL5Pn.jpeg',
  //       'https://i.imgur.com/XdGiI.jpeg'
  //     ],
  //     floorNumber: 0,
  //     bathrooms: 1,
  //     area: 50,
  //     governorate: Governorate.cairo,
  //     price: 3000,
  //     hostPhone: '01033445566',
  //     createdAt: Timestamp.fromDate(DateTime.parse('2022-04-22')),
  //     rentPeriod: RentPeriod.month,
  //     propertyType: PropertyType.retailStore,
  //   )
  // ].map((e) => e.toJson());

  // final colRef = FirebaseFirestore.instance.collection('rentals');

  // for (var element in rentals) {
  //   await colRef.add(element);
  // }