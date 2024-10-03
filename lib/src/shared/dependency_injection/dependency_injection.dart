import 'package:enigma/firebase_options.dart';
import 'package:enigma/src/core/database/local/sembast/sembast_db_config.dart';
import 'package:enigma/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:enigma/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:enigma/src/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:enigma/src/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:enigma/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:enigma/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:enigma/src/features/auth/domain/usecases/signup_usecase.dart';
import 'package:enigma/src/features/profile/data/repository/profile_repository_impl.dart';
import 'package:enigma/src/features/profile/domain/usecases/create_profile_usecase.dart';
import 'package:enigma/src/features/profile/domain/usecases/delete_profile_usecase.dart';
import 'package:enigma/src/features/profile/domain/usecases/read_all_profile_usecase.dart';
import 'package:enigma/src/features/profile/domain/usecases/read_profile_usecase.dart';
import 'package:enigma/src/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:enigma/src/shared/data/repository/media_repository_impl.dart';
import 'package:enigma/src/shared/domain/use_cases/profile_picture_usecase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

Future<void> setupService() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sl.registerSingletonAsync<SharedPreferenceManager>(() async {
    final SharedPreferenceManager sharedPreferenceManager =
        SharedPreferenceManager();
    await sharedPreferenceManager.init();
    return sharedPreferenceManager;
  });

  sl.registerSingletonAsync<SembastDbConfig>(() async {
    final sembastDbConfig = SembastDbConfig();
    await sembastDbConfig.init();
    return sembastDbConfig;
  });

  sl.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl());
  sl.registerSingleton<ChangePasswordUseCase>(ChangePasswordUseCase());
  sl.registerSingleton<ForgotPasswordUseCase>(ForgotPasswordUseCase());
  sl.registerSingleton<LoginUseCase>(LoginUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<ProfileRepositoryImpl>(ProfileRepositoryImpl());
  sl.registerSingleton<CreateProfileUseCase>(CreateProfileUseCase());
  sl.registerSingleton<ReadProfileUseCase>(ReadProfileUseCase());
  sl.registerSingleton<ReadAllProfileUseCase>(ReadAllProfileUseCase());
  sl.registerSingleton<UpdateProfileUseCase>(UpdateProfileUseCase());
  sl.registerSingleton<DeleteProfileUseCase>(DeleteProfileUseCase());

  sl.registerSingleton<MediaRepositoryImpl>(MediaRepositoryImpl());
  sl.registerSingleton<ProfilePictureUsecase>(ProfilePictureUsecase());

  await sl.allReady();
}
