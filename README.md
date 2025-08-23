# sltrun

`sltrun` é uma ferramenta em **Fish Shell** para rodar comandos em segundo plano de forma controlada, com suporte a flags customizadas e logging.  

O projeto possui a seguinte estrutura:

``` 
sltrun/
├─ bin/
│   └─ sltrun          # Script executável principal
└─ src/
    └─ sltrun.fish     # Funções principais e lógica do silentRun
```

---

## Funcionalidades

- **Execução de comandos em segundo plano** (`nohup`) com logs.  
- **Flags personalizadas** que executam ações adicionais (por exemplo, `-e` para `exit`).  
- **Logging detalhado** em `~/sltrun_logs.log` com timestamp.  
- Separação clara entre argumentos que são **comandos** e argumentos que são **flags da ferramenta**.

---

## Arquivos principais

### bin/sltrun

- Script executável que chama as funções do `src/sltrun.fish`.  
- Passa os argumentos da linha de comando para `silentRun`.

Exemplo de uso:

```
sltrun nmap 127.0.0.1 -e
```

---

### src/sltrun.fish

Contém todas as funções essenciais:

#### 1. `set flagActions`

```
set flagActions "-e:exit"
```

- Lista de flags suportadas, no formato `<flag>:<comando>`.  
- Você pode adicionar novas flags seguindo esse padrão:

```
set flagActions "-e:exit" "-d:echo 'Debug mode'"
```

---

#### 2. Funções

##### `getCmdLine $argv`

- Recebe uma lista de flags.  
- Retorna os comandos associados a essas flags.  

##### `getFlags`

- Retorna apenas as flags cadastradas (`-e`, `-d`, etc.)  

##### `log $msg`

- Adiciona uma mensagem ao arquivo de log `~/sltrun_logs.log` com timestamp:

```
log "Erro ao executar comando"
```

##### `silentRun $argv`

- Função principal.  
- Separa **flags** (`sltArgs`) e **comandos** (`cmdArgs`).  
- Executa os comandos em segundo plano via `nohup`.  
- Avalia as flags adicionais usando `eval`.  
- Realiza logging automático.

---

## Execução

1. Torne o script executável:

```
chmod +x bin/sltrun
```

2. Coloque o script no PATH do sistema para poder executar apenas `sltrun`:

### Opção A: Copiar para `/usr/local/bin`

```
sudo cp bin/sltrun /usr/local/bin/sltrun
```

### Opção B: Adicionar a pasta `bin` do projeto ao PATH (permanente para Fish)

```
set -U fish_user_paths $PWD/bin $fish_user_paths
```

- Agora você pode rodar o comando diretamente de qualquer pasta:

```
sltrun nmap 127.0.0.1 -e
```

3. Para usar flags da ferramenta:

```
sltrun nmap 127.0.0.1 -e
```

- Nesse exemplo, `-e` executa o comando associado (`exit`).  

4. Verifique logs:

```
cat ~/sltrun_logs.log
```