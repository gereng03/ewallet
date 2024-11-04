import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Kiểm tra email hợp lệ
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Đăng nhập với email và password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (!isValidEmail(email)) {
      throw FirebaseAuthException(
        code: 'invalid-email',
        message: 'The email address is badly formatted.',
      );
    }

    if (password.isEmpty || password.length < 6) {
      throw FirebaseAuthException(
        code: 'weak-password',
        message: 'The password must be at least 6 characters long.',
      );
    }

    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Đăng nhập với Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google sign in aborted');

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  // Lưu thông tin đăng nhập
  Future<void> saveUserCredentials({
    required bool rememberMe,
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', rememberMe);
    if (rememberMe) {
      await prefs.setString('email', email);
      await prefs.setString('password', password);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  // Lấy thông tin đăng nhập đã lưu
  Future<Map<String, dynamic>> loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;
    String email = '';
    String password = '';

    if (rememberMe) {
      email = prefs.getString('email') ?? '';
      password = prefs.getString('password') ?? '';
    }

    return {
      'rememberMe': rememberMe,
      'email': email,
      'password': password,
    };
  }


  // Đăng xuất
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}