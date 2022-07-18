import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/models.dart';
import '../../../widgets/widgets.dart';
import '../../blocs.dart';
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
    final region = rental.region != null ? '${rental.region},' : '';
    final hasDescription =
        rental.description != null && rental.description!.isNotEmpty;
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () async {
                  await _shareExternally();
                },
              ),
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
                  icon: Icon(
                    state.isFavorited ? Icons.favorite : Icons.favorite_border,
                  ),
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
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 10.0,
                        ),
                        children: [
                          PageIndicator(
                            items: widget.rental.images,
                            controller: _controller,
                            current: _current,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  rental.title,
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (state.status == DetailsStatus.owned ||
                                  (state.status == DetailsStatus.unowned &&
                                      rental.publishStatus ==
                                          PublishStatus.archived))
                                Text(
                                  rental.publishStatus!.name.toUpperCase(),
                                  style: TextStyle(
                                    color: rental.publishStatus!.color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (rental.publishStatus ==
                                  PublishStatus.rejected) ...[
                                const SizedBox(width: 8.0),
                                InkWell(
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('reject_reason').tr(),
                                        content: Text(rental.rejectReason!),
                                      ),
                                    );
                                  },
                                  child: const CircleAvatar(
                                    radius: 8.0,
                                    backgroundColor: Colors.blueGrey,
                                    child: Icon(
                                      Icons.question_mark,
                                      size: 16.0,
                                    ),
                                  ),
                                )
                              ]
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${rental.price} EGP / ${tr('rentPeriod.${rental.rentPeriod!.index}')}',
                                style: const TextStyle(fontSize: 22.0),
                              ),
                              Text(
                                '$region ${tr('governorates.${rental.governorate.index}')}',
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
                          const Text(
                            'posted',
                          ).tr(args: [
                            DateFormat('MMM d, h:mma')
                                .format(rental.createdAt!.toDate())
                          ]),
                          const Divider(thickness: 1),
                          if (rental.rooms != null)
                            const Text('rooms:').tr(args: [
                              rental.rooms.toString(),
                            ]),
                          if (rental.bathrooms != null)
                            const Text('bathrooms:').tr(args: [
                              rental.bathrooms.toString(),
                            ]),
                          if (rental.furnished != null)
                            const Text('furnished:').tr(args: [
                              rental.furnished == true ? tr('yes') : tr('no'),
                            ]),
                          if (rental.floorNumber != null)
                            const Text('floor:').tr(args: [
                              rental.floorNumber.toString(),
                            ]),
                          RichText(
                            text: TextSpan(
                              text: tr('area:').tr(args: [
                                rental.area.toString(),
                              ]),
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ),
                          const Divider(thickness: 1),
                          Text(
                            'address',
                            style: TextStyle(
                              color: Colors.blueGrey.shade400,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ).tr(),
                          Text(rental.address),
                          if (hasDescription) const Divider(thickness: 1),
                          if (hasDescription)
                            Text(
                              'description',
                              style: TextStyle(
                                color: Colors.blueGrey.shade400,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ).tr(),
                          Text(
                            rental.description ?? '',
                          ),
                          if (widget.rental.location != null) ...[
                            const Divider(thickness: 1),
                            const SizedBox(height: 8.0),
                            MapPreview(position: widget.rental.location!)
                          ],
                          const SizedBox(height: 16.0),
                          HostCard(userId: rental.userId!),
                          const SizedBox(height: 28.0),
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

  Future<void> _shareExternally() async {
    final r = widget.rental;
    await Share.share(
      '${r.title}\n${r.images[0]}\n${r.address}\n${tr('governorates.${r.governorate.index}')}, ${r.price}EGP/${tr('rentPeriod.${r.rentPeriod!.index}')}',
    );
  }
}
