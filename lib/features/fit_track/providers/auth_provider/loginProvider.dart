import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

final passwordhideProvider = StateProvider<bool>((ref) => true);
final isFormValidProvider = StateProvider<bool>((ref) => false);
final LoginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue>((ref) {
      return LoginController();
    });

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController() : super(AsyncValue.data(null));
  //firebase signup
  Future Login(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final firebaseAuth = FirebaseAuth.instance;

      // ignore: unused_local_variable
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      state = const AsyncValue.data(null);
      return true;
    } on FirebaseAuthException catch (error, stack) {
      state = AsyncValue.error(error.message.toString(), stack);
      return false;
    } catch (e, stack) {
      state = AsyncValue.error('unable to sign up', stack);
      return false;
    }
  }
}
