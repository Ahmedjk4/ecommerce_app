import 'package:electronics_shop/core/utils/app_router.dart';
import 'package:electronics_shop/features/home/presentation/view_models/cart_list_cubit/cart_list_cubit.dart';
import 'package:electronics_shop/firebase_options.dart';
import 'package:electronics_shop/core/observers/simple_bloc_observer.dart';
import 'package:electronics_shop/features/auth/presentation/views/widgets/custom_error_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    runApp(CustomErrorWidget(errorMessage: details.exception.toString()));
  };
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const CStoreApp());
}

class CStoreApp extends StatelessWidget {
  const CStoreApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartListCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'CStore',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
