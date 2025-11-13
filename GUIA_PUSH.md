# 🚀 Guia para Fazer Push

## Passos para Fazer Push

### 1. Verificar se há repositório remoto configurado

```bash
git remote -v
```

Se não aparecer nada, você precisa adicionar um repositório remoto.

### 2. Adicionar Repositório Remoto

#### Opção A: GitHub
```bash
git remote add origin https://github.com/seu-usuario/seu-repositorio.git
```

#### Opção B: GitLab
```bash
git remote add origin https://gitlab.com/seu-usuario/seu-repositorio.git
```

#### Opção C: Bitbucket
```bash
git remote add origin https://bitbucket.org/seu-usuario/seu-repositorio.git
```

#### Opção D: FlutterFlow (se conectado)
Se o projeto está conectado ao FlutterFlow, o repositório pode já estar configurado. Verifique no FlutterFlow.

### 3. Verificar Branch Atual

```bash
git branch
```

### 4. Fazer Push

#### Primeira vez (criar branch no remoto):
```bash
git push -u origin main
```

Ou se sua branch for `master`:
```bash
git push -u origin master
```

#### Próximas vezes:
```bash
git push
```

## Problemas Comuns

### Erro: "remote origin already exists"
Se você já tem um remote configurado mas quer mudar:
```bash
git remote set-url origin nova-url-aqui
```

### Erro: "authentication failed"
Você precisa autenticar:

**GitHub:**
- Use Personal Access Token (não mais senha)
- Ou configure SSH keys

**Configurar SSH:**
```bash
# Gerar chave SSH (se ainda não tiver)
ssh-keygen -t ed25519 -C "seu.email@exemplo.com"

# Adicionar ao ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copiar chave pública
cat ~/.ssh/id_ed25519.pub
# Cole no GitHub > Settings > SSH Keys
```

### Erro: "branch main does not exist"
Criar branch main:
```bash
git branch -M main
git push -u origin main
```

### Erro: "updates were rejected"
Alguém fez push antes de você. Faça pull primeiro:
```bash
git pull origin main --rebase
git push
```

## Comandos Úteis

### Ver status
```bash
git status
```

### Ver remotes configurados
```bash
git remote -v
```

### Ver commits locais não enviados
```bash
git log origin/main..HEAD
```

### Ver diferenças
```bash
git diff origin/main
```

## ⚠️ IMPORTANTE: Credenciais do Supabase

**ATENÇÃO:** Antes de fazer push, considere:

1. **Se o repositório for público:**
   - ❌ NÃO faça push com credenciais no código
   - Use variáveis de ambiente ou arquivo local

2. **Se o repositório for privado:**
   - ✅ Pode fazer push (mas ainda não é ideal)
   - Considere usar variáveis de ambiente mesmo assim

### Remover credenciais antes do push (se necessário)

1. Edite `lib/config/supabase_config.dart`:
```dart
const String _supabaseUrl = 'YOUR_SUPABASE_URL';
const String _supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

2. Crie arquivo local (já está no .gitignore):
```dart
// lib/config/supabase_config_local.dart
const String supabaseUrl = 'sua_url_real';
const String supabaseAnonKey = 'sua_chave_real';
```

3. Faça commit:
```bash
git add .
git commit -m "chore: Remover credenciais do código"
git push
```

## Fluxo Completo

```bash
# 1. Verificar status
git status

# 2. Adicionar mudanças
git add .

# 3. Fazer commit
git commit -m "feat: Implementação de Login e Cadastro"

# 4. Verificar remote
git remote -v

# 5. Se não tiver remote, adicionar
git remote add origin sua-url-aqui

# 6. Fazer push
git push -u origin main
```

## FlutterFlow

Se você está usando FlutterFlow:

1. O FlutterFlow pode fazer push automaticamente
2. Verifique nas configurações do projeto no FlutterFlow
3. Pode haver um botão "Push to Git" na interface

## Próximos Passos

1. Execute `git remote -v` para ver se há remote configurado
2. Se não houver, adicione um remote
3. Faça `git push -u origin main`
4. Se der erro, me diga qual é a mensagem exata

