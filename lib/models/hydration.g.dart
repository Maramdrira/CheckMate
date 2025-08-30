// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hydration.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HydrationSettingsAdapter extends TypeAdapter<HydrationSettings> {
  @override
  final int typeId = 1;

  @override
  HydrationSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HydrationSettings(
      dailyGoal: fields[0] as int,
      reminderInterval: fields[1] as int,
      lastReminderTime: fields[2] as DateTime,
      glassesConsumed: fields[3] as int,
      lastResetDate: fields[4] as DateTime,
      consumptionHistory: (fields[5] as List?)?.cast<DateTime>(),
    );
  }

  @override
  void write(BinaryWriter writer, HydrationSettings obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.dailyGoal)
      ..writeByte(1)
      ..write(obj.reminderInterval)
      ..writeByte(2)
      ..write(obj.lastReminderTime)
      ..writeByte(3)
      ..write(obj.glassesConsumed)
      ..writeByte(4)
      ..write(obj.lastResetDate)
      ..writeByte(5)
      ..write(obj.consumptionHistory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HydrationSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}