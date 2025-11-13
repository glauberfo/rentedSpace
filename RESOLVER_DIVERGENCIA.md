# 🔧 Resolver Branches Divergentes

## Problema
Você tem branches divergentes - o branch local e o remoto têm commits diferentes.

## Solução Rápida

### Opção 1: Usar Rebase (Recomendado - mantém histórico limpo)
```bash
cd /Users/glauberfo/projetos/SpaceRented

# Configurar rebase como padrão
git config pull.rebase true

# Fazer pull com rebase
git pull --rebase origin main
# ou se sua branch for master:
git pull --rebase origin master

# Fazer push
git push -u origin main
```

### Opção 2: Usar Merge (Cria commit de merge)
```bash
cd /Users/glauberfo/projetos/SpaceRented

# Configurar merge como padrão
git config pull.rebase false

# Fazer pull com merge
git pull --no-rebase origin main

# Fazer push
git push -u origin main
```

### Opção 3: Executar o Script
```bash
cd /Users/glauberfo/projetos/SpaceRented
chmod +x resolver_divergencia.sh
./resolver_divergencia.sh
```

## Explicação das Opções

### Rebase (`git config pull.rebase true`)
- ✅ Mantém histórico linear e limpo
- ✅ Não cria commits de merge extras
- ⚠️ Reescreve o histórico (pode ser problemático se outros estão trabalhando)

### Merge (`git config pull.rebase false`)
- ✅ Preserva todo o histórico
- ✅ Mais seguro para trabalho em equipe
- ⚠️ Cria commits de merge extras

### Fast-forward only (`git config pull.ff only`)
- ✅ Mais seguro - só permite fast-forward
- ⚠️ Falha se houver divergências (precisa resolver manualmente)

## Recomendação

Para este projeto, recomendo **rebase**:

```bash
git config pull.rebase true
git pull --rebase origin main
git push -u origin main
```

## Se Houver Conflitos

Se aparecerem conflitos durante o rebase/merge:

1. **Ver arquivos com conflito:**
   ```bash
   git status
   ```

2. **Resolver conflitos manualmente** nos arquivos marcados

3. **Após resolver:**
   ```bash
   # Se estava fazendo rebase:
   git rebase --continue
   
   # Se estava fazendo merge:
   git commit
   ```

4. **Fazer push:**
   ```bash
   git push -u origin main
   ```

## Configuração Global (Opcional)

Se quiser que isso seja padrão para todos os seus projetos:

```bash
# Rebase global
git config --global pull.rebase true

# Ou merge global
git config --global pull.rebase false
```

## ⚠️ Force Push (CUIDADO!)

Só use se você tem **100% de certeza** que quer sobrescrever o remoto:

```bash
git push -u origin main --force-with-lease
```

**NUNCA** use `--force` sem `--force-with-lease` - é mais seguro!

