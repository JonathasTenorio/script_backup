#!/bin/bash

# leitura de variável utiliza $ antes da variável. 
# necessário dar permissão ao usuário, execute chmod u+x backup.sh

echo "Este programa irá copiar recursivamente a partir do diretório informado."
echo "Digite o diretiorio para backup:"

# Le o valor inserido pelo prompt
read dir_bckup

function backup {
    
   #verifica se o caminho passado existe
    if [ -d "$dir_bckup" ]; then
        
        #verifica se ao contar a quantidade de arquios haverá erros
        saida=$(find "$dir_bckup" -type f 2>&1)
        
        #recebe o erro
        erro=$?
        
        #verifica se o diretório de backup existe    
        if [ ! -d ~/backup ]; then
            # chama a funcao para criar o diretorio de backup
            makeDirectorie
        fi
        
        # verifica se existe erro ao contabilizar os arquivos
        if [ $erro -ne 0 ]; then
            
            #exibe o erro caso exista
            echo "Erro ao contabilizar os arquivos: $saida"
            echo "Iniciando o backup no diretório . . . " $dir_bckup,
        else
            #contabiliza a quantidade de arquivos que serão copiados
            qnt=$(find "$dir_bckup" -type f | wc -l)
            echo "Iniciando o backup no diretório . . . " $dir_bckup, copiando $qnt arquivos
        fi

        #copia os arquivop recursivamente
        cp -rv $dir_bckup ~/backup #Altere o caminho p/ onde deseja realizar o backup

        echo ""
        echo "Backup Concluido!"

    else
        echo "O diretório informado não existe."
    fi
}

# Chama a função backup
backup


#funcao que cria o diretorio de backup
function makeDirectorie {

    echo "Criando pasta de backup em: ~/backup"
    
    #cria diretorio para o backup no caminho
    mkdir ~/backup
    
    #retorna para a funcao principal
    return 
}