import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthViewModel extends Cubit<State>{
  AuthViewModel(super.initialState);

}

abstract class AuthState {
}
class AuthisLoading extends AuthState {
  final bool isLoading;
  AuthisLoading(this.isLoading);
}