import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RentalEdit extends StatefulWidget {
  static const routeName = '/rental_edit';
  const RentalEdit({Key? key}) : super(key: key);

  @override
  State<RentalEdit> createState() => _RentalEditState();
}

class _RentalEditState extends State<RentalEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                const SliverAppBar(
                  title: Text('New Rental'),
                  forceElevated: true,
                  floating: true,
                  snap: true,
                )
              ],
          body: FormBuilder(
            key: GlobalKey<FormBuilderState>(),
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              children: [],
            ),
          )),
    );
  }
}
