import 'dart:async';

import 'package:data/datasource/local/db/app_database.dart';
import 'package:data/datasource/remote/service/login_service.dart';
import 'package:data/datasource/remote/service/sign_up_service.dart';
import 'package:data/repository_impl/base/base_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../datasource/local/db/app_shared_preferences.dart';
import '../mapper/login_mapper.dart';

@LazySingleton(as: AuthenticationRepository)
class AuthenticationRepositoryImpl extends BaseRepository implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this._loginService, this._signUpService, this._appDatabase, this._appSharedPreferences);

  final LoginService _loginService;
  final SignUpService _signUpService;
  final AppDatabase _appDatabase;
  final AppSharedPreferences _appSharedPreferences;

  final _controller = StreamController<AuthenticationStatus>();

  @override
  Future<Result<LoginEntity>> doLogin(LoginParam param) async {
    final response = await apiHandler(
      _loginService.doLogin(LoginMapper.toLoginUsernameDto(param)),
      mapper: (data) {
        return LoginMapper.toEntity(data);
      },
    );
    response.when(
      error: (type, error, code) {
        _controller.add(AuthenticationStatus.unauthenticated);
      },
      success: (data) async {
        await Future.wait([
          _appSharedPreferences.setString(TokenKeys.accessToken, data!.token),
          _appSharedPreferences.setString(TokenKeys.refreshToken, data.refreshToken),
        ]);
        _controller.add(AuthenticationStatus.authenticated);
      },
    );
    return response;
  }

  @override
  Future<Result<void>> doSignUp() async {
    throw UnimplementedError();
  }

  @override
  void close() {
    _controller.close();
  }

  @override
  Stream<AuthenticationStatus> getAuthStream() {
    return _controller.stream;
  }

  @override
  Future<void> logOut() async {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  @override
  Future<void> saveUserToLocal() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() async {
    // final response = await _appDatabase.userDao.findAllUser();
    // bool hasUser = response.isNotEmpty;
    // return hasUser;
    final response = _appSharedPreferences.getString(TokenKeys.accessToken);
    bool isLoggin = response != null && response != '';
    _controller.add(isLoggin ? AuthenticationStatus.authenticated : AuthenticationStatus.unauthenticated);

    return isLoggin;
  }

  @override
  Future<Result<bool>> doLogout() async {
    await Future.wait(
      [
        _appSharedPreferences.remove(TokenKeys.accessToken),
        _appSharedPreferences.remove(TokenKeys.refreshToken),
      ],
    );
    _controller.add(AuthenticationStatus.unauthenticated);
    return ValueSuccess(true);
  }
}
