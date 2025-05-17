import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/core/errors/exceptions.dart';
import 'package:emtelek/features/auth/data/models/login_request_model.dart';
import 'package:emtelek/features/auth/data/models/sign_up_request_model.dart';
import 'package:emtelek/features/auth/data/repositories/auth_repository.dart';
import 'package:emtelek/generated/l10n.dart';
import 'package:emtelek/shared/models/base_response_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/services/shared_preferences_funs.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import 'package:google_sign_in/google_sign_in.dart';
part 'auth_state.dart';

//mohamadcolak@gmail.com
//123456
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String phoneNumber = '';

  Future<void> signUp({required SignUpRequestModel signUpRequestModel}) async {
    emit(SignUpLoading());

    try {
      final response = await authRepository.signUp(
        signUpRequestModel: signUpRequestModel,
      );

      if (response.isSuccess) {
        emit(SignUpSuccuss());
      } else {
        emit(SignUpFailure(errorMassage: response.msg ?? "Unknown Error"));
      }
    } on ServerException catch (e) {
      emit(SignUpFailure(errorMassage: e.errorModel.errorMessage));
    }
  }

  Future<void> signIn({required LoginRequestModel loginRequestModel}) async {
    try {
      emit(SignInLoading());
      print('loginRequestModel: $loginRequestModel');
      final data = await authRepository.signIn(
        loginRequestModel: loginRequestModel,
      );

      if (data.token != null && data.data != null) {
        saveToken(data.token!);
        saveEmail(data.data!.email!);
        saveFirstName(data.data!.firstName!);
        saveLastName(data.data!.lastName!);
        saveClientId(data.data!.clientId!);
        saveJoinDate(data.data!.subscriptionDate!);
        emit(SignInSuccuss());
      } else {
        emit(SignInFailure(errorMassage: "Invalid login response"));
      }
    } on ServerException catch (e) {
      emit(SignInFailure(errorMassage: e.errorModel.errorMessage));
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    emit(SignOutSuccuss());
  }

  bool isSignedIn() {
    return authRepository.isSignedIn();
  }

  Future<void> signInWithGoogle() async {
    emit(SignInLoading());
    try {
      final userCredential = await authRepository.signInWithGoogle();
      final user = userCredential.user;

      if (user != null) {
        saveToken(await user.getIdToken() ?? '');
        saveEmail(user.email ?? '');
        saveFirstName(user.displayName?.split(' ').first ?? '');
        saveLastName(user.displayName?.split(' ').last ?? '');
        // savePhoneNumber(user.phoneNumber ?? '');

        //final isUserExists = await authRepository.checkIfUserExists(user.email ?? '');

        // if (!isUserExists) {
        print('---------------------------------');
        print('User Data: ${user.uid}');
        print('---------------------------------');
        // await authRepository.signUp(
        //   firstName: user.displayName?.split(' ').first ?? '',
        //   lastName: user.displayName?.split(' ').last ?? '',
        //   phoneNumber: user.phoneNumber ?? '',
        //   email: user.email ?? '',
        //   password: '123456',
        //   accountType: 2,
        // );
        //  }

        emit(SignInSuccuss());
      } else {
        emit(SignInFailure(errorMassage: "Google Sign-In failed"));
      }
    } catch (e) {
      emit(SignInFailure(errorMassage: e.toString()));
    }
  }

  // Future<void> signInWithFacebook() async {
  //   emit(SignInLoading());
  //   try {
  //     final userCredential = await authRepository.signInWithFacebook();
  //     final user = userCredential.user;

  //     if (user != null) {
  //       saveToken(await user.getIdToken() ?? '');
  //       saveEmail(user.email ?? '');
  //       saveFirstName(user.displayName?.split(' ').first ?? '');
  //       saveLastName(user.displayName?.split(' ').last ?? '');
  //       savePhoneNumber(user.phoneNumber ?? '');

  //       //final isUserExists = await authRepository.checkIfUserExists(user.email ?? '');

  //       // if (!isUserExists) {
  //       await authRepository.signUp(
  //         firstName: user.displayName?.split(' ').first ?? '',
  //         lastName: user.displayName?.split(' ').last ?? '',
  //         phoneNumber: user.phoneNumber ?? '',
  //         email: user.email ?? '',
  //         password: '123456', // Not recommended to set a static password
  //         accountType: 2,
  //       );
  //       //  }

  //       emit(SignInSuccuss());
  //     } else {
  //       emit(SignInFailure(errorMassage: "Facebook Sign-In failed"));
  //     }
  //   } catch (e) {
  //     emit(SignInFailure(errorMassage: e.toString()));
  //   }
  // }
}



/*


    print('Raw Response Data: ${response.data}'); // طباعة البيانات الخام

      if (response.statusCode == 200) {
        try {
          final jsonResponse = response.data;
          ClientsResponseModel data =
              ClientsResponseModel.fromJson(jsonResponse);

          print('Parsed Client Data: ${data.data}'); // طباعة بيانات العميل
          data.data?.printClientDetails(data);

          if (data.status == 'failed') {
            print('Login failed: ${data.failed}');
            emit(SignInFailure(
                errorMassage: data.failed ?? 'Unknown error occurred'));
          } else {
            // حفظ البيانات في التخزين المحلي
            // saveEmail(email);
            // savePassword(password);
            // saveToken(data.token!);
            // saveFirstName(data.data?.firstName ?? 'Unknown');
            // saveLastName(data.data?.lastName ?? 'Unknown');
            // saveClientId(data.data?.clientId ?? 0);
            // print('++++++++++++++++++++++++++++++++');
            emit(SignInSuccuss());
          }
        } catch (jsonError) {
          print('Error parsing JSON: $jsonError');
          emit(SignInFailure(errorMassage: 'Error parsing server response.'));
        }
      } else {
        print('Server returned status code: ${response.statusCode}');
        emit(SignInFailure(errorMassage: "Unexpected server response."));
      }




*/