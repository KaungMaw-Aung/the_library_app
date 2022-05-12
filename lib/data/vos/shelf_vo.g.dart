// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShelfVOAdapter extends TypeAdapter<ShelfVO> {
  @override
  final int typeId = 2;

  @override
  ShelfVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShelfVO(
      fields[0] as String,
      fields[1] as String,
      fields[3] as DateTime,
    )..books = (fields[2] as List).cast<BookVO>();
  }

  @override
  void write(BinaryWriter writer, ShelfVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.books)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelfVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
