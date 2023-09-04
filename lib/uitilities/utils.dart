import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<String?> getFileNameFromUint8List(Uint8List uint8List) async {
  try {
    // Create a temporary File object from the Uint8List
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/tempfile');

    await tempFile.writeAsBytes(uint8List);

    // Extract the file name from the File object
    String fileName = tempFile.path.split('/').last;

    // Delete the temporary file
    tempFile.deleteSync();

    return fileName;
  } catch (e) {
    print('Error getting file name: $e');
    return null; // Handle the error appropriately
  }
}

String imageid = "";

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
    String childName,
    Uint8List? file,
  ) async {
    // print(file);
    try {
      if (file != null) {
        // Creating a location in Firebase Storage
        imageid = const Uuid().v1();

        Reference ref = _storage.ref().child(childName).child(imageid);

        // Uploading the image as a Uint8List
        // await Future.delayed(Duration(seconds: 3));
        final metadata = SettableMetadata(contentType: 'image/png');

        UploadTask uploadTask = ref.putData(file, metadata);

        // Waiting for the upload to complete
        TaskSnapshot snapshot = await uploadTask;

        // Getting the download URL
        String downloadUrl = await snapshot.ref.getDownloadURL();
        print("downloadUrl: $downloadUrl");
        return downloadUrl;
      } else {
        print('No image selected.');
        return '';

        // Handle the case where no image was selected
      }
    } catch (e) {
      // Handle exceptions that occurred during image upload
      print('Error uploading image to Firebase Storage: $e');
      // Display an error message to the user or take appropriate action
      throw e; // Re-throw the exception to notify the caller about the error
    }
  }
}

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void showErrorSnackbar(String message) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    duration: Duration(seconds: 3),
  );
}
