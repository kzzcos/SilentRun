set parent_pid (ps -o ppid= -p %self)
set flagActions "-e:kill -9 $parent_pid:-1"
# Formato: <flag> : <comando> : <prioridade>
# Format: <flag> : <command> : <priority>
# -1: prioridade minima - minimum priority
# 0: prioridade máxima - maximum priority

function getCmdLine
    set cmdLine

    for arg in $argv
        for flag in $flagActions
            set flagProperties (string split ":" -- $flag)
            if test $arg = $flagProperties[1]
                if test -- $flagProperties[3] = "-1"
                    set cmdLine $cmdLine ":" (string split ":" -- $flag)[2]
                else
                    set (string split ":" -- $flag)[2] ":" cmdLine $cmdLine
                end

                # Essa parte armazena as propriedades da flag
                # e checa a posição dela com base na prioridade

                # This part store the flag properties and 
                # check the position based on priority

            end
        end
    end
    echo $cmdLine
    return
end

function getFlags
    set flags

    for flag in $flagActions
        set flags $flags (string split ":" -- $flag)[1]
    end

    echo -- $flags
end

function log
    set msg $argv
    echo -- (date "+%d-%m-%Y %H:%M:%S") $msg >> ~/sltrun_logs.log
    return
end

function silentRun
    set flags (getFlags)

    set cmdArgs
    set sltArgs

    if test (count $argv) -eq 0
        echo "Use o argumento --help para obter ajuda!"
        return
    end

    for arg in $argv

        if test $arg = "--help"
            echo ""
            echo "Uso: sltrun [flags] <comando> [args...]"
            echo ""
            echo "Flags internas:"
            echo "  -e       Fecha o terminal após executar o comando"
            echo "  Por enquanto apenas este..."
            echo ""
            echo "Exemplos:"
            echo "  sltrun firefox               # Roda firefox em segundo plano"
            echo "  sltrun -e nmap -sV 127.0.0.1  # Roda nmap em segundo plano e fecha o terminal"
            echo ""

        else if contains -- $arg $flags
            set sltArgs $sltArgs $arg
        else
            set cmdArgs $cmdArgs $arg
        end

    end

    if test (count $cmdArgs) -eq 0
        log "ERRO: Nenhum comando passado!"
        return

    else if test (count $sltArgs) -eq 0

        # Comportamento padrão da ferramenta
        # Tool default behavior
        echo "Rodando $cmdArgs[1] em segundo plano..."
        nohup $cmdArgs >> ~/sltrun_logs.log 2>&1 &
        disown
        return

    else

        # Comportamento baseado em argumentação
        # Argument based behavior
        set cmdLine (getCmdLine $sltArgs)

        echo "Rodando $cmdArgs[1] em segundo plano..."
        nohup $cmdArgs >> ~/sltrun_logs.log 2>&1 &
        disown
        while not ps -p $last_pid > /dev/null 2>&1
            sleep 0.1
        end
        for command in (string split ":" -- $cmdLine)
            eval $command
        end
        return
    end
end

# Peço perdão pelo meu código pobre!
# É a primeira vez que uso fish...

# Sorry for my skillless code! 
# I don't have such knowledge on fish...