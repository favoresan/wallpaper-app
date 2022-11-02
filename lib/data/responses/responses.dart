import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class PortraitResponse {
  @JsonKey(name: 'portrait')
  String? image;
  PortraitResponse(this.image);
  //from json
  factory PortraitResponse.fromJson(Map<String, dynamic> json) =>
      _$PortraitResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$PortraitResponseToJson(this);
}

@JsonSerializable()
class SourceResponse {
  @JsonKey(name: 'src')
  PortraitResponse? src;
  SourceResponse(this.src);
  //from json
  factory SourceResponse.fromJson(Map<String, dynamic> json) =>
      _$SourceResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$SourceResponseToJson(this);
}

@JsonSerializable()
class ImageResponse {
  @JsonKey(name: 'photos')
  List<SourceResponse>? grid;
  ImageResponse(this.grid);
  //from json
  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);
//to json
  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);
}
