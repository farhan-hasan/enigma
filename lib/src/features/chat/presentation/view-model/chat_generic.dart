import 'package:enigma/src/core/router/model/initial_data_model.dart';

/// Farhan -> Y51bMMMKXAT1AQs0vPutTfVCkTB2
/// Nayem -> SjKB4wFCutQyMOmrJUhXlX3eo5l1
class ChatGeneric {
  // List<ChatEntity> chats;
  //
  // ChatGeneric({this.chats = const []});
  //
  // ChatGeneric update(List<ChatEntity>? chats) {
  //   return ChatGeneric(chats: chats ?? this.chats);
  // }

  InitialDataModel? incomingChatData;

  ChatGeneric({this.incomingChatData});

  ChatGeneric update({InitialDataModel? incomingChatData}) {
    return ChatGeneric(
        incomingChatData: incomingChatData ?? this.incomingChatData);
  }
}
