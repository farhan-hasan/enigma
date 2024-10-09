import 'package:enigma/src/core/network/remote/firebase/model/firebase_order_by_model.dart';
import 'package:enigma/src/core/network/remote/firebase/model/firebase_where_model.dart';

class FilterDto {
  FirebaseWhereModel? firebaseWhereModel;
  FirebaseOrderByModel? firebaseOrderByModel;
  FilterDto({this.firebaseWhereModel, this.firebaseOrderByModel});
}
