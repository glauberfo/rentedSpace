#!/bin/bash

cd /Users/glauberfo/projetos/SpaceRented

# Verificar se git está instalado
if ! command -v git &> /dev/null; then
    echo "❌ Git não está instalado"
    exit 1
fi

# Verificar se já é um repositório git
if [ ! -d ".git" ]; then
    echo "🔄 Inicializando repositório Git..."
    git init
fi

# Configurar branch main se necessário
git branch -M main 2>/dev/null || true

# Adicionar todos os arquivos
echo "📦 Adicionando arquivos..."
git add .

# Verificar se há mudanças para commitar
if git diff --staged --quiet; then
    echo "ℹ️  Nenhuma mudança para commitar"
else
    echo "💾 Fazendo commit..."
    git commit -m "feat: Implementação de Login e Cadastro com Supabase

- Telas de Login e Cadastro em 3 etapas
- Integração com Supabase
- Validações de formulário
- Widgets reutilizáveis
- Tema e estilos customizados"
fi

# Verificar se há remote configurado
if git remote | grep -q origin; then
    echo "✅ Remote 'origin' encontrado"
    REMOTE_URL=$(git remote get-url origin)
    echo "   URL: $REMOTE_URL"
    echo ""
    echo "🚀 Fazendo push..."
    git push -u origin main 2>&1 || git push -u origin master 2>&1 || {
        echo ""
        echo "⚠️  Não foi possível fazer push automaticamente."
        echo "   Possíveis causas:"
        echo "   - Precisa de autenticação"
        echo "   - Remote não configurado corretamente"
        echo "   - Branch diferente de main/master"
        echo ""
        echo "Execute manualmente:"
        echo "   git push -u origin main"
    }
else
    echo "⚠️  Nenhum remote 'origin' configurado"
    echo ""
    echo "Para adicionar um remote, execute:"
    echo "   git remote add origin <URL_DO_REPOSITORIO>"
    echo ""
    echo "Exemplos:"
    echo "   GitHub:  git remote add origin https://github.com/usuario/repo.git"
    echo "   GitLab:  git remote add origin https://gitlab.com/usuario/repo.git"
fi

echo ""
echo "✅ Processo concluído!"

