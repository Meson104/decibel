import 'dart:convert';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstants.serverURL}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        // print(Left(AppFailure(resBodyMap['detail'])));
        return Left(AppFailure(resBodyMap['detail']));
      }
      // print(Right(UserModel.fromMap(resBodyMap)));
      return Right(UserModel(name: name, email: email, id: resBodyMap['id']));
    } catch (e) {
      // print(Left(AppFailure(e.toString())));
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Either<AppFailure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
          Uri.parse('${ServerConstants.serverURL}/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}));

      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        // print(Left(AppFailure(resBodyMap['detail'])));
        return Left(AppFailure(resBodyMap['detail']));
      }
      // print(Right(UserModel.fromMap(resBodyMap)));
      return Right(UserModel.fromMap(resBodyMap));
    } catch (e) {
      // print(Left(AppFailure(e.toString())));
      return Left(AppFailure(e.toString()));
    }
  }
}
