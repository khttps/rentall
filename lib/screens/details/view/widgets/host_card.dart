import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentall/bloc/user/user_bloc.dart';
import 'package:rentall/screens/details/cubit/owner_cubit.dart';
import 'package:rentall/widgets/no_image.dart';

import '../../../list/view/list_screen.dart';

class HostCard extends StatefulWidget {
  final String userId;
  const HostCard({
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  State<HostCard> createState() => _HostCardState();
}

class _HostCardState extends State<HostCard> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OwnerCubit>(context).getOwner(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerCubit, OwnerState>(
      builder: (context, state) {
        if (state is UserError) return const SizedBox.shrink();
        return InkWell(
          onTap: () {
            if (state is OwnerLoaded) {
              Navigator.pushNamed(
                context,
                ListScreen.routeName,
                arguments: ListArguments(
                  listName: 'rentals',
                  userId: widget.userId,
                ),
              );
            }
          },
          child: Column(
            children: [
              const Text('owned_by').tr(),
              const SizedBox(height: 8.0),
              CircleAvatar(
                radius: 36.0,
                backgroundImage:
                    (state is OwnerLoaded && state.owner.hostAvatar != null)
                        ? CachedNetworkImageProvider(state.owner.hostAvatar!)
                        : null,
                child: (state is OwnerLoaded && state.owner.hostAvatar == null)
                    ? const NoImage(dimension: 60.0)
                    : null,
              ),
              if (state is OwnerLoaded) ...[
                const SizedBox(height: 8.0),
                Text(
                  state.owner.hostName!,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                )
              ]
            ],
          ),
        );
      },
    );
  }
}
