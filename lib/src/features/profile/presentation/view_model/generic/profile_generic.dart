import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';

class ProfileGeneric {
  bool isLoading;
  ProfileEntity? profileEntity;

  ProfileGeneric({this.isLoading = false, this.profileEntity});

  ProfileGeneric update({bool? isLoading, ProfileEntity? profileEntity}) {
    return ProfileGeneric(
        isLoading: isLoading ?? this.isLoading,
        profileEntity: profileEntity ?? this.profileEntity);
  }
}
