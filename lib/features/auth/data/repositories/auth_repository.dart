import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/data/models/account_response_model.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepository {
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required int accountType,
  });

  Future<AccountResponseModel> signIn({
    required String email,
    required String password,
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
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
    required int accountType,
  }) async {
    await api.post(
      '${EndPoints.baseUrl}${EndPoints.signUp}',
      isFormData: true,
      data: {
        "FirstName": firstName,
        "LastName": lastName,
        "PhoneNumber": phoneNumber,
        "Email": email,
        "Password": password,
        "AccountType": accountType,
      },
    );
  }

  @override
  Future<AccountResponseModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await api.post(
      '${EndPoints.baseUrl}${EndPoints.signIn}',
      isFormData: true,
      data: {
        "Email": email,
        "Password": password,
      },
    );
    return AccountResponseModel.fromJson(response);
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
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  bool isSignedIn() {
    return getIt<CacheHelper>().getData(key: 'token') != null ||
        _firebaseAuth.currentUser != null;
  }
}
