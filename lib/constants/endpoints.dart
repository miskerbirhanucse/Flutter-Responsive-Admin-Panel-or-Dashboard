import '../utils/credentials.dart';

final serverUrl = 'https://${Credentials.baseUrl}';
final localUrl = 'http://${Credentials.baseUrl}';
final socketUrl = Credentials.socketUrl;

class AuthEndpoints {
  static String base = '$localUrl/api/auth';
  static String login = '$base/login';
  static String sign_up = '$base/register';
}

class SocketEndPoints {
  static String base = socketUrl;
  static String client = '$socketUrl/client';
}
