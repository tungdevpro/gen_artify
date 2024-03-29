// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../usecase/config_usecase.dart' as _i3;
import '../usecase/config_usecase_impl.dart' as _i4;
import '../usecase/sign_up/sign_up_firebase_usecase_impl.dart' as _i6;
import '../usecase/sign_up/sign_up_usecase.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt createDomainLayer({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.ConfigUsecase>(() => _i4.ConfigUsecaseImpl());
    gh.factory<_i5.SignUpUsecase>(() => _i6.SignUpFirebaseUsecaseImpl());
    return this;
  }
}
