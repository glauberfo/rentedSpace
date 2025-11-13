#!/usr/bin/env bash
set -e

# Script para resolver branches divergentes e fazer push
cd "$(dirname "$0")"

echo "🔧 Resolvendo branches divergentes..."

# Configurar estratégia de merge (rebase é mais limpo)
echo "📌 Configurando estratégia de merge como rebase..."
git config pull.rebase true

echo ""
echo "🔄 Fazendo pull com rebase..."
git pull --rebase origin main 2>&1 || git pull --rebase origin master 2>&1 || {
    echo "⚠️  Tentando com merge ao invés de rebase..."
    git config pull.rebase false
    git pull --no-rebase origin main 2>&1 || git pull --no-rebase origin master 2>&1
}

echo ""
echo "🚀 Fazendo push..."
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "main")

if git push -u origin "$CURRENT_BRANCH" 2>&1; then
    echo ""
    echo "✅ Push realizado com sucesso!"
else
    echo ""
    echo "⚠️  Ainda há problemas. Tentando forçar push (CUIDADO - apenas se você tem certeza)..."
    echo ""
    read -p "Deseja fazer force push? (s/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        git push -u origin "$CURRENT_BRANCH" --force-with-lease
        echo "✅ Force push realizado!"
    else
        echo "❌ Push cancelado. Resolva os conflitos manualmente."
    fi
fi

echo ""
echo "✅ Processo concluído!"

