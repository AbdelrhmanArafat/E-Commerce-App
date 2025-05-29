// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShippingAddressModel {
  final String id;
  final String fullName;
  final String country;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;

  ShippingAddressModel({
    required this.id,
    required this.fullName,
    required this.country,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'country': country,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'isDefault': isDefault,
    };
  }

  factory ShippingAddressModel.fromMap(
      Map<String, dynamic> map , String documentId) {
    return ShippingAddressModel(
      id: documentId,
      fullName: map['fullName'] as String,
      country: map['country'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      zipCode: map['zipCode'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }

  ShippingAddressModel copyWith({
    String? id,
    String? fullName,
    String? country,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    bool? isDefault,
  }) {
    return ShippingAddressModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      country: country ?? this.country,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
