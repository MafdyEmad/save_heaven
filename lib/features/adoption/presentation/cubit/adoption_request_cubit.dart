// 📁 features/adoption/presentation/cubit/adoption_request_cubit.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdoptionRequestCubit extends Cubit<void> {
  AdoptionRequestCubit() : super(null);

  // Text controllers for form fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  // Dropdown values
  String? gender;
  String? religion;
  String? location;
  String? maritalStatus;

  void submit(BuildContext context) {
    // Example: read and print submitted data
    final fullName = fullNameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final job = jobController.text.trim();
    final address = addressController.text.trim();
    final dob = dateController.text.trim();
    final nationality = nationalityController.text.trim();
    final income = incomeController.text.trim();
    final reason = reasonController.text.trim();

    print("FullName: $fullName\nPhone: $phone\nEmail: $email\nDOB: $dob");
    print("Nationality: $nationality\nIncome: $income\nReason: $reason");
    print("Gender: $gender\nReligion: $religion\nLocation: $location\nStatus: $maritalStatus");

    // TODO: send to API

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Request Submitted Successfully!")),
    );
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    jobController.dispose();
    addressController.dispose();
    dateController.dispose();
    nationalityController.dispose();
    incomeController.dispose();
    reasonController.dispose();
    return super.close();
  }
}
