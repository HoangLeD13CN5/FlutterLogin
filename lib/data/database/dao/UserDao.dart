import 'package:floor/floor.dart';
import 'package:onepay_sign_auth_dart/data/database/entity/user_entity.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM UserEntity')
  Future<List<UserEntity>> findAllPersons();

  @Query('SELECT * FROM UserEntity WHERE id = :id')
  Future<UserEntity> findPersonById(int id);

  @Query('DELETE FROM UserEntity')
  Future<void> deleteAllUsers(); // query without returning an entity

  @insert
  Future<void> insertPerson(UserEntity person);

  @transaction
  Future<void> replaceUsers(List<UserEntity> users) async {
    await deleteAllUsers();
  }
}