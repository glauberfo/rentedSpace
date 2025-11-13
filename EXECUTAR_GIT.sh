#!/usr/bin/env bash
set -e

# Script para fazer commit e push do projeto SpaceRented
# Execute: bash EXECUTAR_GIT.sh ou ./EXECUTAR_GIT.sh

cd "$(dirname "$0")"

echo "🔄 Verificando status do Git..."
git status

echo ""
echo "📦 Adicionando todos os arquivos..."
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
- Documentação completa (README, SETUP_SUPABASE, guias)"

echo ""
echo "🚀 Verificando remote..."
if git remote | grep -q origin; then
    REMOTE_URL=$(git remote get-url origin)
    echo "✅ Remote encontrado: $REMOTE_URL"
    
    # Detectar branch atual
    CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
    echo "📌 Branch atual: $CURRENT_BRANCH"
    
    # Configurar estratégia de pull (rebase por padrão)
    if ! git config pull.rebase > /dev/null 2>&1; then
        echo "⚙️  Configurando pull.rebase = true (pode ser alterado depois)"
        git config pull.rebase true
    fi
    
    echo ""
    echo "🔄 Fazendo pull primeiro (para sincronizar)..."
    if git pull --rebase origin "$CURRENT_BRANCH" 2>&1; then
        echo "✅ Pull realizado com sucesso!"
    else
        echo "⚠️  Problema no pull. Tentando continuar mesmo assim..."
    fi
    
    echo ""
    echo "🚀 Fazendo push..."
    if git push -u origin "$CURRENT_BRANCH" 2>&1; then
        echo "✅ Push realizado com sucesso!"
    else
        echo "⚠️  Erro ao fazer push. Possíveis causas:"
        echo "   - Branches divergentes (execute: ./resolver_divergencia.sh)"
        echo "   - Autenticação necessária"
        echo "   - Permissões no repositório"
        echo "   - Conexão com internet"
        echo ""
        echo "💡 Dica: Se houver divergência, execute:"
        echo "   ./resolver_divergencia.sh"
    fi
else
    echo "⚠️  Nenhum remote 'origin' configurado"
    echo ""
    echo "Para adicionar um remote, execute:"
    echo "   git remote add origin <URL_DO_REPOSITORIO>"
    echo ""
    echo "Depois execute novamente este script ou:"
    echo "   git push -u origin main"
fi

echo ""
echo "✅ Processo concluído!"

