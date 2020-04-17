class AccessToken {
  
  final String access_token; 
  final String expires; 

  AccessToken({this.access_token, this.expires});

  factory AccessToken.fromJson(Map<String,dynamic> json) {
    return AccessToken(
      access_token: json['access_token'], 
      expires: json['expires'],
    );
  }
}