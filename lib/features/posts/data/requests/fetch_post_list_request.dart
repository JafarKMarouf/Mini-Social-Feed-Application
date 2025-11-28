class FetchPostListRequest {
  final int perPage;
  final MediaType? mediaType;
  final String? search;

  const FetchPostListRequest({
    this.perPage = 0,
    this.mediaType,
    this.search = '',
  });
}

enum MediaType { image, video, audio, document }
