// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SecureHiveAdapter extends TypeAdapter<SecureHive> {
  @override
  final int typeId = 2;

  @override
  SecureHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SecureHive(
      userToken: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SecureHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.userToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecureHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
