// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_email_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpEmailDTO _$SignUpEmailDTOFromJson(Map<String, dynamic> json) =>
    SignUpEmailDTO(
      email: json['email'] as String?,
      password: json['password'] as String?,
      fullname: json['fullname'] as String?,
    );

Map<String, dynamic> _$SignUpEmailDTOToJson(SignUpEmailDTO instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullname': instance.fullname,
      'password': instance.password,
    };
