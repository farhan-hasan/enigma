import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';

class PeopleGeneric {
  bool isLoading;
  List<ProfileEntity> listOfPeople;

  PeopleGeneric({this.isLoading = false, this.listOfPeople = const []});

  PeopleGeneric update({bool? isLoading, List<ProfileEntity>? listOfPeople}) {
    return PeopleGeneric(
        isLoading: isLoading ?? this.isLoading,
        listOfPeople: listOfPeople ?? this.listOfPeople);
  }
}
