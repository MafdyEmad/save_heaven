import 'package:flutter/material.dart';
import 'package:save_heaven/features/kids/data/models/kid_model.dart';
import 'package:save_heaven/features/kids/presentation/pages/widgets/component/kid_profile_card.dart';

class DisplayAllKidsBody extends StatelessWidget {
  const DisplayAllKidsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<KidModel> kids = [
      KidModel(
        name: 'mody',
        age: 11,
        gender: 'male',
        hairType: 'straight-haired',
        religion: 'muslim',
        educationLevel: 'primary educated',
        imageUrl: 'assets/images/kid1.png',
        orphanageIcon: 'assets/icons/sos.png',
      ),
      KidModel(
        name: 'hamody',
        age: 8,
        gender: 'male',
        hairType: 'curly-haired',
        religion: 'christian',
        educationLevel: 'division',
        imageUrl: 'assets/images/kid2.png',
        orphanageIcon: 'assets/icons/sos.png',
      ),
      KidModel(
        name: 'mody',
        age: 11,
        gender: 'male',
        hairType: 'straight-haired',
        religion: 'muslim',
        educationLevel: 'primary educated',
        imageUrl: 'assets/images/kid1.png',
        orphanageIcon: 'assets/icons/sos.png',
      ),
      KidModel(
        name: 'hamody',
        age: 8,
        gender: 'male',
        hairType: 'curly-haired',
        religion: 'christian',
        educationLevel: 'division',
        imageUrl: 'assets/images/kid2.png',
        orphanageIcon: 'assets/icons/sos.png',
      ),
      KidModel(
        name: 'mody',
        age: 11,
        gender: 'male',
        hairType: 'straight-haired',
        religion: 'muslim',
        educationLevel: 'primary educated',
        imageUrl: 'assets/images/kid1.png',
        orphanageIcon: 'assets/icons/sos.png',
      ),
      KidModel(
        name: 'hamody',
        age: 8,
        gender: 'male',
        hairType: 'curly-haired',
        religion: 'christian',
        educationLevel: 'division',
        imageUrl: 'assets/images/kid2.png',
        orphanageIcon: 'assets/icons/sos.png',
      ),
      KidModel(
        name: 'mody',
        age: 11,
        gender: 'male',
        hairType: 'straight-haired',
        religion: 'muslim',
        educationLevel: 'primary educated',
        imageUrl: 'assets/images/kid1.png',
        orphanageIcon: 'assets/icons/sos.png',
      ),
      KidModel(
        name: 'hamody',
        age: 8,
        gender: 'male',
        hairType: 'curly-haired',
        religion: 'christian',
        educationLevel: 'division',
        imageUrl: 'assets/images/kid2.png',
        orphanageIcon: 'assets/icons/sos.png',
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: kids.length,
      itemBuilder: (context, index) {
        return KidProfileCard(kid: kids[index]);
      },
    );
  }
}
