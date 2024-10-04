import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';

class ChatRequestGeneric {
  bool isLoading;
  List<ProfileEntity> listOfPeople;

  ChatRequestGeneric({this.isLoading = false, this.listOfPeople = const []});

  ChatRequestGeneric update(
      {bool? isLoading, List<ProfileEntity>? listOfPeople}) {
    return ChatRequestGeneric(
        isLoading: isLoading ?? this.isLoading,
        listOfPeople: listOfPeople ?? this.listOfPeople);
  }
}
