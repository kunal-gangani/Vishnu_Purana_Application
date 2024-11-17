import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vishnu_purana_application/Controllers/purana_controllers.dart';
import 'package:vishnu_purana_application/Controllers/theme_controller.dart';
import 'package:vishnu_purana_application/Views/SplashScreen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PuranaControllers(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeController(
            isDarkMode: true,
          ),
        )
      ],
      child: Consumer<ThemeController>(builder: (context, value, _) {
        return ScreenUtilInit(
          minTextAdapt: true,
          designSize: Size(size.width, size.height),
          builder: (context, _) {
            return Flexify(
              designWidth: size.width,
              designHeight: size.height,
              app: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: const SplashScreen(),
                theme: value.theme,
              ),
            );
          },
        );
      }),
    );
  }
}
