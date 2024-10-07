import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';

class ChatRequestGeneric {
  bool isLoading;
  List<ProfileEntity> listOfChatRequest;
  List<ProfileEntity> listOfPendingRequest;

  ChatRequestGeneric(
      {this.isLoading = false,
      this.listOfChatRequest = const [],
      this.listOfPendingRequest = const []});

  ChatRequestGeneric update(
      {bool? isLoading,
      List<ProfileEntity>? listOfChatRequest,
      List<ProfileEntity>? listOfPendingRequest}) {
    return ChatRequestGeneric(
        isLoading: isLoading ?? this.isLoading,
        listOfChatRequest: listOfChatRequest ?? this.listOfChatRequest,
        listOfPendingRequest:
            listOfPendingRequest ?? this.listOfPendingRequest);
  }
}
