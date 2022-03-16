import 'package:get_it/get_it.dart';
import 'package:instadl/model/Request.dart';
import 'package:instadl/model/mixed.dart';

GetIt sl = GetIt.instance;

void serviceLocator() async {
  sl.registerLazySingleton(() => MixedClass());
  sl.registerLazySingleton(() => RequestDio());
}
