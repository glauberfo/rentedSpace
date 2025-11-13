# 🔧 Solução para Problemas de Commit

## Possíveis Causas

### 1. Repositório Git não inicializado

**Solução:**
```bash
cd /Users/glauberfo/projetos/SpaceRented
git init
```

### 2. Configuração de usuário Git não feita

**Solução:**
```bash
git config user.name "Seu Nome"
git config user.email "seu.email@exemplo.com"
```

Ou globalmente:
```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu.email@exemplo.com"
```

### 3. Nenhum arquivo para commitar

**Solução:**
```bash
# Verificar status
git status

# Adicionar arquivos
git add .

# Fazer commit
git commit -m "Initial commit: Login e Cadastro implementados"
```

### 4. ⚠️ Credenciais do Supabase no código

**IMPORTANTE:** O arquivo `lib/config/supabase_config.dart` contém suas credenciais do Supabase. 

**Opções:**

#### Opção A: Commitar mesmo assim (não recomendado para produção)
Se for um projeto privado ou de desenvolvimento, você pode commitar:
```bash
git add .
git commit -m "Initial commit"
```

#### Opção B: Usar variáveis de ambiente (recomendado)
1. Remover as credenciais do código
2. Usar variáveis de ambiente ao executar:
```bash
flutter run --dart-define=SUPABASE_URL=sua_url --dart-define=SUPABASE_ANON_KEY=sua_chave
```

#### Opção C: Arquivo separado (recomendado)
Criar `lib/config/supabase_config_local.dart` (já está no .gitignore):
```dart
const String supabaseUrl = 'sua_url';
const String supabaseAnonKey = 'sua_chave';
```

E importar no `supabase_config.dart`:
```dart
import 'supabase_config_local.dart' if (dart.library.io) '';
```

## Passos Recomendados

### 1. Verificar se Git está inicializado
```bash
ls -la | grep .git
```

Se não existir, inicialize:
```bash
git init
```

### 2. Configurar usuário (se necessário)
```bash
git config user.name "Seu Nome"
git config user.email "seu.email@exemplo.com"
```

### 3. Adicionar arquivos
```bash
git add .
```

### 4. Verificar o que será commitado
```bash
git status
```

### 5. Fazer commit
```bash
git commit -m "feat: Implementação de Login e Cadastro com Supabase"
```

## Se ainda não funcionar

### Verificar mensagem de erro específica
Qual é a mensagem de erro exata que aparece quando você tenta fazer commit?

Possíveis mensagens:
- "fatal: not a git repository" → Precisa fazer `git init`
- "Please tell me who you are" → Precisa configurar user.name e user.email
- "nothing to commit" → Não há mudanças para commitar
- "Your branch is up to date" → Já está tudo commitado

### Comandos úteis para diagnóstico
```bash
# Ver status
git status

# Ver configuração
git config --list

# Ver histórico
git log

# Ver diferenças
git diff
```

## ⚠️ Segurança: Credenciais no Git

**ATENÇÃO:** Se você commitar as credenciais do Supabase:

1. **Projeto privado:** OK (mas ainda não é ideal)
2. **Projeto público:** ❌ NUNCA faça isso!
3. **Melhor prática:** Use variáveis de ambiente ou arquivo local ignorado

O arquivo `.gitignore` já está configurado para ignorar:
- `lib/config/supabase_config_local.dart`
- Arquivos `.env`

## Próximos Passos

1. Execute os comandos acima na ordem
2. Se ainda tiver problemas, me diga qual é a mensagem de erro exata
3. Posso ajudar a configurar variáveis de ambiente se preferir

