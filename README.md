# sltrun

**sltrun** é uma ferramenta simples para rodar qualquer comando em segundo plano no Linux.  
Permite passar múltiplos argumentos, suporta a flag interna `-dc` e mantém o processo rodando mesmo após fechar o terminal.

> ⚠️ Projeto em desenvolvimento – funcionalidades e interface podem mudar.

---

## Instalação

1. Clone o repositório:

```
git clone https://github.com/kzzcos/sltrun.git
cd sltrun
```

2. Torne o script executável:

```bash
chmod +x bin/sltrun
```

3. Opcional: mova para uma pasta no PATH para usar globalmente:

```bash
sudo cp bin/sltrun /usr/local/bin/sltrun
```

---

## Uso

```bash
# Rodar um comando em background
sltrun firefox

# Rodar um comando com a flag -dc
sltrun -dc nmap -sV 127.0.0.1
```

- `-dc` é uma flag interna que faz com que o terminal não feche após rodar o comando em segundo plano.  
- Todos os argumentos após `sltrun` são passados diretamente para o comando a ser executado.  

---

## Logs

- Por padrão, a saída do comando em background é salva em `~/sltrun_logs.log`.  

---

## Contribuição

Contribuições, ideias e correções são bem-vindas!  
Como o projeto está em desenvolvimento, algumas funcionalidades podem mudar.

