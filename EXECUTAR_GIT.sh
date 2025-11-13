#!/bin/bash

# Script para fazer commit e push do projeto SpaceRented
# Execute: bash EXECUTAR_GIT.sh

cd /Users/glauberfo/projetos/SpaceRented

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
    echo ""
    echo "🚀 Fazendo push..."
    
    # Tentar push para main primeiro
    if git push -u origin main 2>&1; then
        echo "✅ Push realizado com sucesso para branch 'main'!"
    # Se falhar, tentar master
    elif git push -u origin master 2>&1; then
        echo "✅ Push realizado com sucesso para branch 'master'!"
    else
        echo "⚠️  Erro ao fazer push. Verifique:"
        echo "   - Autenticação configurada"
        echo "   - Permissões no repositório"
        echo "   - Conexão com internet"
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

