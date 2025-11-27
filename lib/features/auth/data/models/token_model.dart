class TokenModel {
  final String tokenType;
  final String accessToken;
  final String refreshToken;
  final String accessTokenExpire;
  final String refreshTokenExpire;

  const TokenModel({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpire,
    required this.refreshTokenExpire,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      tokenType: json['token_type'],
      accessToken: json['access_token'],
      accessTokenExpire: json['access_token_expires_at'],
      refreshToken: json['refresh_token'],
      refreshTokenExpire: json['refresh_token_expires_at'],
    );
  }
}
