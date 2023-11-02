import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'utils/app_provider.dart';
import 'utils/functions.dart';
import 'utils/routes.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(messageLoadsDispatcher);
  Workmanager().registerPeriodicTask(
    "periodic-task-identifier",
    "simplePeriodicTask",
    inputData: null,
    constraints: Constraints(
      requiresCharging: false,
      networkType: NetworkType.connected,
    ),
  );

  runApp(const MyApp());
}

@pragma('vm:entry-point')
void messageLoadsDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final accessToken = await secureStorage.read(key: "accessToken");
    try {
      Response response = await dio.get(
        'api/broadcastmessages/',
        // options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200) {
        print(response.data);
      } else {
        if (kDebugMode) {
          print(response);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 809),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
            providers: [
              Provider<AppProvider>(create: (context) => AppProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'NEAR MOBILE',
              initialRoute: "/",
              onGenerateRoute: GenerateRoute.onGenerateRoute,
              theme: ThemeData(
                primarySwatch: Colors
                    .green, // Change this color to your desired primary color
              ),
            ));
      },
    );
  }
}
