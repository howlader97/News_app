import 'package:get/get.dart';
import 'package:news_app/features/auth/screens/login_screen.dart';
import 'package:news_app/features/auth/screens/register_screen.dart';
import 'package:news_app/features/home/screens/home_screen.dart';
import 'package:news_app/routes/routes_name.dart';

class AppRoutes {
  static appRoutes() => [


    GetPage(
      name: RoutesName.login,
      page: () => const LoginScreen(),
    ),

    GetPage(
      name: RoutesName.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(name: RoutesName.home,
      page: () => const HomeScreen(),
    )


  ];
}
