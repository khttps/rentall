import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/screens/details/bloc/details_bloc.dart';
import 'package:rentall/screens/details/view/widgets/top_shadow.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/models.dart';
import '../../../widgets/widgets.dart';
import '../../screens.dart';
import 'widgets/widgets.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = '/details';

  final Rental rental;
  const DetailsScreen({required this.rental, Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _controller = PageController();
  int _current = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailsBloc>(context).add(
      CheckCurrentUser(rental: widget.rental),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rental = widget.rental;
    final hasDescription =
        rental.description != null && rental.description!.isNotEmpty;
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              if (state.status == DetailsStatus.owned)
                IconButton(
                  icon: const Icon(Icons.drive_file_rename_outline_sharp),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      PublishScreen.routeName,
                      arguments: rental,
                    );
                  },
                ),
              if (state.status != DetailsStatus.owned)
                IconButton(
                  onPressed: () {
                    if (state.status == DetailsStatus.loggedOut) {
                      Navigator.pushNamed(context, AuthScreen.routeName);
                    } else {
                      BlocProvider.of<DetailsBloc>(context).add(
                        state.isFavorited
                            ? RemoveFavorited(rental: rental)
                            : SetFavorited(rental: rental),
                      );
                    }
                  },
                  icon: Icon(state.isFavorited
                      ? Icons.favorite
                      : Icons.favorite_border),
                )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return (rental.images.isNotEmpty)
                        ? SizedBox(
                            height: constraints.maxWidth,
                            child: PageView.builder(
                              controller: _controller,
                              itemCount: rental.images.length,
                              onPageChanged: (index) {
                                setState(() => _current = index);
                              },
                              itemBuilder: (context, index) =>
                                  CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: constraints.maxWidth,
                                imageUrl: rental.images[index],
                                placeholder: (c, _) => Container(
                                  color: Colors.white,
                                  child: const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : NoImage(dimension: constraints.maxWidth);
                  },
                ),
                Stack(
                  children: [
                    const TopShadow(),
                    Container(
                      color: Theme.of(context).canvasColor,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8.0),
                        children: [
                          PageIndicator(
                            items: widget.rental.images,
                            controller: _controller,
                            current: _current,
                          ),
                          Text(
                            rental.title,
                            style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${rental.price} EGP / ${rental.rentPeriod?.name}',
                                style: const TextStyle(fontSize: 22.0),
                              ),
                              Text(
                                '${rental.region}, ${tr('governorates.${rental.governorate.index}')}',
                                style: TextStyle(
                                  color: Colors.blueGrey.shade400,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          if (rental.propertyType != null)
                            Text(
                              tr('propertyType.${rental.propertyType?.index}'),
                              style: TextStyle(
                                color: Colors.blueGrey.shade400,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          Text(
                            'Posted ${DateFormat('MMM d, h:mma').format(rental.createdAt!.toDate())}',
                          ),
                          const Divider(thickness: 1),
                          if (rental.rooms != null)
                            Text('Rooms: ${rental.rooms}'),
                          if (rental.bathrooms != null)
                            Text('Bathrooms: ${rental.bathrooms}'),
                          if (rental.furnished != null)
                            Text(
                              'Furnished: ${rental.furnished == true ? 'Yes' : 'No'}',
                            ),
                          if (rental.floorNumber != null)
                            Text('Floor: ${rental.floorNumber}'),
                          RichText(
                            text: TextSpan(
                              text: 'Area: ${rental.area}m\u00b3',
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ),
                          const Divider(thickness: 1),
                          Text(
                            'Address',
                            style: TextStyle(
                              color: Colors.blueGrey.shade400,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(rental.address),
                          if (hasDescription) const Divider(thickness: 1),
                          if (hasDescription)
                            Text(
                              'Description',
                              style: TextStyle(
                                color: Colors.blueGrey.shade400,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          Text(rental.description ?? ''),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async => _launchDialer(),
            child: const Icon(Icons.call),
          ),
        );
      },
    );
  }

  void _launchDialer() async {
    final url = Uri.parse('tel:${widget.rental.hostPhone}');
    bool canLaunch = await canLaunchUrl(url);
    if (canLaunch) {
      await launchUrl(url);
    }
  }
}
