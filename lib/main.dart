import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_db/bussiness_logic/fetch_data_bloc/fetch_data_bloc.dart';
import 'package:firebase_db/bussiness_logic/inser_db_bloc/insert_db_bloc.dart';
import 'package:firebase_db/data/fetch_data_api/fetch_data_api.dart';
import 'package:firebase_db/data/insert_db_api/insert_db_api.dart';
import 'package:firebase_db/presentation_screen/splash_screen.dart';
import 'package:firebase_db/utils/data_sync_service.dart';
import 'package:firebase_db/utils/fetch_db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';

const myTask = "syncWith";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    "1",
    myTask,
    frequency: const Duration(minutes: 15),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<InsertDbBloc>(
          create: (_) => InsertDbBloc(repo: InsertDbApi())),
      BlocProvider<FetchDataBloc>(
          create: (_) => FetchDataBloc(repo: FetchDataApi()))
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((
    taskName, inputData,) async {
    switch (taskName) {
      case myTask:
        await syncDbData();
        break;
      case Workmanager.iOSBackgroundTask:
        await syncDbData();
        break;
    }
    return Future.value(true);
  });
}
