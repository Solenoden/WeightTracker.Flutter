import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weight_tracker_app/services/session_storage_service.dart';
import '../models/user_model.dart';

class LoginUserResponse {
  bool? isValid;
  User? user;
  String? token;

  LoginUserResponse({this.isValid, this.user, this.token});
}

class AuthorizationService {
  SessionStorageService sessionStorageService = SessionStorageService();

  Future<LoginUserResponse> loginUser(
    String emailAddress,
    String password,
  ) async {
    final url = Uri.parse('${dotenv.get('API_URL')}/login');
    Response response = await post(
      url,
      body: {"emailAddress": emailAddress, "hashedPassword": password},
    );
    final dynamic body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final token = body['token'];
      sessionStorageService.setAuthToken(token);
      sessionStorageService.setLoggedInUser(User(
        id: body['user']['id'],
        name: body['user']['name'],
        surname: body['user']['surname'],
        emailAddress: body['user']['emailAddress'],
      ));
    }

    final User? user = body['user'] != null ? User(
      id: body['user']['id'],
      name: body['user']['name'],
      surname: body['user']['surname'],
      emailAddress: body['user']['emailAddress'],
    ): null;

    return LoginUserResponse(
      isValid: body['isValid'],
      token: body['token'],
      user: user,
    );
  }
}
