import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';

class ChatRequestGeneric {
  bool isChatRequestLoading;
  bool isPendingRequestLoading;
  bool isUpdateRequestStatusLoading;
  bool isSendChatRequestLoading;
  bool isFriendsLoading;
  bool isRemoveFriendLoading;
  List<ProfileEntity> listOfChatRequest;
  List<ProfileEntity> listOfPendingRequest;
  List<ProfileEntity> listOfFriends;

  ChatRequestGeneric({
    this.isChatRequestLoading = false,
    this.isPendingRequestLoading = false,
    this.isSendChatRequestLoading = false,
    this.isUpdateRequestStatusLoading = false,
    this.isFriendsLoading = false,
    this.isRemoveFriendLoading = false,
    this.listOfChatRequest = const [],
    this.listOfPendingRequest = const [],
    this.listOfFriends = const [],
  });

  ChatRequestGeneric update(
      {bool? isChatRequestLoading,
      bool? isPendingRequestLoading,
      bool? isSendChatRequestLoading,
      bool? isUpdateRequestStatusLoading,
      bool? isFriendsLoading,
      bool? isRemoveFriendLoading,
      List<ProfileEntity>? listOfChatRequest,
      List<ProfileEntity>? listOfFriends,
      List<ProfileEntity>? listOfPendingRequest}) {
    return ChatRequestGeneric(
        isChatRequestLoading: isChatRequestLoading ?? this.isChatRequestLoading,
        isRemoveFriendLoading:
            isRemoveFriendLoading ?? this.isRemoveFriendLoading,
        isPendingRequestLoading:
            isPendingRequestLoading ?? this.isPendingRequestLoading,
        isUpdateRequestStatusLoading:
            isUpdateRequestStatusLoading ?? this.isUpdateRequestStatusLoading,
        isSendChatRequestLoading:
            isSendChatRequestLoading ?? this.isSendChatRequestLoading,
        isFriendsLoading: isFriendsLoading ?? this.isFriendsLoading,
        listOfChatRequest: listOfChatRequest ?? this.listOfChatRequest,
        listOfFriends: listOfFriends ?? this.listOfFriends,
        listOfPendingRequest:
            listOfPendingRequest ?? this.listOfPendingRequest);
  }
}
