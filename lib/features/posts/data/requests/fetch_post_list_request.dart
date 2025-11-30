class FetchPostListRequest {
  final int? perPage;
  final int? nextPage;
  final int? currentPage;
  final String? mediaType;
  final String? search;

  const FetchPostListRequest({
    this.currentPage,
    this.nextPage,
    this.perPage = 10,
    this.mediaType,
    this.search = '',
  });
}

enum MediaType {
  image,
  video,
  audio,
  document,
  pdf,
  pptx,
  csv,
  json,
  jpg,
  png,
  mp4,
  mp3,
}

