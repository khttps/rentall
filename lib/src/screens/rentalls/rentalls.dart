import 'package:flutter/material.dart';

class Rentalls extends StatelessWidget {
  const Rentalls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          toolbarHeight: 42.0,
          forceElevated: true,
          titleSpacing: 8.0,
          title: Row(
            children: [
              GestureDetector(
                onTap: () async => await _showRegionDialog(context),
                child: Row(
                  children: const [
                    Text(
                      'Choose Region',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              const Expanded(child: SizedBox.shrink()),
              IconButton(
                onPressed: () async => await _showFiltersDialog(context),
                icon: const Icon(Icons.filter_list_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.sort_rounded),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const _Rentall();
              },
              childCount: 25,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showRegionDialog(BuildContext context) async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Choose Region'),
          content: ListView(
            shrinkWrap: true,
            children: [
              Text('Cairo'),
              Text('Cairo'),
              Text('Cairo'),
            ],
          ),
          actions: [TextButton(onPressed: () {}, child: Text('Confirm'))],
        ),
      );

  Future<void> _showFiltersDialog(BuildContext context) async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Choose Rental Type'),
          content: ListView(
            shrinkWrap: true,
            children: [
              Text('Apartment'),
              Text('Apartment'),
              Text('Apartment'),
            ],
          ),
          actions: [TextButton(onPressed: () {}, child: Text('Confirm'))],
        ),
      );
}

class _Rentall extends StatelessWidget {
  const _Rentall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0.0, 1.0),
                blurRadius: 2,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(4.0)),
              child: Image.network(
                'https://i.imgur.com/ybAPITI.jpeg',
                height: 180.0,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: const Text(
                'Apartment for Sale',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Cairo, Egypt',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '13/2/2022',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 10.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: const [
            //       Text(
            //         'Hello haha',
            //         style: TextStyle(
            //           fontSize: 13.0,
            //           height: 1.7,
            //           fontWeight: FontWeight.w400,
            //         ),
            //       ),
            //       Text(
            //         'Hello haha',
            //         style: TextStyle(
            //           fontSize: 13.0,
            //           height: 1.7,
            //           fontWeight: FontWeight.w400,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
