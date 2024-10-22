import 'package:enigma/src/shared/data/model/push_body_model/push_body_model.dart';

class FCMDto {
  String recipientToken;
  String title;
  String body;

  PushBodyModel? data;

  String imageUrl;
  FCMDto({
    required this.recipientToken,
    required this.title,
    required this.body,
    this.data,
    required this.imageUrl,
  });
}
