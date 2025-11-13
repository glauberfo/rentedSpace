# Configuração do Supabase

## Passo 1: Obter Credenciais do Supabase

1. Acesse o [Supabase Dashboard](https://app.supabase.com/)
2. Selecione seu projeto (ou crie um novo)
3. Vá em **Settings** > **API**
4. Copie:
   - **Project URL** (ex: `https://xxxxx.supabase.co`)
   - **anon/public key** (chave pública)

## Passo 2: Configurar no Projeto

### Opção A: Configuração Direta (Recomendado para desenvolvimento)

Edite o arquivo `lib/config/supabase_config.dart` e substitua:

```dart
const String supabaseUrl = 'SUA_URL_AQUI';
const String supabaseAnonKey = 'SUA_CHAVE_AQUI';
```

### Opção B: Variáveis de Ambiente (Recomendado para produção)

Execute o Flutter com variáveis de ambiente:

```bash
flutter run --dart-define=SUPABASE_URL=sua_url --dart-define=SUPABASE_ANON_KEY=sua_chave
```

## Passo 3: Criar Tabela de Perfis

No Supabase Dashboard, vá em **SQL Editor** e execute:

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

## Passo 4: Configurar Autenticação

No Supabase Dashboard:

1. Vá em **Authentication** > **Settings**
2. Configure:
   - **Site URL**: `http://localhost` (desenvolvimento) ou sua URL de produção
   - **Redirect URLs**: Adicione as URLs permitidas

## Passo 5: Testar Conexão

Execute o aplicativo:

```bash
flutter pub get
flutter run
```

Se tudo estiver configurado corretamente, você verá no console:
```
✅ Supabase inicializado com sucesso
```

## Troubleshooting

### Erro: "Invalid API key"
- Verifique se copiou a chave correta (anon/public key, não service_role)
- Verifique se não há espaços extras nas credenciais

### Erro: "Failed to connect"
- Verifique sua conexão com a internet
- Verifique se a URL do Supabase está correta
- Verifique se o projeto Supabase está ativo

### Erro ao criar perfil
- Verifique se a tabela `profiles` foi criada
- Verifique as políticas RLS
- Verifique se o usuário está autenticado

## Segurança

⚠️ **IMPORTANTE**: 
- Nunca commite as credenciais do Supabase no Git
- Use variáveis de ambiente em produção
- A chave `anon` é pública, mas ainda assim não deve ser exposta desnecessariamente
- Nunca use a chave `service_role` no cliente (mobile/app)

