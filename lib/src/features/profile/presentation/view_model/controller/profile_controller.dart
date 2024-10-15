import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/features/auth/presentation/login/view/login_screen.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/domain/usecases/create_profile_usecase.dart';
import 'package:enigma/src/features/profile/domain/usecases/read_profile_usecase.dart';
import 'package:enigma/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:enigma/src/features/profile/presentation/view_model/generic/profile_generic.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider =
    StateNotifierProvider<ProfileController, ProfileGeneric>(
        (ref) => ProfileController(ref));

class ProfileController extends StateNotifier<ProfileGeneric> {
  ProfileController(this.ref) : super(ProfileGeneric());
  Ref ref;

  CreateProfileUseCase createProfileUseCase = sl.get<CreateProfileUseCase>();
  ReadProfileUseCase readProfileUseCase = sl.get<ReadProfileUseCase>();
  UpdateProfileUseCase updateProfileUseCase = sl.get<UpdateProfileUseCase>();

  Future<bool> createProfile(ProfileEntity profileEntity) async {
    bool isSuccess = false;
    Either<Failure, ProfileEntity> response =
        await createProfileUseCase.call(profileEntity);
    response.fold(
      (left) {
        BotToast.showText(text: left.message);
      },
      (right) {
        BotToast.showText(text: "Profile Created Successfully");
        isSuccess = true;
        ref.read(goRouterProvider).go(LoginScreen.setRoute());
      },
    );
    return isSuccess;
  }

  updateProfile(ProfileEntity profileEntity) async {
    Either<Failure, ProfileEntity> response =
        await updateProfileUseCase.call(profileEntity);
    response.fold(
      (left) {
        BotToast.showText(text: left.message);
      },
      (right) {
        BotToast.showText(text: "Profile Updated Successfully");
        ref.read(goRouterProvider).go(LoginScreen.setRoute());
      },
    );
  }

  readProfile(String uid) async {
    ProfileEntity profileEntity = ProfileEntity();
    state = state.update(isLoading: true);
    Either<Failure, ProfileEntity> response =
        await readProfileUseCase.call(uid);
    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      BotToast.showText(text: "Profile read Successfully");
      state = state.update(profileEntity: right);
    });
    state = state.update(isLoading: false);
  }
}
