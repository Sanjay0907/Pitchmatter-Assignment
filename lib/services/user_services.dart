import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pitchmatter_assignment/model/user_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/users',
        options: Options(
          headers: {
            // 'User-Agent': 'Dio/Flutter',
            'Content-Type': 'application/json'
          },
        ),
      );
      log(response.statusCode.toString());
      return (response.data as List)
          .map((json) => UserModel.fromJson(json))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
