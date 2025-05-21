import 'package:get/get.dart';
import 'package:news_app/data/api/api_checker.dart';
import 'package:news_app/features/auth/repository/auth_repository.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepository authRepository;
  AuthController({required this.authRepository});


}