// // lib/services/auth_service.dart
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:spsole/config/route_name.dart';
// import 'package:spsole/widgets/mycolors.dart';

// class AuthService {
//   // Singleton
//   AuthService._privateConstructor();
//   static final AuthService instance = AuthService._privateConstructor();

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   /// Login with Email + 4-digit PIN (PIN = password)
//   Future<void> loginWithEmailAndPin({
//     required String email,
//     required String pin,
//   }) async {
//     if (email.isEmpty || pin.isEmpty || pin.length != 4) {
//       Get.snackbar('Invalid Input', 'Enter valid email and 4-digit PIN');
//       return;
//     }

//     try {
//       Get.snackbar(
//         'Signing in...',
//         'Please wait',
//         duration: const Duration(seconds: 2),
//       );

//       await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: pin, // 4-digit PIN is the password
//       );

//       // Success
//       Get.offAllNamed(MyPagesName.dashboard);
//       Get.snackbar(
//         'Success',
//         'Logged in successfully!',
//         backgroundColor: Get.theme.primaryColor,
//       );
//     } on FirebaseAuthException catch (e) {
//       String message;
//       switch (e.code) {
//         case 'user-not-found':
//           message = 'No account found with this email.';
//           break;
//         case 'wrong-password':
//           message = 'Incorrect PIN.';
//           break;
//         case 'invalid-email':
//           message = 'Invalid email address.';
//           break;
//         case 'too-many-requests':
//           message = 'Too many attempts. Try again later.';
//           break;
//         default:
//           message = 'Login failed. Please try again.';
//       }
//       Get.snackbar('Login Failed', message, backgroundColor: AppColors.primary);
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Something went wrong.',
//         backgroundColor: AppColors.primary,
//       );
//     }
//   }

//   // Optional: Get current user
//   User? get currentUser => _auth.currentUser;

//   // Optional: Sign out
//   Future<void> signOut() async {
//     await _auth.signOut();
//     Get.offAllNamed('/login'); // Update with your login route
//   }
// }
