// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'dart:html' as html;
//
// class ProofImageState {
//   final String? base64Image;
//   final String? imageName;
//
//   ProofImageState({this.base64Image, this.imageName});
// }
//
// class ProofImageNotifier extends StateNotifier<ProofImageState> {
//   final ImagePicker _picker = ImagePicker();
//
//   ProofImageNotifier() : super(ProofImageState());
//
//   Future<void> pickImage() async {
//     if (kIsWeb) {
//       // For web, use the dart:html library to pick an image
//       final fileInput = html.FileUploadInputElement();
//       fileInput.accept = 'image/*';
//       fileInput.click();
//
//       fileInput.onChange.listen((e) async {
//         final files = fileInput.files;
//         if (files!.isEmpty) return;
//
//         final reader = html.FileReader();
//         reader.readAsArrayBuffer(files[0]);
//
//         reader.onLoadEnd.listen((e) async {
//           final bytes = reader.result as Uint8List;
//           final base64String = base64Encode(bytes);
//           state = ProofImageState(
//             base64Image: base64String,
//             imageName: files[0].name,
//           );
//         });
//       });
//     } else {
//       // For mobile platforms
//       final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         final bytes = File(pickedFile.path).readAsBytesSync();
//         final base64String = base64Encode(bytes);
//         state = ProofImageState(
//           base64Image: base64String,
//           imageName: pickedFile.name,
//         );
//       }
//     }
//   }
// }
//
// // Riverpod provider for the ProofImageNotifier
// final proofImageProvider =
//     StateNotifierProvider<ProofImageNotifier, ProofImageState>((ref) {
//   return ProofImageNotifier();
// });
