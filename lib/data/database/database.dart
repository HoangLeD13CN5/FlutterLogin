import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor/floor.dart';
import 'package:onepay_sign_auth_dart/data/database/dao/UserDao.dart';
import 'package:onepay_sign_auth_dart/data/database/entity/user_entity.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [UserEntity])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}