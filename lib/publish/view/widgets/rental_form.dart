// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:rentall/data/model/property_type.dart';

// import '../../../data/model/rental.dart';

// class RentalForm extends StatelessWidget {
//   final GlobalKey<FormBuilderState> _formKey;
//   const RentalForm({
//     required GlobalKey<FormBuilderState> formKey,
//     Key? key,
//   })  : _formKey = formKey,
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FormBuilder(
//       key: _formKey,
//       child: ListView(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
//             child: Text('Title'),
//           ),
//           FormBuilderTextField(
//             name: 'title',
//             textInputAction: TextInputAction.next,
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(context,
//                   errorText: tr('required')),
//             ]),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
//             child: Text('Property Type'),
//           ),
//           FormBuilderDropdown(
//             name: 'propertyType',
//             initialValue: 1,
//             items: List.generate(
//               PropertyType.values.length - 1,
//               (index) => DropdownMenuItem(
//                 value: index + 1,
//                 child: Text(
//                   'propertyType.${index + 1}',
//                 ).tr(),
//               ),
//             ),
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(context,
//                   errorText: tr('required')),
//             ]),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
//             child: Text('Address'),
//           ),
//           FormBuilderTextField(
//             name: 'address',
//             minLines: 3,
//             maxLines: 3,
//             textInputAction: TextInputAction.next,
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(context,
//                   errorText: tr('required')),
//             ]),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               children: const [
//                 Expanded(child: Text('Governorate')),
//                 SizedBox(width: 8.0),
//                 Expanded(child: Text('Region')),
//                 SizedBox(width: 8.0),
//                 Expanded(child: Text('Period'))
//               ],
//             ),
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Flexible(
//                 child: FormBuilderDropdown(
//                   name: 'governorateId',
//                   initialValue: 1,
//                   items: List.generate(
//                     27,
//                     (index) => DropdownMenuItem(
//                       value: index + 1,
//                       child: Text(
//                         'governorates.${index + 1}',
//                         overflow: TextOverflow.ellipsis,
//                       ).tr(),
//                     ),
//                   ),
//                   validator: FormBuilderValidators.compose([
//                     FormBuilderValidators.required(context,
//                         errorText: tr('required')),
//                   ]),
//                 ),
//               ),
//               const SizedBox(width: 8.0),
//               Flexible(
//                 child: FormBuilderTextField(
//                   readOnly: true,
//                   name: 'regionId',
//                   enabled: false,
//                   textInputAction: TextInputAction.next,
//                 ),
//               ),
//               const SizedBox(width: 8.0),
//               Flexible(
//                 child: FormBuilderDropdown(
//                   name: 'rentType',
//                   initialValue: 1,
//                   items: List.generate(
//                     RentType.values.length,
//                     (index) => DropdownMenuItem(
//                       value: index + 1,
//                       child: Text(
//                         'rentPeriod.${index + 1}',
//                         overflow: TextOverflow.ellipsis,
//                       ).tr(),
//                     ),
//                   ),
//                   validator: FormBuilderValidators.compose([
//                     FormBuilderValidators.required(context,
//                         errorText: tr('required')),
//                   ]),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               children: const [
//                 Expanded(child: Text('Area')),
//                 SizedBox(width: 8.0),
//                 Expanded(child: Text('Price')),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: FormBuilderTextField(
//                   name: 'rentPrice',
//                   valueTransformer: (String? value) {
//                     if (value != null) return int.tryParse(value);
//                   },
//                   decoration: InputDecoration(
//                     suffix: RichText(
//                       text: TextSpan(
//                         text: 'm\u00b3',
//                         style: TextStyle(
//                           color: Colors.black.withAlpha(175),
//                         ),
//                       ),
//                     ),
//                   ),
//                   keyboardType: TextInputType.number,
//                   textInputAction: TextInputAction.next,
//                   validator: FormBuilderValidators.compose([
//                     FormBuilderValidators.required(
//                       context,
//                       errorText: tr('required'),
//                     ),
//                     FormBuilderValidators.numeric(context),
//                   ]),
//                 ),
//               ),
//               const SizedBox(width: 8.0),
//               Expanded(
//                 child: FormBuilderTextField(
//                   name: 'area',
//                   valueTransformer: (String? value) {
//                     if (value != null) return int.tryParse(value);
//                   },
//                   decoration: const InputDecoration(
//                     suffix: Text('EGP'),
//                   ),
//                   keyboardType: TextInputType.number,
//                   textInputAction: TextInputAction.next,
//                   validator: FormBuilderValidators.compose([
//                     FormBuilderValidators.required(
//                       context,
//                       errorText: tr('required'),
//                     ),
//                     FormBuilderValidators.numeric(context),
//                   ]),
//                 ),
//               )
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0, bottom: 3.0),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               children: const [
//                 Expanded(child: Text('Floor')),
//                 SizedBox(width: 8.0),
//                 Expanded(child: Text('Rooms')),
//                 SizedBox(width: 8.0),
//                 Expanded(child: Text('Bathrooms')),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Flexible(
//                 child: FormBuilderTextField(
//                   name: 'floorNumber',
//                   valueTransformer: (String? value) {
//                     if (value != null) return int.tryParse(value);
//                   },
//                   keyboardType: TextInputType.number,
//                   textInputAction: TextInputAction.next,
//                 ),
//               ),
//               const SizedBox(width: 8.0),
//               Flexible(
//                 child: FormBuilderTextField(
//                   name: 'numberOfRooms',
//                   valueTransformer: (String? value) {
//                     if (value != null) return int.tryParse(value);
//                   },
//                   keyboardType: TextInputType.number,
//                   textInputAction: TextInputAction.next,
//                 ),
//               ),
//               const SizedBox(width: 8.0),
//               Flexible(
//                 child: FormBuilderTextField(
//                   name: 'numberOfBathrooms',
//                   valueTransformer: (String? value) {
//                     if (value != null) return int.tryParse(value);
//                   },
//                   keyboardType: TextInputType.number,
//                   textInputAction: TextInputAction.next,
//                 ),
//               ),
//             ],
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
//             child: Text('Phone'),
//           ),
//           FormBuilderTextField(
//             name: 'hostPhoneNumber',
//             decoration: const InputDecoration(prefix: Text('+20  ')),
//             keyboardType: TextInputType.phone,
//             textInputAction: TextInputAction.next,
//             validator: FormBuilderValidators.compose([
//               FormBuilderValidators.required(
//                 context,
//                 errorText: tr('required'),
//               ),
//               FormBuilderValidators.numeric(context),
//               FormBuilderValidators.minLength(context, 10),
//               FormBuilderValidators.maxLength(context, 11),
//             ]),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
//             child: Text('Description'),
//           ),
//           FormBuilderTextField(
//             name: 'description',
//             minLines: 3,
//             maxLines: 3,
//             decoration: const InputDecoration(
//               hintText: 'Write any other details about your rental...',
//             ),
//             textInputAction: TextInputAction.done,
//           ),
//         ],
//       ),
//     );
//   }

  
// }
