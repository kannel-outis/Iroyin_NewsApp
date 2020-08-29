// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteAdapter extends TypeAdapter<Favorite> {
  @override
  final int typeId = 0;

  @override
  Favorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorite(
      favoriteTitle: fields[0] as String,
      favoriteDescription: fields[1] as String,
      favoriteUrl: fields[2] as String,
      favoriteUrlToImage: fields[3] as String,
      favoriteAuthor: fields[4] as String,
      favoritePublishedAT: fields[5] as String,
      favoriteContent: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Favorite obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.favoriteTitle)
      ..writeByte(1)
      ..write(obj.favoriteDescription)
      ..writeByte(2)
      ..write(obj.favoriteUrl)
      ..writeByte(3)
      ..write(obj.favoriteUrlToImage)
      ..writeByte(4)
      ..write(obj.favoriteAuthor)
      ..writeByte(5)
      ..write(obj.favoritePublishedAT)
      ..writeByte(6)
      ..write(obj.favoriteContent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
