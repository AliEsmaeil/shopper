import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:page_view/utils/image_src.dart';

Future<File?> getImageFromGalleryOrCamera(
    {required MyImageSource imageSource}) async {
  ImagePicker picker = ImagePicker();
  XFile? temp;
  return await picker
      .pickImage(
          source: imageSource == MyImageSource.camera
              ? ImageSource.camera
              : ImageSource.gallery)
      .then((value) {
    temp = value;
    if (temp == null) {
      return null;
    } else {
      return File(temp!.path);
    }
  }).catchError((error) => error);
}
