// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actualite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActualiteAdapter extends TypeAdapter<Actualite> {
  @override
  final int typeId = 0;

  @override
  Actualite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Actualite(
      id: fields[0] as String?,
      category: fields[1] as String,
      price: fields[2] as String?,
      image: fields[3] as String,
      description: fields[4] as String,
      name: fields[5] as String,
      nbprs: fields[6] as String,
      dispo: fields[7] as bool?,
      isRecommended: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Actualite obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.nbprs)
      ..writeByte(7)
      ..write(obj.dispo)
      ..writeByte(8)
      ..write(obj.isRecommended);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActualiteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
