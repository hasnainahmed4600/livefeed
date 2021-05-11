import 'package:repository_core/src/entities/entities.dart';

abstract class UserRepositoryCore {
  Future<void> createUser(
    UserEntity newUser,
    /* List<SecurityQuestionAnswer> securityQuestions */
  );
}
