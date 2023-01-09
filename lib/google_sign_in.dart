import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Google_Sign_In {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential =
            await GoogleAuthProvider.credential(
                accessToken: googleSignInAuthentication.accessToken,
                idToken: googleSignInAuthentication.idToken);

        return await _auth.signInWithCredential(authCredential);
      } else
        return null;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      //throw e;
    }
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
