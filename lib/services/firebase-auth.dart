import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService{

  static FirebaseAuth auth = FirebaseAuth.instance;

  static void verifyPhoneNumber(String phoneNumber, Function onCodeSend, Function onVerificationCompleted, Function onVerificationFailed) async {

    final PhoneVerificationCompleted verificationCompleted = (AuthCredential phoneAuthCredential) async {
      signInWIthPhoneNumber(phoneAuthCredential, onVerificationFailed, onVerificationCompleted);
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      onVerificationFailed("Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}");
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      onCodeSend(verificationId);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
    };

    await auth.verifyPhoneNumber(
      phoneNumber: "+$phoneNumber",
      timeout: const Duration(seconds: 10),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  static signInWIthPhoneNumber(AuthCredential credential, Function onSignInSuccess, Function onSignInError, ) async {
    try {
      AuthResult authResult = await auth.signInWithCredential(credential);

      if (authResult.additionalUserInfo.isNewUser) {
        print(">>>>>>>new user");
        onSignInSuccess(true, authResult);
        //User logging in for the first time
        // Redirect user to tutorial
      }
      else {
        onSignInSuccess(false, authResult);

        print(">>>>>>>old user");

        //User has already logged in before.
        //Show user profile
      }

      final FirebaseUser currentUser = await auth.currentUser();




    } on PlatformException catch (e) {
      if (e.code == "ERROR_INVALID_VERIFICATION_CODE") {
        onSignInError("Verification code is incorrect");
      }
      if (e.code == "ERROR_SESSION_EXPIRED") {
        onSignInError("Verification code expired");
      }
      print(e.code);
    }
  }

  static signInWithGoogle(Function onSuccess) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    AuthResult authResult = await auth.signInWithCredential(credential);
//    authResult.user.email;

//    authResult.user.uid;
    if (authResult.additionalUserInfo.isNewUser) {
      print(">>>>>>>new user");
      //User logging in for the first time
      // Redirect user to tutorial
    }
    else {
      print(">>>>>>>old user");

      //User has already logged in before.
      //Show user profile
    }
    final FirebaseUser user = authResult.user;

    if (user != null) {
      onSuccess(authResult);
    }
  }

  Future<bool> isLoggedIn() async {
    FirebaseUser currentUser = await auth.currentUser();
    if (currentUser == null) {
      return false;
    }
    return true;
  }
}