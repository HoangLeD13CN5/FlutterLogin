// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao _userDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` TEXT NOT NULL, `password` TEXT NOT NULL, `fullname` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userEntityInsertionAdapter = InsertionAdapter(
            database,
            'UserEntity',
            (UserEntity item) => <String, dynamic>{
                  'id': item.id,
                  'username': item.username,
                  'password': item.password,
                  'fullname': item.fullname
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _userEntityMapper = (Map<String, dynamic> row) => UserEntity(
      row['id'] as int,
      row['username'] as String,
      row['password'] as String,
      row['fullname'] as String);

  final InsertionAdapter<UserEntity> _userEntityInsertionAdapter;

  @override
  Future<List<UserEntity>> findAllPersons() async {
    return _queryAdapter.queryList('SELECT * FROM UserEntity',
        mapper: _userEntityMapper);
  }

  @override
  Future<UserEntity> findPersonById(int id) async {
    return _queryAdapter.query('SELECT * FROM UserEntity WHERE id = ?',
        arguments: <dynamic>[id], mapper: _userEntityMapper);
  }

  @override
  Future<void> deleteAllUsers() async {
    await _queryAdapter.queryNoReturn('DELETE FROM UserEntity');
  }

  @override
  Future<void> insertPerson(UserEntity person) async {
    await _userEntityInsertionAdapter.insert(person, OnConflictStrategy.abort);
  }

  @override
  Future<void> replaceUsers(List<UserEntity> users) async {
    if (database is sqflite.Transaction) {
      await super.replaceUsers(users);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.userDao.replaceUsers(users);
      });
    }
  }
}
