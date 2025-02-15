// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 0;

  @override
  TransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      id: fields[0] as String,
      name: fields[1] as String,
      merchant: fields[2] as String,
      billingAmount: fields[3] as int,
      billingCurrency: fields[4] as String,
      image: fields[5] as String,
      date: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.merchant)
      ..writeByte(3)
      ..write(obj.billingAmount)
      ..writeByte(4)
      ..write(obj.billingCurrency)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name',
      'merchant',
      'billingAmount',
      'billingCurrency',
      'image',
      'date'
    ],
  );
  return TransactionModel(
    id: json['id'] as String,
    name: json['name'] as String,
    merchant: json['merchant'] as String,
    billingAmount: (json['billingAmount'] as num).toInt(),
    billingCurrency: json['billingCurrency'] as String,
    image: json['image'] as String,
    date: TransactionModel._dateFromJson((json['date'] as num).toInt()),
  );
}

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'merchant': instance.merchant,
      'billingAmount': instance.billingAmount,
      'billingCurrency': instance.billingCurrency,
      'image': instance.image,
      'date': TransactionModel._dateToJson(instance.date),
    };
