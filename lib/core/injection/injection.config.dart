// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/transfer/data/repositories/transfer_repository.dart'
    as _i489;
import '../../features/transfer/presentation/cubit/transfer_cubit.dart'
    as _i853;
import '../api/api_consumer.dart' as _i207;
import '../api/mock_dio_consumer.dart' as _i672;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i207.ApiConsumer>(() => _i672.MockDioConsumer());
    gh.factory<_i489.TransferRepository>(
        () => _i489.TransferRepository(apiConsumer: gh<_i207.ApiConsumer>()));
    gh.factory<_i853.TransferCubit>(
        () => _i853.TransferCubit(gh<_i489.TransferRepository>()));
    return this;
  }
}
