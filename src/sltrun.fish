# A ordem aqui é importante! 
set flagActions "-e:exit"

function getCmdLine
    set cmdLine

    for flag in $flagActions
        for arg in $argv
            if test $arg = (string split ":" -- $flag)[1]
            set cmdLine $cmdLine (string split ":" -- $flag)[2]
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

    echo $flags
end

function log
    set msg $argv
    echo (date "+%d-%m-%Y %H:%M:%S") $msg >> ~/sltrun_logs.log
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
        if contains -- $arg $flags
            set sltArgs $sltArgs $arg
        else
            set cmdArgs $cmdArgs $arg
        end
    end

    if test (count $cmdArgs) -eq 0
        log "ERRO: Nenhum comando passado!"
        return

    else if test (count $sltArgs) -eq 0
        #Comportamento padrão da ferramenta
        echo "Rodando $cmdArgs[1] em segundo plano..."
        nohup $cmdArgs[1..-1] >> ~/sltrun_logs.log 2>&1 &
        disown
        return

    else
        #Comportamento baseado em argumentação

        set cmdLine (getCmdLine $sltArgs)

        echo "Rodando $cmdArgs[1] em segundo plano..."
        nohup $cmdArgs[1..-1] >> ~/sltrun_logs.log 2>&1 &
        disown
        eval $cmdLine
        return
    end
end

# Peço perdão pelo meu código pobre!
# É a primeira vez que uso fish...