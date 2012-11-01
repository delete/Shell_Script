#!/bin/bash

##################################################################################################
## 	~Autor: Fellipe Pinheiro / DeLeTe    @pinheirofellipe 					##
##	~Programador colaborador: Willian Oliveira   @WillianOLdJ // Muito obrigado cara!!!!!!	##	
##	~Agradecimento: Wladek Zacharski							##
##				 			     					##
##												##
##	~Versão: 0.1										##
##			-Liga e desliga os nucleos						##
##												##
##	~Versão: 0.2	-Programa usando  YAD.							##
##			-Testa se o usuario é ROOT ou não.					##
##												##
##	~Versão: 0.3	-Redução do codigo com a ajuda do Willian Oliveira.			##
##			-Programa só reconhece até 9 CPUs.					##
##												##
##	~Função:										##
##	Mostra quantos nucleos o processador tem, e da opções de para-los.			##
##												##
##	~Instalação:										##
##	--Dependencias : YAD 									##
##	-Em Debian-Like :									##
##	sudo add-apt-repository ppa:webupd8team/y-ppa-manager && sudo apt-get update 		##
##	sudo apt-get install yad								##
##												##
##	~Execução:										##
##	-Execute o programa como ROOT								##
##												##
##												##
##################################################################################################




##Funcao testa se o usuario eh root
USER(){

	userid=`id -u` #userid recebe 1000 para usuario e 0 para root
	if [ "$userid" -eq "0" ]; then
		ENTRADA
	else
		yad --title="Olá "$USER"" \
		--text="Por favor $USER, execute esse programa como usuário ROOT! " \
		--width="400" \
		--height="100" \
		--image="gnome-background-image" \
		--button="Sair":1 \

		acao="$?"
        	test "$acao" -eq "1" || test "$acao" - eq "252"
	        if [ "$?" -eq "0" ] ;then
        	      	exit
		fi
	fi
}


##Funcao que mostra para o usuario quantos nucleo o pc tem;
ENTRADA(){
	num=`egrep "^processor" /proc/cpuinfo | wc -l` # 'num' recebe o numero de nucleos
	max=`expr $num - 1`
	 yad --title="Bem vindo!" \
	--text="Foram encotrados "$num" nucleos no seu computador! 
Por segurança, você só poderá desligar "$max" nucleos!" \
        --width="400" \
        --height="100" \
        --image="gnome-background-image" \
        --button="Continuar":1 \

acao="$?"
        test "$acao" -eq "1" || test "$acao" -eq "252"
        if [ "$?" -eq "0" ] ;then
              	TESTA_CPU
		MENU
        fi
}

## Funcao para testar todos os CPUs 

function TESTA_CPU(){

#Mostra o número de processadores
cont_proc=`ls -d /sys/devices/system/cpu/cpu[0-99] | wc -l`

for ((x = 0; x < $cont_proc; x++))
do

#Verifica se o arquivo online é localizado
	if [ -e /sys/devices/system/cpu/cpu"$x"/online ]
	then

#Se sim, então ele coloca o valor na Array
        	valor[$x]=$(cat /sys/devices/system/cpu/cpu"$x"/online)

#Verifica qual núcleo está ligado
	if [ "${valor["$x"]}" = 1 ] #>/dev/null 2>&1
        then
                status["$x"]="Ligado"
        else
                status["$x"]="Desligado"
        fi

	else
#Se não, então ele coloca o valor PRINCIPAL
        	status[$x]="Principal"
	fi

done
}

##Funcao para ligar e desligar o nucleo
# O "$1" recebe o parametro para funcao
function LIGAR(){

	valor=`cat /sys/devices/system/cpu/cpu"$1"/online` 2>>/dev/null

	if [ "$valor" -eq "1" ]; then
		echo 0 >> /sys/devices/system/cpu/cpu"$1"/online 2>>/dev/null
        else
		echo 1 >> /sys/devices/system/cpu/cpu"$1"/online 2>>/dev/null
        fi
}


## Tela principal do programa
MENU() {
	
	op=$(\
		yad --list \
		--title="Gerenciamento de processadores!" \
		--column="ID":NUM \
		--column="Status:":TEXT \
		--width="400" \
		--height="400" \
		--button="Sair":1 \
		--button="Selecionar":0 \
			1 "CPU1: "${status[1]}"" \
			2 "CPU2: "${status[2]}"" \
			3 "CPU3: "${status[3]}"" \
			4 "CPU4: "${status[4]}"" \
			5 "CPU5: "${status[5]}"" \
			6 "CPU6: "${status[6]}"" \
			7 "CPU7: "${status[7]}"" \
			8 "CPU8: "${status[8]}"" \
			9 "CPU9: "${status[9]}"" \
		)

	acao="$?" # Recebe o valor do ultimo comando
	test "$acao" -eq "1" || test "$acao" -eq "252"
	if [ "$?" -eq "0" ]; then
	exit
	fi

	#op=$(echo $op | egrep -o '^[0-9]')	
	op=$(echo $op | egrep -o '^[0-9]')	

	case $op in
		1) LIGAR "1"; TESTA_CPU; MENU;;
		2) LIGAR "2"; TESTA_CPU; MENU;;
		3) LIGAR "3"; TESTA_CPU; MENU;;
		4) LIGAR "4"; TESTA_CPU; MENU;;
		5) LIGAR "5"; TESTA_CPU; MENU;;
		6) LIGAR "6"; TESTA_CPU; MENU;;
		7) LIGAR "7"; TESTA_CPU; MENU;;
		8) LIGAR "8"; TESTA_CPU; MENU;;
		9) LIGAR "9"; TESTA_CPU; MENU;;
		*) 
			yad --image="gnome-about-logo" \
			--title="Alerta" \
			--text "Você esscolheu uma opção errada." \
			--button="Voltar para o menu."
			MENU;; 
	esac

}

## Chama as funcoes principais
TESTA_CPU
USER
