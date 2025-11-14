import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

// ============================================
// CONFIGURE SUAS CREDENCIAIS DO SUPABASE AQUI
// ============================================
// 1. Acesse: https://app.supabase.com/
// 2. Selecione seu projeto
// 3. Vá em Settings > API
// 4. Copie a Project URL e anon/public key
// 5. Cole abaixo:

const String _supabaseUrl = 'https://oxuchfcgporcmyntjnfh.supabase.co';
const String _supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94dWNoZmNncG9yY215bnRqbmZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMwNDI5NDEsImV4cCI6MjA3ODYxODk0MX0.ST1gqAvEJZFzx5miOm7kuU7-EF9SM2aIZj63o5lnu0Y';

// ============================================

Future<void> initializeSupabase() async {
  // Tentar obter de variáveis de ambiente primeiro (para produção)
  const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: _supabaseUrl,
  );
  const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: _supabaseAnonKey,
  );

  // Verificar se as credenciais foram configuradas
  if (supabaseUrl == 'YOUR_SUPABASE_URL' ||
      supabaseAnonKey == 'YOUR_SUPABASE_ANON_KEY') {
    if (kDebugMode) {
      print('');
      print('⚠️  ATENÇÃO: Configure as credenciais do Supabase!');
      print('   Edite o arquivo: lib/config/supabase_config.dart');
      print('   Ou veja o guia em: SETUP_SUPABASE.md');
      print('');
    }
    // Em produção, descomente a linha abaixo para forçar erro
    // throw Exception('Credenciais do Supabase não configuradas');
  }

  try {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      debug: kDebugMode,
    );

    if (kDebugMode) {
      print('✅ Supabase inicializado com sucesso');
      print(
          '   URL: ${supabaseUrl.substring(0, supabaseUrl.length > 30 ? 30 : supabaseUrl.length)}...');
    }
  } catch (e) {
    if (kDebugMode) {
      print('');
      print('❌ Erro ao inicializar Supabase: $e');
      print('   Verifique suas credenciais em lib/config/supabase_config.dart');
      print('   O app continuará funcionando, mas funcionalidades do Supabase podem não estar disponíveis.');
      print('');
    }
    // Não fazer rethrow para evitar crash - o app pode funcionar sem Supabase em alguns casos
    // rethrow;
  }
}

SupabaseClient get supabase {
  if (!Supabase.instance.isInitialized) {
    throw Exception('Supabase não foi inicializado. Verifique a conexão e as credenciais.');
  }
  return Supabase.instance.client;
}
