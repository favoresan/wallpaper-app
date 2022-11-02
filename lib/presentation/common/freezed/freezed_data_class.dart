import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_class.freezed.dart';

@freezed
class SearchObject with _$SearchObject {
  factory SearchObject(String search) = _SearchObject;
}
