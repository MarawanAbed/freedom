import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';
@JsonSerializable()
class UserModel {
  final String? uId;
  final String? name;
  final String? email;
  final String? password;
  final String? image;
  @TimestampConverter()
  final DateTime? lastActive;
  final String? description;
  @JsonKey(fromJson: _fromJsonBool)
  final bool? isOnline;
  final String? source;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.lastActive,
    required this.description,
    required this.isOnline,
    required this.source,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }


  Map<String, dynamic> toJson() {
    return  _$UserModelToJson(this);
  }

  static bool? _fromJsonBool(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value is String) {
      return value.toLowerCase() == 'true';
    }
    return null;
  }
}

class TimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const TimestampConverter();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is String) {
      // Handle the case where the input is a String (e.g., from JSON)
      return DateTime.tryParse(timestamp);
    }
    return null; // Return null if the input is not a Timestamp or String
  }

  @override
  dynamic toJson(DateTime? date) {
    if (date != null) {
      return Timestamp.fromDate(date);
    }
    return null; // Return null if the input DateTime is null
  }
}