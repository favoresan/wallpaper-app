import 'package:wallpaper_demo/app/extensions.dart';
import 'package:wallpaper_demo/data/responses/responses.dart';
import 'package:wallpaper_demo/domain/model/model.dart';

const EMPTY = '';
const ZERO = 0;

extension PortraitResponseMapper on PortraitResponse? {
  Portrait toDomain() {
    return Portrait(this?.image?.orEmpty() ?? EMPTY);
  }
}

extension SourceResponseMapper on SourceResponse? {
  Source toDomain() {
    return Source(this?.src?.toDomain());
  }
}

extension GridResponseMapper on ImageResponse? {
  Images toDomain() {
    List<Source> mappedSources =
        (this?.grid?.map((src) => src.toDomain()) ?? Iterable.empty())
            .cast<Source>()
            .toList();
    return Images(mappedSources);
  }
}
