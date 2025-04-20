import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:8000',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );
});

final chatResponseProvider =
    FutureProvider.family<String, String>((ref, userMessage) async {
  final dio = ref.read(dioProvider);

  try {
    final response = await dio.post('/chat', data: {
      'message': userMessage,
    });

    if (response.statusCode == 200) {
      return response.data['reply'] ?? 'No reply from AI.';
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  } catch (e) {
    return 'Error: $e';
  }
});
