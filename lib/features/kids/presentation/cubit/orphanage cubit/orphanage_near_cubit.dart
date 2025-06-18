import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_heaven/features/kids/data/models/orphanage_near_card_model.dart';

class OrphanageNearCubit extends Cubit<List<OrphanageNearCardModel>> {
  OrphanageNearCubit() : super([]);

  void loadOrphanages() {
    emit([
      OrphanageNearCardModel(
        name: 'Bethany Children\'s Home',
        imageUrl: 'assets/icons/bethany.png',
        description: 'Provides shelter and education for orphaned children.',
      ),
      OrphanageNearCardModel(
        name: 'SOS Children\'s Villages',
        imageUrl: 'assets/icons/sos.png',
        description: 'Offers a loving home to every child.',
      ),
      OrphanageNearCardModel(
        name: 'Bethany Children\'s Home',
        imageUrl: 'assets/icons/bethany.png',
        description: 'Provides shelter and education for orphaned children.',
      ),
      OrphanageNearCardModel(
        name: 'SOS Children\'s Villages',
        imageUrl: 'assets/icons/sos.png',
        description: 'Offers a loving home to every child.',
      ),
    ]);
  }
}
