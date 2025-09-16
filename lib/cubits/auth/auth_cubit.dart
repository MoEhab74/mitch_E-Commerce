import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Login user method
  Future<void> loginUser() async { // UserModel not void
    emit(AuthLoading());
    // use API to login user

  }
}