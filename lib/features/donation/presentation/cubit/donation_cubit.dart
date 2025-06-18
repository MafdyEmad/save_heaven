import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/donation/data/models/orphanage_model.dart';

class DonationCubit extends Cubit<List<OrphanageModel>> {
  DonationCubit() : super([]);

  void loadOrphanages() {
    emit([
      OrphanageModel(
        name: "Bethany Children's Home",
        logo: "assets/icons/bethany.png",
        description: "Participate In Sponsoring The Families Of Orphans",
      ),
      OrphanageModel(
        name: "SOS Children's Villages",
        logo: "assets/icons/sos.png",
        description: "Participate In Sponsoring The Families Of Orphans",
      ),
      OrphanageModel(
        name: "Dar Al Orman",
        logo: "assets/icons/orman.png",
        description: "Participate In Sponsoring The Families Of Orphans",
      ),
      OrphanageModel(
        name: "Mother Teresa",
        logo: "assets/icons/bethany.png",
        description: "Participate In Sponsoring The Families Of Orphans",
      ),
    ]);
  }
}
