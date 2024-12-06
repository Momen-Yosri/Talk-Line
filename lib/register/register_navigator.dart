import 'package:talk_line/model/user_model.dart';

abstract class RegisterNavigator {
void showLoading();
void hideLoading();
void showMessage(String message,bool isSuccess);
void navigateToHome(UserModel user);
}