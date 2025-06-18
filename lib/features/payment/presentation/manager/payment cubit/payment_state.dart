class PaymentState {
  final String paymentMethod;
  final String program; // NOT nullable

  PaymentState({
    required this.paymentMethod,
    required this.program,
  });

  PaymentState copyWith({
    String? paymentMethod,
    String? program,
  }) {
    return PaymentState(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      program: program ?? this.program, // safe fallback
    );
  }
}
