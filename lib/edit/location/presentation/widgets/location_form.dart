// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../profile/state/location_state.dart';
// import '../../../profile/providers/location_provider.dart';
//
// class LocationForm extends ConsumerWidget {
//   final LocationState state;
//   final VoidCallback onSave;
//   final bool enabled;
//
//   const LocationForm({
//     Key? key,
//     required this.state,
//     required this.onSave,
//     required this.enabled,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       children: [
//         CustomTextField(
//           label: 'Country Living',
//           value: state.country,
//           onChanged: (value) =>
//               ref.read(locationProvider.notifier).updateCountry(value),
//           enabled: enabled,
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           label: 'Residing State',
//           value: state.state,
//           onChanged: (value) =>
//               ref.read(locationProvider.notifier).updateState(value),
//           enabled: enabled,
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           label: 'Residing City',
//           value: state.city,
//           onChanged: (value) =>
//               ref.read(locationProvider.notifier).updateCity(value),
//           enabled: enabled,
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           label: 'Pincode',
//           value: state.pincode,
//           keyboardType: TextInputType.number,
//           onChanged: (value) =>
//               ref.read(locationProvider.notifier).updatePincode(value),
//           enabled: enabled,
//         ),
//         const SizedBox(height: 16),
//         SwitchListTile(
//           title: const Text('Own House'),
//           value: state.ownHouse,
//           onChanged: enabled
//               ? (value) =>
//                   ref.read(locationProvider.notifier).updateOwnHouse(value)
//               : null,
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           label: 'Flat No',
//           value: state.flatNo,
//           onChanged: (value) =>
//               ref.read(locationProvider.notifier).updateFlatNo(value),
//           enabled: enabled,
//         ),
//         const SizedBox(height: 16),
//         CustomTextField(
//           label: 'Address',
//           value: state.address,
//           maxLines: 3,
//           onChanged: (value) =>
//               ref.read(locationProvider.notifier).updateAddress(value),
//           enabled: enabled,
//         ),
//         const SizedBox(height: 24),
//         SizedBox(
//           width: double.infinity,
//           height: 48,
//           child: ElevatedButton(
//             onPressed: onSave,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: const Text(
//               'Save',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class CustomTextField extends StatelessWidget {
//   final String label;
//   final String value;
//   final Function(String) onChanged;
//   final TextInputType? keyboardType;
//   final int? maxLines;
//   final bool enabled;
//
//   const CustomTextField({
//     Key? key,
//     required this.label,
//     required this.value,
//     required this.onChanged,
//     this.keyboardType,
//     this.maxLines = 1,
//     this.enabled = true,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           initialValue: value,
//           onChanged: onChanged,
//           keyboardType: keyboardType,
//           maxLines: maxLines,
//           enabled: enabled,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 12,
//             ),
//             filled: !enabled,
//             fillColor: !enabled ? Colors.grey[200] : null,
//           ),
//         ),
//       ],
//     );
//   }
// }
