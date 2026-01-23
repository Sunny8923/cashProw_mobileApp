import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) {
    return remoteDataSource.login(request);
  }

  @override
  Future<UserModel> me() {
    return remoteDataSource.me();
  }
}
