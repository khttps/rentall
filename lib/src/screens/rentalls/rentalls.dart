import 'package:flutter/material.dart';

class Rentalls extends StatelessWidget {
  const Rentalls({Key? key}) : super(key: key);

  static const _options = ['Verified', 'Sort', 'Region', 'Price', 'Rent Type'];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          toolbarHeight: 48.0,
          forceElevated: true,
          titleSpacing: 0.0,
          title: SizedBox(
            height: 42.0,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => ActionChip(
                labelPadding: const EdgeInsetsDirectional.only(end: 8.0),
                avatar: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                label: Text(_options[index]),
                onPressed: () {},
              ),
              itemCount: _options.length,
              separatorBuilder: (c, i) => const SizedBox(width: 4.0),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            itemCount: 25,
            itemBuilder: (context, index) {
              return const _Rentall();
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showDialog(BuildContext context) async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Choose'),
          content: ListView(
            shrinkWrap: true,
            children: const [],
          ),
          actions: [TextButton(onPressed: () {}, child: const Text('Confirm'))],
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
          ],
        ),
      ),
    );
  }
}
