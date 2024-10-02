import 'package:enigma/firebase_options.dart';
import 'package:enigma/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:enigma/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:enigma/src/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:enigma/src/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:enigma/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:enigma/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:enigma/src/features/auth/domain/usecases/signup_usecase.dart';
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

  sl.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl());

  sl.registerSingleton<ChangePasswordUsecase>(ChangePasswordUsecase());

  sl.registerSingleton<ForgotPasswordUsecase>(ForgotPasswordUsecase());

  sl.registerSingleton<LoginUseCase>(LoginUseCase());

  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  await sl.allReady();
}
