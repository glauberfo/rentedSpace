# 🚀 Comandos Git para Executar

Como há um problema temporário com o shell, execute estes comandos manualmente no seu terminal:

## Comandos para Executar

```bash
cd /Users/glauberfo/projetos/SpaceRented

# 1. Verificar status
git status

# 2. Adicionar todos os arquivos
git add .

# 3. Fazer commit
git commit -m "feat: Implementação de Login e Cadastro com Supabase

- Telas de Login e Cadastro em 3 etapas
- Integração com Supabase configurada
- Validações de formulário completas
- Widgets reutilizáveis
- Tema e estilos customizados
- Serviço de autenticação completo"

# 4. Verificar se há remote
git remote -v

# 5. Se houver remote, fazer push
git push -u origin main
# ou se sua branch for master:
git push -u origin master
```

## Ou Execute o Script

Torne o script executável e execute:

```bash
chmod +x EXECUTAR_GIT.sh
./EXECUTAR_GIT.sh
```

## Se Não Tiver Remote Configurado

Adicione um remote primeiro:

```bash
# GitHub
git remote add origin https://github.com/seu-usuario/seu-repo.git

# GitLab
git remote add origin https://gitlab.com/seu-usuario/seu-repo.git

# Depois faça push
git push -u origin main
```

## ⚠️ Nota sobre Credenciais

O arquivo `lib/config/supabase_config.dart` contém suas credenciais do Supabase. 

- Se o repositório for **privado**: OK para commitar
- Se o repositório for **público**: Considere remover as credenciais antes do push

