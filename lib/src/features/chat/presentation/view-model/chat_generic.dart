import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';

/// Farhan -> Y51bMMMKXAT1AQs0vPutTfVCkTB2
/// Nayem -> SjKB4wFCutQyMOmrJUhXlX3eo5l1
class ChatGeneric {
  List<ChatEntity> chats;

  ChatGeneric({this.chats = const []});

  ChatGeneric update(List<ChatEntity>? chats) {
    return ChatGeneric(chats: chats ?? this.chats);
  }
}
