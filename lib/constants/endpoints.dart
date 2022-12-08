import '../utils/credentials.dart';

final serverUrl = 'https://${Credentials.baseUrl}';
final localUrl = 'http://${Credentials.baseUrl}';
final socketUrl = Credentials.socketUrl;

class AuthEndpoints {
  static String base = '$localUrl/api/auth';
  static String login = '$base/login';
  static String sign_up = '$base/register';
}

class UserEndpoints {
  static String base = '$localUrl/api';
  static String getUsers = '$base/user';
}
