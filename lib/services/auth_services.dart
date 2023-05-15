import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // google sign in
  signInWithGoogle() async {
    //Auth flow (search for email in user device)
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: [
      "email",
    ]).signIn();

    //Obtain the auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //Return user credentials

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
