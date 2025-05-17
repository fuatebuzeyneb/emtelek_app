import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/auth/data/models/login_request_model.dart';
import 'package:emtelek/features/auth/data/models/login_response_model.dart';
import 'package:emtelek/features/auth/data/models/sign_up_request_model.dart';
import 'package:emtelek/features/profile/data/models/account_response_model.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:emtelek/shared/models/base_response_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepository {
  Future<BaseResponseModel> signUp({
    required SignUpRequestModel signUpRequestModel,
  });

  Future<LoginResponseModel> signIn({
    required LoginRequestModel loginRequestModel,
  });

  Future<UserCredential> signInWithGoogle();

  //Future<UserCredential> signInWithFacebook();

  Future<void> signOut();
  bool isSignedIn();
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer api;
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl({
    required this.api,
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<BaseResponseModel> signUp({
    required SignUpRequestModel signUpRequestModel,
  }) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.signUp}',
      isFormData: true,
      data: signUpRequestModel.toJson(),
    );

    return BaseResponseModel.fromJson(response);
  }

  @override
  Future<LoginResponseModel> signIn({
    required LoginRequestModel loginRequestModel,
  }) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.signIn}',
      isFormData: true,
      data: loginRequestModel.toJson(),
    );
    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      print("🔵 بدء تسجيل الدخول باستخدام Google...");

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("🛑 تم إلغاء تسجيل الدخول من قبل المستخدم!");
        throw Exception("Google Sign-In was cancelled");
      }
      print("✅ تم اختيار الحساب: ${googleUser.email}");

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print("🔵 تم استرداد بيانات المصادقة من Google...");

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      print("✅ تسجيل الدخول ناجح!");

      final User? user = userCredential.user;
      if (user != null) {
        print("👤 الاسم: ${user.displayName}");
        print("📧 الإيميل: ${user.email}");
        print("🆔 معرف المستخدم (UID): ${user.uid}");
        print("📸 رابط الصورة الشخصية: ${user.photoURL}");
      }

      return userCredential;
    } catch (e) {
      print("❌ خطأ أثناء تسجيل الدخول: $e");
      throw Exception("Google Sign-In failed: $e");
    }
  }

  // @override
  // Future<UserCredential> signInWithFacebook() async {
  //   // try {
  //   //   print("🔵 بدء تسجيل الدخول باستخدام Facebook...");

  //   //   final LoginResult result = await FacebookAuth.instance.login();
  //   //   if (result.status != LoginStatus.success) {
  //   //     print("🛑 تم إلغاء تسجيل الدخول من قبل المستخدم!");
  //   //     throw Exception("Facebook Sign-In was cancelled");
  //   //   }
  //   //   print("✅ تم اختيار الحساب: ${result.accessToken!.tokenString}");

  //   //   final OAuthCredential facebookAuthCredential =
  //   //       FacebookAuthProvider.credential(result.accessToken!.tokenString);

  //   //   final UserCredential userCredential =
  //   //       await _firebaseAuth.signInWithCredential(facebookAuthCredential);
  //   //   print("✅ تسجيل الدخول ناجح!");

  //   //   final User? user = userCredential.user;
  //   //   if (user != null) {
  //   //     print("👤 الاسم: ${user.displayName}");
  //   //     print("📧 الإيميل: ${user.email}");
  //   //     print("🆔 معرف المستخدم (UID): ${user.uid}");
  //   //     print("📸 رابط الصورة الشخصية: ${user.photoURL}");
  //   //   }

  //   //   return userCredential;
  //   // } catch (e) {
  //   //   print("❌ خطأ أثناء تسجيل الدخول: $e");
  //   //   throw Exception("Facebook Sign-In failed: $e");
  //   // }
  // }

  @override
  Future<void> signOut() async {
    await getIt<CacheHelper>().removeData(key: 'token');
    await getIt<CacheHelper>().removeData(key: 'password');
    await getIt<CacheHelper>().removeData(key: 'email');
    await getIt<CacheHelper>().removeData(key: 'joinDate');
    await getIt<CacheHelper>().removeData(key: 'firstName');
    await getIt<CacheHelper>().removeData(key: 'lastName');
    await getIt<CacheHelper>().removeData(key: 'clientId');
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  bool isSignedIn() {
    return getIt<CacheHelper>().getData(key: 'token') != null ||
        _firebaseAuth.currentUser != null;
  }
}
