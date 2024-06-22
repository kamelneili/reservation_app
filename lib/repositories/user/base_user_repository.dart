import '../../models/data_model.dart';
import '/models/models.dart';

abstract class BaseUserRepository {
  Stream<User> getUser(String userId);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Stream<List<User>> getDoctors();
}
