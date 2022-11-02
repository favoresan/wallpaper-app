// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortraitResponse _$PortraitResponseFromJson(Map<String, dynamic> json) =>
    PortraitResponse(
      json['portrait'] as String?,
    );

Map<String, dynamic> _$PortraitResponseToJson(PortraitResponse instance) =>
    <String, dynamic>{
      'portrait': instance.image,
    };

SourceResponse _$SourceResponseFromJson(Map<String, dynamic> json) =>
    SourceResponse(
      json['src'] == null
          ? null
          : PortraitResponse.fromJson(json['src'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SourceResponseToJson(SourceResponse instance) =>
    <String, dynamic>{
      'src': instance.src,
    };

ImageResponse _$ImageResponseFromJson(Map<String, dynamic> json) =>
    ImageResponse(
      (json['photos'] as List<dynamic>?)
          ?.map((e) => SourceResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImageResponseToJson(ImageResponse instance) =>
    <String, dynamic>{
      'photos': instance.grid,
    };
