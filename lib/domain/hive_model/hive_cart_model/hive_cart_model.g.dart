// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCartModelAdapter extends TypeAdapter<HiveCartModel> {
  @override
  final int typeId = 0;

  @override
  HiveCartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCartModel(
      productId: fields[0] as int,
      productName: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as double,
      size: fields[4] as String,
      image: fields[5] as String,
      stock: fields[6] as int,
      type: fields[8] as String,
      quantity: fields[7] as int,
      voucherDiscount: fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCartModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.stock)
      ..writeByte(7)
      ..write(obj.quantity)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.voucherDiscount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
