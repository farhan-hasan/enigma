import 'dart:io';

class ImageMediaDto {
  File file;
  String directory;
  String fileName;

  ImageMediaDto({
    required this.file,
    required this.directory,
    required this.fileName,
  });
}
