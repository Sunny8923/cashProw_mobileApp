import '../../data/models/user_model.dart';
import '../repository/auth_repository.dart';

class MeUseCase {
  final AuthRepository repository;
  MeUseCase(this.repository);

  Future<UserModel> call() async {
    return await repository.me();
  }
}
