// import 'dart:convert';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class UserModel {
//   int id;
//   String name;
//   String userName;
//   String email;
//   String phone;
//   String website;
//   Address address;
//   Company conpany;
//   UserModel({
//     required this.id,
//     required this.name,
//     required this.userName,
//     required this.email,
//     required this.phone,
//     required this.website,
//     required this.address,
//     required this.conpany,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'userName': userName,
//       'email': email,
//       'phone': phone,
//       'website': website,
//       'address': address.toMap(),
//       'conpany': conpany.toMap(),
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       id: map['id'] as int,
//       name: map['name'] as String,
//       userName: map['userName'] as String,
//       email: map['email'] as String,
//       phone: map['phone'] as String,
//       website: map['website'] as String,
//       address: Address.fromMap(map['address'] as Map<String,dynamic>),
//       conpany: Company.fromMap(map['conpany'] as Map<String,dynamic>),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// class Address {
//   String street;

//   String suite;
//   String city;
//   String zipcode;
//   String latitude;
//   String longitude;
//   Address({
//     required this.street,
//     required this.suite,
//     required this.city,
//     required this.zipcode,
//     required this.latitude,
//     required this.longitude,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'street': street,
//       'suite': suite,
//       'city': city,
//       'zipcode': zipcode,
//       'latitude': latitude,
//       'longitude': longitude,
//     };
//   }

//   factory Address.fromMap(Map<String, dynamic> map) {
//     return Address(
//       street: map['street'] as String,
//       suite: map['suite'] as String,
//       city: map['city'] as String,
//       zipcode: map['zipcode'] as String,
//       latitude: map['latitude'] as String,
//       longitude: map['longitude'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Address.fromJson(String source) =>
//       Address.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// class Company {
//   String name;
//   String catchPhrase;
//   String bs;
//   Company({
//     required this.name,
//     required this.catchPhrase,
//     required this.bs,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'catchPhrase': catchPhrase,
//       'bs': bs,
//     };
//   }

//   factory Company.fromMap(Map<String, dynamic> map) {
//     return Company(
//       name: map['name'] as String,
//       catchPhrase: map['catchPhrase'] as String,
//       bs: map['bs'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Company.fromJson(String source) =>
//       Company.fromMap(json.decode(source) as Map<String, dynamic>);
// }
class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    username: json['username'],
    email: json['email'],
    address: json['address'] != null ? Address.fromJson(json['address']) : null,
    phone: json['phone'],
    website: json['website'],
    company: json['company'] != null ? Company.fromJson(json['company']) : null,
  );
}

class Address {
  final String street;
  final String? suite;
  final String city;
  final String zipcode;
  final Geo? geo;

  Address({required this.street, this.suite, required this.city, required this.zipcode, this.geo});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json['street'],
    suite: json['suite'],
    city: json['city'],
    zipcode: json['zipcode'],
    geo: json['geo'] != null ? Geo.fromJson(json['geo']) : null,
  );
}

class Geo {
  final String? lat;
  final String? lng;

  Geo({this.lat, this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    lat: json['lat'],
    lng: json['lng'],
  );
}

class Company {
  final String name;
  final String? catchPhrase;
  final String? bs;

  Company({required this.name, this.catchPhrase, this.bs});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json['name'],
    catchPhrase: json['catchPhrase'],
    bs: json['bs'],
  );
}
