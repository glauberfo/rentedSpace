#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"

echo "🔄 Verificando repositório Git..."

# Verificar se é um repositório git
if [ ! -d ".git" ]; then
    echo "📦 Inicializando repositório Git..."
    git init
    git branch -M main 2>/dev/null || git branch -M master 2>/dev/null || true
fi

echo "📊 Status atual:"
git status --short || true

echo ""
echo "📦 Adicionando arquivos..."
git add .

echo ""
echo "💾 Fazendo commit..."
git commit -m "feat: Implementação de Login e Cadastro com Supabase

- Telas de Login e Cadastro em 3 etapas
- Integração com Supabase configurada
- Validações de formulário completas
- Widgets reutilizáveis (CustomTextField, CustomButton, ProgressIndicator, LogoWidget)
- Tema e estilos customizados baseados no design
- Serviço de autenticação completo
- Modelo de dados do usuário
- Documentação completa" || {
    echo "⚠️  Nenhuma mudança para commitar ou commit já existe"
}

echo ""
echo "🔍 Verificando remote..."
if git remote | grep -q "^origin$"; then
    REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "não configurado")
    echo "✅ Remote 'origin' encontrado: $REMOTE_URL"
    echo ""
    echo "🚀 Fazendo push..."
    
    # Detectar branch atual
    CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
    echo "📌 Branch atual: $CURRENT_BRANCH"
    
    # Tentar push
    if git push -u origin "$CURRENT_BRANCH" 2>&1; then
        echo ""
        echo "✅ Push realizado com sucesso!"
    else
        echo ""
        echo "⚠️  Erro ao fazer push. Possíveis causas:"
        echo "   - Precisa de autenticação (configure SSH ou use token)"
        echo "   - Branch diferente no remoto"
        echo "   - Sem permissão no repositório"
        echo ""
        echo "Tente executar manualmente:"
        echo "   git push -u origin $CURRENT_BRANCH"
    fi
else
    echo "⚠️  Nenhum remote 'origin' configurado"
    echo ""
    echo "Para adicionar um remote, execute:"
    echo "   git remote add origin <URL_DO_REPOSITORIO>"
    echo ""
    echo "Exemplos:"
    echo "   GitHub:  git remote add origin https://github.com/usuario/repo.git"
    echo "   GitLab:  git remote add origin https://gitlab.com/usuario/repo.git"
    echo ""
    echo "Depois execute este script novamente."
fi

echo ""
echo "✅ Processo concluído!"

