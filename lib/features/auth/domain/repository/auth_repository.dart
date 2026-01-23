import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<UserModel> me();
}
