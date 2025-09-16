import 'package:flutter_bloc/flutter_bloc.dart';
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
    // Convert the JSON data to UserModel object
    UserModel userModel = UserModel.fromJson(jsonData);
    emit(AuthSuccess(user: userModel));
    return userModel;
  }
}
