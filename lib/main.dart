import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'utils/app_provider.dart';
import 'utils/routes.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
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
