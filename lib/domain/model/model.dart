class Portrait {
  String portrait;
  Portrait(this.portrait);
}

class Source {
  Portrait? src;
  Source(this.src);
}

class Images {
  List<Source> photo;
  Images(this.photo);
}

class Category {
  String image;
  String title;
  Category({required this.image, required this.title});
}

class SearchRequest {
  String search;
  SearchRequest({required this.search});
}
