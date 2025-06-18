import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit()
      : super(const PaymentState(
          paymentMethod: 'Visa',
          program: 'Orphan Sponsorship',
        ));

  static PaymentCubit get(BuildContext context) => BlocProvider.of(context);

  final cardHolder = TextEditingController();
  final cardNumber = TextEditingController();
  final donationValue = TextEditingController();
  final cvc = TextEditingController();
  final expiryDate = TextEditingController();

  void changeMethod(String? value) {
    if (value != null) {
      emit(state.copyWith(paymentMethod: value));
    }
  }

  void changeProgram(String? value) {
    emit(state.copyWith(program: value ?? 'Orphan Sponsorship'));
  }
}

class PaymentState {
  final String paymentMethod;
  final String program;

  const PaymentState({
    required this.paymentMethod,
    required this.program,
  });

  PaymentState copyWith({
    String? paymentMethod,
    String? program,
  }) {
    return PaymentState(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      program: program ?? this.program,
    );
  }
}
