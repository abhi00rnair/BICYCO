import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  //sign in
  Future<AuthResponse> signIn(String email, String pass) async {
    return await _supabase.auth.signInWithPassword(
      password: pass,
      email: email,
    );
  }

  //signup
  Future<void> signUp(String email, String pass, String name, String rollno,
      String dept) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: pass,
      );

      if (response.user != null) {
        // Insert user profile data
        await _supabase.from('profiles').insert({
          'uid': response.user!.id,
          'email': email,
          'name': name,
          'rollno': rollno,
          'dpt': dept // Default as regular user
        });
      }
    } catch (e) {
      print('Eryhyhyhyhyhyhyhyhyhyhyhyhror: $e');
    }
  }

  //signout
  Future<void> signOut() async {
    return await _supabase.auth.signOut();
  }
}
