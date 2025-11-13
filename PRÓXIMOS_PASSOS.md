# ✅ Credenciais do Supabase Configuradas!

## Status Atual
- ✅ Credenciais configuradas em `lib/config/supabase_config.dart`
- ✅ Projeto Supabase: `oxuchfcgporcmyntjnfh.supabase.co`

## Próximo Passo: Criar Tabela no Supabase

### 1. Acesse o Supabase Dashboard
- Vá para: https://app.supabase.com/
- Selecione seu projeto

### 2. Execute o SQL
- Vá em **SQL Editor** (menu lateral)
- Clique em **New Query**
- Cole o SQL abaixo e execute:

```sql
-- Criar tabela de perfis
CREATE TABLE IF NOT EXISTS profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email TEXT,
  first_name TEXT,
  last_name TEXT,
  cpf TEXT,
  phone TEXT,
  gender TEXT,
  birth_date TEXT,
  country TEXT DEFAULT 'Brasil',
  zip_code TEXT,
  street TEXT,
  street_number TEXT,
  complement TEXT,
  neighborhood TEXT,
  city TEXT,
  state TEXT,
  is_brazilian BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Habilitar RLS (Row Level Security)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Política: Usuários podem ler apenas seu próprio perfil
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT
  USING (auth.uid() = id);

-- Política: Usuários podem inserir seu próprio perfil
CREATE POLICY "Users can insert own profile"
  ON profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

-- Política: Usuários podem atualizar seu próprio perfil
CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);

-- Função para atualizar updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para atualizar updated_at
CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
```

### 3. Verificar se foi criada
- Vá em **Table Editor** (menu lateral)
- Você deve ver a tabela `profiles` na lista

## Testar a Aplicação

### 1. Instalar dependências
```bash
flutter pub get
```

### 2. Executar o app
```bash
flutter run
```

### 3. Verificar no console
Você deve ver:
```
✅ Supabase inicializado com sucesso
   URL: https://oxuchfcgporcmyntjnfh.supabase...
```

## Testar Login e Cadastro

1. **Teste de Cadastro:**
   - Abra o app
   - Clique em "Cadastre-se"
   - Preencha os dados nas 3 etapas
   - Ao finalizar, o usuário será criado no Supabase

2. **Teste de Login:**
   - Use o email e senha cadastrados
   - Deve fazer login com sucesso

## Verificar no Supabase

### Ver usuários criados:
- Vá em **Authentication** > **Users**
- Você verá os usuários cadastrados

### Ver perfis criados:
- Vá em **Table Editor** > **profiles**
- Você verá os dados completos dos usuários

## Próximas Funcionalidades

Após confirmar que login e cadastro estão funcionando, podemos implementar:

1. ✅ **Tela Principal/Home** após login
2. ✅ **Onboarding pós-cadastro** (tutoriais)
3. ✅ **Funcionalidades principais** (ver espaços, reservar, etc.)
4. ✅ **Gerenciamento de perfil**

## Troubleshooting

### Erro: "Tabela profiles não encontrada"
- Execute o SQL acima no Supabase SQL Editor

### Erro: "Usuário não autenticado"
- Verifique se fez login antes de acessar áreas protegidas

### Erro ao salvar perfil
- Verifique se as políticas RLS estão configuradas corretamente
- Verifique se o usuário está autenticado

---

**Status:** ✅ Pronto para testar!

