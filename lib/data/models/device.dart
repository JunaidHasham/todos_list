import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable()
class Device {
  final String id;
  final String name;
  Data? data;

  Device({
    required this.id,
    required this.name,
    this.data,
  });

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  @override
  String toString() {
    return 'Device{id: $id, name: $name, data: $data}';
  }
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'color')
  String? color1;

  @JsonKey(name: 'Color')
  String? color2;

  @JsonKey(name: 'capacity')
  String? capacity1;

  @JsonKey(name: 'capacity GB')
  int? capacityInGB;

  @JsonKey(name: 'price')
  double? price1;

  @JsonKey(name: 'generation')
  String? generation1;

  int? year;

  @JsonKey(name: 'CPU model')
  String? cpuModel;

  @JsonKey(name: 'Hard disk size')
  String? hardDiskSize;

  @JsonKey(name: 'Strap Colour')
  String? strapColour;

  @JsonKey(name: 'Case Size')
  String? caseSize;

  @JsonKey(name: 'Description')
  String? description;

  @JsonKey(name: 'Capacity')
  String? capacity2;

  @JsonKey(name: 'Screen size')
  double? screenSize;

  @JsonKey(name: 'Generation')
  String? generation2;

  @JsonKey(name: 'Price')
  String? price2;

  Data({
    this.color1,
    this.color2,
    this.capacity1,
    this.capacityInGB,
    this.price1,
    this.generation1,
    this.year,
    this.cpuModel,
    this.hardDiskSize,
    this.strapColour,
    this.caseSize,
    this.description,
    this.capacity2,
    this.screenSize,
    this.generation2,
    this.price2,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  String toString() {
    return 'Data{color1: $color1, color2: $color2, capacity1: $capacity1, capacityInGB: $capacityInGB, price1: $price1, generation1: $generation1, year: $year, cpuModel: $cpuModel, hardDiskSize: $hardDiskSize, strapColour: $strapColour, caseSize: $caseSize, description: $description, capacity2: $capacity2, screenSize: $screenSize, generation2: $generation2, price2: $price2}';
  }
}
