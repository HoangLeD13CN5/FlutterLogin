import 'package:onepay_sign_auth_dart/data/database/entity/user_entity.dart';
import 'package:onepay_sign_auth_dart/data/shared_preferences/preferences_data.dart';

abstract class UserRepository {
  Future<UserEntity> getUser(String username, String password);
  Future<bool> createUser(String username, String password, String fullname);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<bool> createUser(String username, String password, String fullname) {
    // TODO: implement createUser
    var username = PreferencesData().getUsername();
    throw UnimplementedError();
  }

  @override
  Future<UserEntity> getUser(String username, String password) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

}