import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final chatProvider = Provider((ref) => ChatService());

class ChatService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://192.168.0.107:8000';
  Future<String> getBotReply(String userInput) async {
    final response = await _dio.post(
      '$baseUrl/chat',
      data: {'user_input': userInput},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200 && response.data['bot_reply'] != null) {
      return response.data['bot_reply'];
    } else {
      throw Exception('Failed to get bot response');
    }
  }
}
