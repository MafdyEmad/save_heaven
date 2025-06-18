// send_message_cubit.dart
import 'package:bloc/bloc.dart';

class SendMessageCubit extends Cubit<String?> {
  SendMessageCubit() : super(null);

  void pickFile(String? fileName) => emit(fileName);

  void clearFile() => emit(null);
}
