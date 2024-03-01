import 'dart:io';

import 'package:authentication/view/widget/snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnakBar(context, e.toString());
  }
  return image;
}
