import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../models/user_model.dart';

class AuthService {
  final _supabase = supabase;

  // Login
  Future<AuthResponse> signIn(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Cadastro
  Future<AuthResponse> signUp(String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Salvar dados do usuário no perfil
  Future<void> saveUserProfile(UserModel user) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('Usuário não autenticado. Faça login primeiro.');
    }

    try {
      await _supabase.from('profiles').upsert({
        'id': userId,
        ...user.toJson(),
      });
    } catch (e) {
      // Se a tabela não existir, fornecer mensagem mais clara
      if (e.toString().contains('relation') || e.toString().contains('does not exist')) {
        throw Exception(
          'Tabela "profiles" não encontrada. '
          'Execute o SQL em SETUP_SUPABASE.md para criar a tabela.',
        );
      }
      rethrow;
    }
  }

  // Recuperação de senha
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  // Logout
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Verificar se usuário está autenticado
  bool get isAuthenticated => _supabase.auth.currentUser != null;

  // Obter usuário atual
  User? get currentUser => _supabase.auth.currentUser;
}

