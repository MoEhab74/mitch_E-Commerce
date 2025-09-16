import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_states.dart';
import 'package:minimal_e_commerce/helper/api.dart';
import 'package:minimal_e_commerce/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Login user method
  Future<UserModel> loginUser({
    required String username,
    required String password,
  }) async {
    // UserModel not void
    emit(AuthLoading());
    // use API to login user
    Map<String, dynamic> jsonData = await Api().postRequest(
      url: 'https://dummyjson.com/auth/login',
      body: {'username': username, 'password': password},
      // I'll pass the token after login the user
      token: null,
    );
    // Store the user id and access token in the box
    final accessToken = jsonData['accessToken'];
    final refreshToken = jsonData['refreshToken'];
    final id = jsonData['id'].toString();

    var box = Hive.box('auth');
    await box.put('accessToken', accessToken);
    await box.put('refreshToken', refreshToken);
    await box.put('userId', id);
    // Store the whole user to use any data from it whenever you need
    await box.put('user', jsonData);
    log(
      'User access token, refresh token, id stored successfully and whole user data stored in the box',
    );
    // Convert the JSON data to UserModel object
    UserModel userModel = UserModel.fromJson(jsonData);
    emit(AuthSuccess(user: userModel));
    return userModel;
  }
  // logout user method
  Future<void> logoutUser() async {
    var box = Hive.box('auth');
    await box.clear();
    emit(AuthInitial());
  }

  // Helper to get current user from Hive
  UserModel? getCurrentUser() {
    var box = Hive.box('auth');
    final userJson = box.get('user');
    if (userJson != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userJson));
    }
    return null;
  }

  // checkUserLoggedIn method
  bool checkUserLoggedIn() {
    var box = Hive.box('auth');
    final accessToken = box.get('accessToken');
    if (accessToken != null) {
      emit(AuthSuccess(user: getCurrentUser()!));
      return true;
    }
    emit(AuthInitial());
    return false;
  }
}
