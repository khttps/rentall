import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RentalForm extends StatelessWidget {
  const RentalForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: GlobalKey<FormBuilderState>(),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Text('Title'),
          ),
          FormBuilderTextField(
            name: 'title',
            textInputAction: TextInputAction.next,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Text('Property Type'),
          ),
          FormBuilderTextField(
            name: 'propertyType',
            textInputAction: TextInputAction.next,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Text('Address'),
          ),
          FormBuilderTextField(
            name: 'address',
            minLines: 3,
            maxLines: 3,
            textInputAction: TextInputAction.next,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Expanded(child: Text('Region')),
                SizedBox(width: 8.0),
                Expanded(child: Text('Price')),
                SizedBox(width: 8.0),
                Expanded(child: Text('Rent Period'))
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: FormBuilderTextField(
                  name: 'governorateId',
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: FormBuilderTextField(
                  name: 'rentPrice',
                  decoration: const InputDecoration(suffix: Text('EGP')),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: FormBuilderTextField(
                  name: 'rentType',
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Expanded(child: Text('Number of Rooms')),
                SizedBox(width: 8.0),
                Expanded(child: Text('Number of Bathrooms')),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: FormBuilderTextField(
                  name: 'numberOfRooms',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: FormBuilderTextField(
                  name: 'numberOfBathrooms',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Expanded(child: Text('Floor Number')),
                SizedBox(width: 8.0),
                Expanded(child: Text('GPS Location')),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: FormBuilderTextField(
                  name: 'floorNumber',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: FormBuilderTextField(
                  name: 'location',
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Text('Phone'),
          ),
          FormBuilderTextField(
            name: 'hostPhoneNumber',
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
            child: Text('Description'),
          ),
          FormBuilderTextField(
            name: 'description',
            minLines: 3,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Write any other details about your rental...',
            ),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
