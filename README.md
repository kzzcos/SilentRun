# SilentRun

**SilentRun** é uma ferramenta simples para rodar qualquer comando em segundo plano no Linux.  
Permite passar múltiplos argumentos, suporta flags internas como `-e` e `-dc` e mantém o processo rodando mesmo após fechar o terminal.

> ⚠️ Projeto em desenvolvimento – funcionalidades e interface podem mudar.

---

## Instalação

1. Clone o repositório:

```
git clone https://github.com/kzzcos/SilentRun.git
cd SilentRun
```

2. Torne o script executável:

```
chmod +x bin/sltrun
```

3. Opcional: mova para uma pasta no PATH para usar globalmente:

```
sudo cp bin/sltrun /usr/local/bin/sltrun
```

4. Alternativa (para Fish Shell): adicione a pasta `bin` ao PATH permanentemente

```
set -U fish_user_paths $PWD/bin $fish_user_paths
```

---

## Uso

```
# Rodar um comando em background
sltrun firefox

# Rodar um comando que finaliza o terminal após execução (flag -e)
sltrun -e htop
```
 
- `-e` é uma flag interna que encerra o terminal após executar o comando associado.  
- Todos os argumentos após `sltrun` são passados diretamente para o comando a ser executado.  

---

## Logs

- Por padrão, a saída do comando em background é salva em `~/sltrun_logs.log`.  
- Tanto stdout quanto stderr são registrados:

```
nohup <comando> >> ~/sltrun_logs.log 2>&1 &
```

- Você pode visualizar o log a qualquer momento:

```
cat ~/sltrun_logs.log
```

---

## Estrutura do Projeto

- `bin/sltrun`: script executável principal que chama as funções do `src/sltrun.fish`.  
- `src/sltrun.fish`: contém funções como:
  - `silentRun`: executa comandos em background separando flags internas e argumentos.
  - `getFlags`: retorna a lista de flags internas disponíveis.
  - `getCmdLine`: mapeia cada flag para sua ação correspondente.
  - `log`: registra mensagens no arquivo de log com timestamp.

- As flags internas estão configuradas em `set flagActions`, por exemplo:

```
set flagActions "-e:exit"
```

---

## Contribuição

Contribuições, ideias e correções são bem-vindas!  
Como o projeto está em desenvolvimento, algumas funcionalidades podem mudar.
