import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/remote/firebase/model/firebase_where_model.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_controller.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/domain/usecases/read_all_people_usecase.dart';
import 'package:enigma/src/features/profile/presentation/view_model/generic/people_generic.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final peopleProvider = StateNotifierProvider<PeopleController, PeopleGeneric>(
    (ref) => PeopleController(ref));

class PeopleController extends StateNotifier<PeopleGeneric> {
  PeopleController(this.ref) : super(PeopleGeneric());
  Ref ref;
  ReadAllPeopleUseCase readAllPeopleUseCase = sl.get<ReadAllPeopleUseCase>();

  Future<bool> readAllPeople() async {
    state = state.update(isLoading: true);
    // TODO: impement sembast and store profileEntity and call uid from the ProfileEntity
    FirebaseWhereModel whereModel = FirebaseWhereModel(
      field: "uid",
      whereNotIn: [FirebaseHandler.auth.currentUser?.uid ?? ""],
    );
    FilterDto params = FilterDto(firebaseWhereModel: whereModel);
    bool isSuccess = false;
    Either<Failure, List<ProfileEntity>> response =
        await readAllPeopleUseCase.call(params);
    response.fold(
      (left) {
        BotToast.showText(text: left.message);
      },
      (right) {
        List<ProfileEntity> people = right;
        List<ProfileEntity> chatRequests =
            ref.read(chatRequestProvider).listOfChatRequest;
        List<ProfileEntity> pendingRequests =
            ref.read(chatRequestProvider).listOfPendingRequest;
        List<ProfileEntity> friends =
            ref.read(chatRequestProvider).listOfFriends;

        // removing chat requests from people
        Set<String?> chatRequestsUIds = chatRequests.map((e) => e.uid).toSet();
        Set<String?> pendingRequestsUIds =
            pendingRequests.map((e) => e.uid).toSet();
        Set<String?> friendsUIds = friends.map((e) => e.uid).toSet();
        people.removeWhere((person) => chatRequestsUIds.contains(person.uid));
        people
            .removeWhere((person) => pendingRequestsUIds.contains(person.uid));
        people.removeWhere((person) => friendsUIds.contains(person.uid));

        for (ProfileEntity p in people) {
          debug(p.name);
        }
        //debug(people);

        state = state.update(listOfPeople: people);
        BotToast.showText(text: "Read all people successfully");
        isSuccess = true;
      },
    );
    state = state.update(isLoading: false);
    return isSuccess;
  }
}
