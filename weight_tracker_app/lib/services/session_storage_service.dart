import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class SessionStorageService {
  late SharedPreferences sharedPreferences;

  final authTokenStorageKey = 'AuthToken';
  final loggedInUserStorageKey = 'LoggedInUser';

  SessionStorageService() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  String? getAuthToken() {
    return sharedPreferences.getString(authTokenStorageKey);
  }

  void setAuthToken(String authToken) {
    sharedPreferences.setString(authTokenStorageKey, authToken);
  }

  User? getLoggedInUser() {
    final json = sharedPreferences.getString(loggedInUserStorageKey);
    if (json != null && json.isNotEmpty) {
      final object = jsonDecode(json);
      User user = User(
          id: object.id,
          name: object.name,
          surname: object.surname,
          emailAddress: object.emailAddress,
      );

      return user;
    }

    return null;
  }

  void setLoggedInUser(User user) {
    final json = jsonEncode(user);
    sharedPreferences.setString(loggedInUserStorageKey, json);
  }
}
