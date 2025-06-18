// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_setting_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingHiveAdapter extends TypeAdapter<UserSettingHive> {
  @override
  final int typeId = 4;

  @override
  UserSettingHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSettingHive(
      isNotificationEnabled: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserSettingHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isNotificationEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
