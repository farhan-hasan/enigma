import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/features/auth/presentation/login/view/login_screen.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/domain/usecases/create_profile_usecase.dart';
import 'package:enigma/src/features/profile/presentation/view_model/profile_generic.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider =
    StateNotifierProvider<ProfileController, ProfileGeneric>(
        (ref) => ProfileController(ref));

class ProfileController extends StateNotifier<ProfileGeneric> {
  ProfileController(this.ref) : super(ProfileGeneric());
  Ref ref;

  CreateProfileUseCase createProfileUseCase = sl.get<CreateProfileUseCase>();

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
}
