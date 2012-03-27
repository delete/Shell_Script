#!/bin/bash

##################################################################################################
## 	~Autor: Fellipe Pinheiro / DeLeTe    @pinheirofellipe www.vivaolinux.com.br/~d3l3t3	##
##	~Agradecimento: Wladek Zacharski							##
##				 			     					##
##												##
##	~Versão: 0.1										##
##			-Liga e desliga os nucleos						##
##												##
##	~Versão: 0.2	-Programa usando  YAD.							##
##			-Testa se o usuario é ROOT ou não.					##
##												##
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



##Inicia todos os testes
TESTA(){
TESTA_CPU1
TESTA_CPU2
TESTA_CPU3
TESTA_CPU4
TESTA_CPU5
TESTA_CPU6
TESTA_CPU7
TESTA_CPU8
TESTA_CPU9
TESTA_CPU10
TESTA_CPU11
}

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
        test "$acao" -eq "1" || test "$acao" - eq "252"
        if [ "$?" -eq "0" ] ;then
              	TESTA
		MENU
        fi
}

## Funcao para testar todos os CPUs
TESTA_CPU1() {
	arq="/sys/devices/system/cpu/cpu1/online"
	if [ -e $arq ] ; then
	        valor=`cat "$arq"` # 'valor' recebe um numero inteiro
        	if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
	        	status1='Ligado'
		else
	        	status1='Desligado'
		fi
	else
		status1='Nulo'
	fi
}
TESTA_CPU2() {
	arq="/sys/devices/system/cpu/cpu2/online"
	if [ -e $arq ] ; then
	        valor=`cat "$arq" 2>/dev/null` # 'valor' recebe um numero inteiro
        	if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
	        	status2='Ligado'
		else
	        	status2='Desligado'
		fi
	else
		status2='Nulo'
	fi
}
TESTA_CPU3() {
	arq="/sys/devices/system/cpu/cpu3/online"
	if [ -e $arq ] ; then
	        valor=`cat "$arq" 2>/dev/null` # 'valor' recebe um numero inteiro
        	if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
	        	status3='Ligado'
		else
	        	status3='Desligado'
		fi
	else
		status3='Nulo'
	fi
}
TESTA_CPU4() {
	arq="/sys/devices/system/cpu/cpu4/online"
	if [ -e $arq ] ; then
        	valor=`cat "$arq" 2>/dev/null` # 'valor' recebe um numero inteiro
        	if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
        		status4='Ligado'
		else
        		status4='Desligado'
		fi
	else
		status4='Nulo'
	fi
}
TESTA_CPU5() {
	arq="/sys/devices/system/cpu/cpu5/online"
	if [ -e $arq ] ; then
	        valor=`cat "$arq" 2>/dev/null` # 'valor' recebe um numero inteiro
        	if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
	        	status5='Ligado'
		else
	        	status5='Desligado'
		fi
	else
		status5='Nulo'
	fi
}
TESTA_CPU6() {
	arq="/sys/devices/system/cpu/cpu6/online"
	if [ -e $arq ] ; then
	        valor=`cat "$arq" 2>/dev/null` # 'valor' recebe um numero inteiro
	        if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
	        	status6='Ligado'
		else
	        	status6='Desligado'
		fi
	else
		status6='Nulo'
	fi
}
TESTA_CPU7() {
	arq="/sys/devices/system/cpu/cpu7/online"
	if [ -e $arq ] ; then
	        valor=`cat "$arq" 2>/dev/null` # 'valor' recebe um numero inteiro
        	if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
	        	status7='Ligado'
		else
	        	status7='Desligado'
		fi
	else
		status7='Nulo'
	fi
}
TESTA_CPU8() {
	arq="/sys/devices/system/cpu/cpu8/online"
	if [ -e $arq ] ; then
	        valor=`cat "$arq" 2>/dev/null` # 'valor' recebe um numero inteiro
	        if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
	        	status8='Ligado'
		else
	        	status8='Desligado'
		fi
	else
		status8='Nulo'
	fi
}
TESTA_CPU9() {
	arq="/sys/devices/system/cpu/cpu9/online"
	if [ -e $arq ] ; then
	        valor=`cat "$arq" 2>/dev/null` # 'valor' recebe um numero inteiro
	        if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
	        	status9='Ligado'
		else
	        	status9='Desligado'
		fi
	else
		status9='Nulo'
	fi
}
TESTA_CPU10() {
	arq="/sys/devices/system/cpu/cpu10/online"
	if [ -e $arq ] ; then
	        valor=`cat "$arq" 2>/dev/null` # 'valor' recebe um numero inteiro
        	if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
	        	status10='Ligado'
		else
	        	status10='Desligado'
		fi
	else
		status10='Nulo'
	fi

}
TESTA_CPU11() {
	arq="/sys/devices/system/cpu/cpu11/online"
	if [ -e $arq ] ; then
        valor=`cat "$arq" 2>/dev/null` # 'valor' recebe um numero inteiro
	        if [ "$valor" -eq "1" ]; then # Testa se 'valor' é igual a '1'
	        	status11='Ligado'
		else
	        	status11='Desligado'
		fi
	else
		status11='Nulo'
	fi
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
			1 "CPU1: "$status1"" \
			2 "CPU2: "$status2"" \
			3 "CPU3: "$status3"" \
			4 "CPU4: "$status4"" \
			5 "CPU5: "$status5"" \
			6 "CPU6: "$status6"" \
			7 "CPU7: "$status7"" \
			8 "CPU8: "$status8"" \
			9 "CPU9: "$status9"" \
			10 "CPU10: "$status10"" \
			11 "CPU11: "$status11"" \
		)

	acao="$?" # Recebe o valor do ultimo comando
	test "$acao" -eq "1" || test "$acao" -eq "252"
	if [ "$?" -eq "0" ]; then
	exit
	fi

	op=$(echo $op | egrep -o '^[0-9]')	

	case $op in
		1) LIGAR "1"; TESTA; MENU;;
		2) LIGAR "2"; TESTA; MENU;;
		3) LIGAR "3"; TESTA; MENU;;
		4) LIGAR "4"; TESTA; MENU;;
		5) LIGAR "5"; TESTA; MENU;;
		6) LIGAR "6"; TESTA; MENU;;
		7) LIGAR "7"; TESTA; MENU;;
		8) LIGAR "8"; TESTA; MENU;;
		9) LIGAR "9"; TESTA; MENU;;
		10) LIGAR "10"; TESTA; MENU;;
		11) LIGAR "11"; TESTA; MENU;;
		*) 
			yad --image="gnome-about-logo" \
			--title="Alerta" \
			--text "Você esscolheu uma opção errada." \
			--button="Voltar para o menu."
			MENU;; 
	esac

}

## Chama as funcoes principais
TESTA
USER
