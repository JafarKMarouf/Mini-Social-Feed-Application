class FetchPostListRequest {
  final int? perPage;
  final int? nextPage;
  final int? currentPage;
  final MediaType? mediaType;
  final String? search;

  const FetchPostListRequest({
    this.currentPage,
    this.nextPage,
    this.perPage = 10,
    this.mediaType,
    this.search = '',
  });
}

enum MediaType { image, video, audio, document }
