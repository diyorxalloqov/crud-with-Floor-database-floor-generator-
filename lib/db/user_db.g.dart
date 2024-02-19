// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorUserDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$UserDatabaseBuilder databaseBuilder(String name) =>
      _$UserDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$UserDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$UserDatabaseBuilder(null);
}

class _$UserDatabaseBuilder {
  _$UserDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$UserDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$UserDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<UserDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$UserDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$UserDatabase extends UserDatabase {
  _$UserDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `UserModel` (`userID` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT)');

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
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'UserModel',
            (UserModel item) =>
                <String, Object?>{'userID': item.userID, 'name': item.name},
            changeListener),
        _userModelUpdateAdapter = UpdateAdapter(
            database,
            'UserModel',
            ['userID'],
            (UserModel item) =>
                <String, Object?>{'userID': item.userID, 'name': item.name},
            changeListener),
        _userModelDeletionAdapter = DeletionAdapter(
            database,
            'UserModel',
            ['userID'],
            (UserModel item) =>
                <String, Object?>{'userID': item.userID, 'name': item.name},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  final UpdateAdapter<UserModel> _userModelUpdateAdapter;

  final DeletionAdapter<UserModel> _userModelDeletionAdapter;

  @override
  Stream<List<UserModel>> getAllUserModels() {
    return _queryAdapter.queryListStream('SELECT * FROM UserModel',
        mapper: (Map<String, Object?> row) => UserModel(
            userID: row['userID'] as int?, name: row['name'] as String?),
        queryableName: 'UserModel',
        isView: false);
  }

  @override
  Future<void> insertUserModel(UserModel usermodelUserModel) async {
    await _userModelInsertionAdapter.insert(
        usermodelUserModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUserModel(UserModel usermodelUserModel) async {
    await _userModelUpdateAdapter.update(
        usermodelUserModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUserModel(UserModel usermodelUserModel) async {
    await _userModelDeletionAdapter.delete(usermodelUserModel);
  }
}
