import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: true, createFactory: true)
class UserModel {
  UserModel(
    this.name,
    this.starts,
    this.ends,
    this.longitude,
    this.latitude,
    this.placeName,
  );

  final String? name;
  final DateTime starts;
  final DateTime ends;
  final double longitude;
  final double latitude;
  final String placeName;
}
