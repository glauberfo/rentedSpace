// Script temporário para testar conexão com Supabase
// Execute: dart test_supabase_connection.dart

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  const String supabaseUrl = 'https://oxuchfcgporcmyntjnfh.supabase.co';
  const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94dWNoZmNncG9yY215bnRqbmZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMwNDI5NDEsImV4cCI6MjA3ODYxODk0MX0.ST1gqAvEJZFzx5miOm7kuU7-EF9SM2aIZj63o5lnu0Y';

  try {
    print('🔄 Inicializando Supabase...');
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    
    final client = Supabase.instance.client;
    
    print('✅ Supabase conectado com sucesso!');
    print('   URL: $supabaseUrl');
    
    // Testar se a tabela profiles existe
    print('\n🔄 Verificando tabela "profiles"...');
    try {
      final response = await client.from('profiles').select('count').limit(1);
      print('✅ Tabela "profiles" existe e está acessível!');
    } catch (e) {
      if (e.toString().contains('relation') || e.toString().contains('does not exist')) {
        print('❌ Tabela "profiles" não encontrada!');
        print('\n📋 Execute o SQL abaixo no Supabase SQL Editor:');
        print('   (Veja o arquivo SETUP_SUPABASE.md para o SQL completo)');
      } else {
        print('⚠️  Erro ao acessar tabela: $e');
      }
    }
    
    // Testar autenticação
    print('\n🔄 Testando autenticação...');
    try {
      final authState = client.auth.currentSession;
      if (authState != null) {
        print('✅ Sessão ativa encontrada');
      } else {
        print('ℹ️  Nenhuma sessão ativa (normal se não estiver logado)');
      }
    } catch (e) {
      print('⚠️  Erro ao verificar autenticação: $e');
    }
    
    print('\n✅ Teste de conexão concluído!');
    
  } catch (e) {
    print('❌ Erro ao conectar com Supabase: $e');
    print('\nVerifique:');
    print('  1. Suas credenciais estão corretas?');
    print('  2. O projeto Supabase está ativo?');
    print('  3. Sua conexão com a internet está funcionando?');
  }
}

