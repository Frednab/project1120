import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _supabase = Supabase.instance.client;

class AuthService {
  static User? get currentUser => _supabase.auth.currentUser;

  static Future<AuthResponse> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    if (res.user != null) {
      await _supabase.from('profiles').upsert({
        'id': res.user!.id,
        'name': name,
        'email': email,
        'checks_used': 0,
        'is_pro': false,
      });
    }
    return res;
  }

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
        email: email, password: password);
  }

  static Future<bool> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return false;
    final googleAuth = await googleUser.authentication;
    if (googleAuth.idToken == null) return false;
    await _supabase.auth.signInWithIdToken(
      provider: Provider.google,
      idToken: googleAuth.idToken!,
      accessToken: googleAuth.accessToken,
    );
    final user = _supabase.auth.currentUser;
    if (user != null) {
      await _supabase.from('profiles').upsert({
        'id': user.id,
        'name': user.userMetadata?['name'] ?? googleUser.displayName ?? 'User',
        'email': user.email ?? '',
        'checks_used': 0,
        'is_pro': false,
      }, onConflict: 'id');
    }
    return true;
  }

  static Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _supabase.auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  static Future<void> changePassword(String newPassword) async {
    await _supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  static Future<void> updateProfile({String? name}) async {
    final user = currentUser;
    if (user == null || name == null) return;
    await _supabase.auth.updateUser(UserAttributes(data: {'name': name}));
    await _supabase.from('profiles').update({'name': name}).eq('id', user.id);
  }

  static Future<Map<String, dynamic>?> getProfile() async {
    final user = currentUser;
    if (user == null) return null;
    final data = await _supabase
        .from('profiles').select().eq('id', user.id).single();
    return data;
  }

  // Helper to get display name
  static String get displayName {
    final user = currentUser;
    if (user == null) return 'User';
    return user.userMetadata?['name'] as String? ??
        user.email?.split('@')[0] ?? 'User';
  }
}
