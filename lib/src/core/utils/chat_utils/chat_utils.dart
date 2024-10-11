import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ChatUtils {
  static Future<File?> pickImage({required ImageSource imageSource}) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? getImage = await imagePicker.pickImage(
      source: imageSource,
    );
    File? file;
    if (getImage != null) {
      file = File(getImage.path);
      return file;
    } else {
      return null;
    }
  }

  static Future<File?> pickDocuments(List<String> extensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: extensions,
      type: FileType.custom,
    );
    File file;
    if (result != null) {
      file = File(result.paths.first!);
      return file;
    } else {
      return null;
    }
  }
}
