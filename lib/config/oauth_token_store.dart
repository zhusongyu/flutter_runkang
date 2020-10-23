class OAuthTokenStore {
  static String token;
  static fetchToken() {
    return token;
  }

  static saveToken(String tokenStr) {
    token = tokenStr;
  }
}
