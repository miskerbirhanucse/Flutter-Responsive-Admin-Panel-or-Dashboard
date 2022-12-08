import 'package:admin/src/app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'network/client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  _setupApiClient();
  runApp(App());
}

void _setupApiClient() {
  final apiClient = ApiClientImpl(Dio());
  GetIt.I.registerSingleton<ApiClient>(apiClient);
}
