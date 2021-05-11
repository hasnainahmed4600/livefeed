import 'package:repository_core/repository_core.dart';

class UserRepository implements UserRepositoryCore {
  @override
  Future<void> createUser(
    UserEntity newUser,
    /* List<SecurityQuestionAnswer> securityQuestions */
  ) async {
    await Future.delayed(const Duration(milliseconds: 300), () {});
  }
}
