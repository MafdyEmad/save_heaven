// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveAdapter extends TypeAdapter<UserHive> {
  @override
  final int typeId = 3;

  @override
  UserHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHive(
      id: fields[0] as String,
      name: fields[1] as String,
      gender: fields[2] as String,
      address: fields[3] as String,
      email: fields[4] as String,
      birthdate: fields[5] as DateTime,
      phone: fields[6] as String,
      password: fields[7] as String,
      role: fields[8] as String,
      active: fields[9] as bool,
      createdAt: fields[10] as DateTime,
      updatedAt: fields[11] as DateTime,
      image: fields[14] as String?,
      v: fields[12] as int,
      orphanage: fields[13] as OrphanageHive?,
    );
  }

  @override
  void write(BinaryWriter writer, UserHive obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.birthdate)
      ..writeByte(6)
      ..write(obj.phone)
      ..writeByte(7)
      ..write(obj.password)
      ..writeByte(8)
      ..write(obj.role)
      ..writeByte(9)
      ..write(obj.active)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.v)
      ..writeByte(13)
      ..write(obj.orphanage)
      ..writeByte(14)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkScheduleHiveAdapter extends TypeAdapter<WorkScheduleHive> {
  @override
  final int typeId = 5;

  @override
  WorkScheduleHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkScheduleHive(
      workDays: (fields[0] as List).cast<String>(),
      workHours: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkScheduleHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.workDays)
      ..writeByte(1)
      ..write(obj.workHours);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkScheduleHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrphanageHiveAdapter extends TypeAdapter<OrphanageHive> {
  @override
  final int typeId = 6;

  @override
  OrphanageHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrphanageHive(
      name: fields[0] as String,
      adminName: fields[1] as String,
      image: fields[2] as String?,
      address: fields[3] as String,
      currentChildren: fields[4] as int,
      totalCapacity: fields[5] as int,
      active: fields[6] as bool,
      staffCount: fields[7] as int,
      establishedDate: fields[8] as DateTime,
      phone: fields[9] as String,
      birthdate: fields[10] as DateTime,
      workSchedule: fields[11] as WorkScheduleHive,
    );
  }

  @override
  void write(BinaryWriter writer, OrphanageHive obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.adminName)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.currentChildren)
      ..writeByte(5)
      ..write(obj.totalCapacity)
      ..writeByte(6)
      ..write(obj.active)
      ..writeByte(7)
      ..write(obj.staffCount)
      ..writeByte(8)
      ..write(obj.establishedDate)
      ..writeByte(9)
      ..write(obj.phone)
      ..writeByte(10)
      ..write(obj.birthdate)
      ..writeByte(11)
      ..write(obj.workSchedule);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrphanageHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
