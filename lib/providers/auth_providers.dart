import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulsync/models/login_models.dart';
import '../api/auth_api.dart';

final authApiProvider = Provider((ref) => AuthApi());

final loginProvider =
    FutureProvider.family<String, LoginRequest>((ref, data) async {
  final api = ref.read(authApiProvider);
  return await api.login(data);
});
