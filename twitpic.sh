#!/bin/bash


##########################################################################################################
##Autor: Fellipe Pinheiro / DeLeTe    @pinheirofellipe www.vivaolinux.com.br/~d3l3t3	        	##
##Script para enviar fotos para sua conta no Twitpic.					     	     	##
##	Agradecimento ao site	www.vivaolinux.com.br			 			     	##
## Para rodar o script é preciso instalar o YAD e o CURL - Em Debian-> sudo apt-get install yad curl 	##
##########################################################################################################

LOGIN() {
	##LOGIN

	_login=$(\
		yad --entry \
		--entry-label="Login" \
		--completion \
		--editable \
		--title="Entre com seu login." \
		--width="300"\
		)


	##SENHA

	_senha=$(\
		yad --entry \
		--entry-label="Senha" \
		--completion \
		--editable \
		--hide-text \
		--title="Entre com sua senha."\
		--width="300"\
		)
	
	MENU
}

## Adiciona a foto
ADD_FOTO() {
	##FOTO
	_foto=$(\
		yad --file \
		--file \
		--file-filter='Imagem | *.png *jpg *jpeg' \
		--title="Escolha uma foto:" \
		--width="500" \
		--height="400" \
		)
	MENU
}

## Adicionar comentario da foto
ADD_MSG() {
	##MENSAGEM
	_msg=$(\
		yad --entry \
		--entry-label="Comentario:" \
		--completion \
		--editable \
		--title="Escreva um comentário para a foto." \
		--width="600" \
		)
	MENU

}

## Envia a foto 
ENVIA() {
	curl -k -F "media=@$_foto" -F "username=$_login" -F "password=$_senha" -F "message=$_msg" https://twitpic.com/api/uploadAndPost > /tmp/site.txt
	#cat /tmp/site.txt | grep -i http | cut -f2 -d\> | sed 's/<\/mediaurl/  /' > /tmp/site.txt

	if [ $? -ne 0 ] ; then # Testa se o comando a cima deu erro.
		yad --title="Error no envio!" \
		--image="face-angry" \
		--text="Não foi possivel enviar a foto, verifique se o login e senha estão corretos!" \
		--width="600" \
		--height="50" \
		--button=gtk-ok:0
		
	else
		yad --text-info --title="Foto enviada!" \
		--width="300" \
		--height="300" \
		--fore="#FFFFFF" --back="#000000" --fontname="Ubuntu Mono" \
		--filename="/tmp/site.txt" \
		--show-uri \
		--button='Sair':1

	fi
}


## Sobre o programador

SOBRE() {
	yad --title="Programador: Fellipe Pinheiro" \
	--text="Twitter: @Pinheirofellipe" \
	--width="400" \
	--height="100" \
	--button=gtk-ok:0
	MENU	

}

## Menu de opcoes
MENU() {
	
	op=$(\
		yad --list \
		--title="Bem vindo, envie sua foto para o Twitpic!" \
		--column="ID":NUM \
		--column="Escolha uma das opções:":TEXT \
		--width="400" \
		--height="400" \
		--button="Sair":1 \
		--button="Selecionar":0 \
			1 "Fazer login" \
			2 "Adicionar fotos" \
			3 "Adicionar comentário" \
			4 "Enviar" \
			5 "Sobre" \
		)

	acao="$?"
	test "$acao" -eq "1" || test "$acao" -eq "252"
	if [ "$?" -eq "0" ]; then
	exit
	fi

	op=$(echo $op | egrep -o '^[0-9]')	

	case $op in
		1) LOGIN;;
		2) ADD_FOTO;;
		3) ADD_MSG;;
		4) ENVIA;;
		5) SOBRE;;
		*) 
			yad --image="face-angry" \
			--title="Alerta" \
			--text "Você esscolheu uma opção errada." \
			--button="Voltar para o menu."
			MENU;; 
	esac

}

## Chama o menu
MENU
