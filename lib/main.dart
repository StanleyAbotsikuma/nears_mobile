import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
import 'utils/app_provider.dart';
import 'utils/functions.dart';
import 'utils/notifications.dart';
import 'utils/routes.dart';

@pragma('vm:entry-point')
void callbackDispatch() {
  Workmanager().executeTask((taskName, inputData) {
    loadMessages().then((value) => Null);
    return Future.value(true);
  });
}

const FlutterSecureStorage secureStorage = FlutterSecureStorage();
void doesValueExist() async {
  final value = await secureStorage.read(key: "endpoint");

  if (value == null) {
    Dio dio = Dio();
    try {
      final response = await dio.get(
          'https://raw.githubusercontent.com/StanleyAbotsikuma/raw_files/main/endpoints.json');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        print(data["protocolType"]);
        print(data["host"]);
        print(data["wsType"]);
        await secureStorage.write(
            key: "protocolType", value: data["protocolType"]);
        await secureStorage.write(key: "host", value: data["host"]);
        await secureStorage.write(key: "wsType", value: data["wsType"]);

        await secureStorage.write(key: "endpoint", value: "true");
      }
    } catch (error) {
      print(error);
    }
  }
}

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  doesValueExist();
  await NotificationAPI.ini();
  Workmanager().initialize(callbackDispatch);
  Workmanager().registerPeriodicTask("taskOne", "Message",
      frequency: const Duration(minutes: 15),
      constraints: Constraints(networkType: NetworkType.connected));

  runApp(const MyApp());
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
