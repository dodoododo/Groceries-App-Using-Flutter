// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountModelImpl _$$AccountModelImplFromJson(Map<String, dynamic> json) =>
    _$AccountModelImpl(
      email: json['email'] as String,
      username: json['username'] as String?,
      name: json['displayName'] as String?,
      avatarUrl: json['profilePic'] as String?,
    );

Map<String, dynamic> _$$AccountModelImplToJson(_$AccountModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'displayName': instance.name,
      'profilePic': instance.avatarUrl,
    };
