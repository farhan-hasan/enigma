import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';

class ProfileGeneric {
  bool isLoading;
  ProfileEntity? profileEntity;
  // Map<String,ProfileEntity> loadedProfiles = {};

  ProfileGeneric({this.isLoading = false, this.profileEntity});

  ProfileGeneric update({bool? isLoading, ProfileEntity? profileEntity}) {
    return ProfileGeneric(
        isLoading: isLoading ?? this.isLoading,
        profileEntity: profileEntity ?? this.profileEntity);
  }

  // loadProfile(String uid, ProfileEntity profileEntity) {
  //   loadedProfiles[uid] = profileEntity;
  // }
  //
  // resetProfiles() {
  //   loadedProfiles.clear();
  // }
  //
  // Either<bool,ProfileEntity>getProfile(String uid) {
  //   if(loadedProfiles.containsKey(uid)) {
  //     ProfileEntity profile = loadedProfiles[uid] ?? ProfileEntity();
  //     return Right(profile);
  //   }
  //   else {
  //     return const Left(false);
  //   }
  // }
}
