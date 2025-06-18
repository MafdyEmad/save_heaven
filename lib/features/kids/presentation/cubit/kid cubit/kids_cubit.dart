import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/kid_model.dart';

class KidsCubit extends Cubit<List<KidModel>> {
  KidsCubit() : super([]);

  void loadKids() {
    emit([
      KidModel(
        name: "mody",
        age: 15,
        gender: "male",
        hairType: "straight - haired",
        religion: "muslim",
        educationLevel: "primary educated",
        imageUrl: "assets/images/kid1.png",
        orphanageIcon: "assets/icons/bethany.png",
      ),
      KidModel(
        name: "hamody",
        age: 15,
        gender: "male",
        hairType: "straight - haired",
        religion: "muslim",
        educationLevel: "primary educated",
        imageUrl: "assets/images/kid2.png",
        orphanageIcon: "assets/icons/sos.png",
      ),
    ]);
  }
}
