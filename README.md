# SpaceRented - Aplicativo Flutter

Aplicativo de aluguel de espaços com autenticação e cadastro em 3 etapas.

## Configuração Inicial

### 1. Instalar dependências

```bash
flutter pub get
```

### 2. Configurar Supabase

Edite o arquivo `lib/config/supabase_config.dart` e adicione suas credenciais:

```dart
const String supabaseUrl = 'SUA_URL_DO_SUPABASE';
const String supabaseAnonKey = 'SUA_CHAVE_ANON_KEY';
```

### 3. Criar tabela no Supabase

Crie uma tabela `profiles` no Supabase com os seguintes campos:

```sql
CREATE TABLE profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT,
  first_name TEXT,
  last_name TEXT,
  cpf TEXT,
  phone TEXT,
  gender TEXT,
  birth_date TEXT,
  country TEXT,
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
```

### 4. Executar o aplicativo

```bash
flutter run
```

## Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada
├── config/
│   └── supabase_config.dart  # Configuração do Supabase
├── models/
│   └── user_model.dart       # Modelo de dados do usuário
├── screens/
│   ├── login_screen.dart     # Tela de login
│   ├── signup_step1_screen.dart  # Cadastro - Etapa 1
│   ├── signup_step2_screen.dart  # Cadastro - Etapa 2
│   └── signup_step3_screen.dart  # Cadastro - Etapa 3
├── services/
│   └── auth_service.dart     # Serviço de autenticação
├── theme/
│   └── app_theme.dart        # Tema e estilos
├── utils/
│   └── validators.dart       # Validações de formulário
└── widgets/
    ├── custom_button.dart    # Botão customizado
    ├── custom_text_field.dart  # Campo de texto customizado
    ├── logo_widget.dart      # Widget da logo
    └── progress_indicator.dart  # Indicador de progresso
```

## Funcionalidades

- ✅ Login com email e senha
- ✅ Cadastro em 3 etapas:
  - Etapa 1: Dados básicos (nome, sobrenome, CPF, senha)
  - Etapa 2: Dados adicionais (email, telefone, sexo, data de nascimento)
  - Etapa 3: Endereço completo
- ✅ Validação de formulários
- ✅ Máscaras de entrada (CPF, telefone, CEP, data)
- ✅ Integração com Supabase
- ✅ Design responsivo baseado nas imagens de referência

## Notas

- O aplicativo está configurado para funcionar com FlutterFlow
- As credenciais do Supabase devem ser configuradas antes de executar
- A tabela `profiles` deve ser criada no Supabase antes de usar o cadastro
