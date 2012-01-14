#!/bin/bash


##########################################################################################################
## 	~Autor: Fellipe Pinheiro / DeLeTe    @pinheirofellipe www.vivaolinux.com.br/~d3l3t3	        ##
##	~Agradecimentos ao site: www.vivaolinux.com.br			 			     	##
##													##
##	~Versão: 0.1											##
##	~Versão: 0.2	-Layout novo.									##
##			-Envia várias fotos com o mesmo login sem precisar reabrir o mesmo programa.	##
##													##
##													##			
##	~Função:											##
##	Script para enviar fotos/imagens para o site Twitpic.com. Use a conta do Twitpic ou do Twitter!	##
##													##
##	~Instalação:											##
##	OBS:Para rodar o script é preciso instalar o YAD e o CURL	 				##
##	Em Debian-Like :										##
##	sudo add-apt-repository ppa:webupd8team/y-ppa-manager && sudo apt-get update 			##
##	sudo apt-get install yad curl									##
##													##
##													##
##########################################################################################################


############
## Inicio ##
############

INICIO() {

	yad --title="Bem vindo." \
	--width="200" \
	--height="100" \
	--image="gnome-background-image" \
	--button="Logar":1 \

acao="$?"
	test "$acao" -eq "1" || test "$acao" - eq "252"
	if [ "$?" -eq "0" ] ;then
		LOGIN
	fi 



} 


####################
## Login da conta ##
####################

LOGIN() {
	##LOGIN

	_login=$(\
		yad --entry\
		--entry-label="Usuário:"\
		--completion \
		--editable \
		--title="Entre com o nome de usuário:" \
		--width="300"\
		)


	##SENHA

	_senha=$(\
		yad --entry \
		--entry-label="Senha:"\
		--completion \
		--editable \
		--hide-text \
		--title="Entre com sua senha:"\
		--width="300"\
		)
	
	MENU
}
#####################
## Adiciona a foto ##
#####################

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

}
##################################
## Adicionar comentario na foto ##
##################################

ADD_MSG() {
	##MENSAGEM

	_msg=$(\
		yad --entry \
		--entry-label="Comentário:" \
		--completion \
		--editable \
		--title="Escreva um comentário para a foto." \
		--width="600" \
		)
	

}
##################
## Envia a foto ##
##################

ENVIA() {
	curl -k -F "media=@$_foto" -F "username=$_login" -F "password=$_senha" -F "message=$_msg" https://twitpic.com/api/uploadAndPost > /tmp/site.txt
	#cat /tmp/site.txt | grep -i http | cut -f2 -d\> | sed 's/<\/mediaurl/  /' > /tmp/site.txt

	if [ $? -ne 0 ] ; then # Testa se o comando a cima deu erro.
		yad --title="Ops! Error no envio!" \
		--image="face-angry" \
		--text="Não foi possivel enviar a foto, verifique se possui conexão com a internet e se o login e senha estão corretos!" \
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
		--button="Sair":1 \
		--button="Voltar":0 \
	
	acao="$?"
	#test "$acao" -eq "1" || test "$acao" -eq "252"
		if [ "$?" -eq "0" ]; then
			MENU
		fi

	fi
}

########################
## Sobre o programador##
########################

TEXTO() {
	echo "~Fellipe Pinheiro / DeLeTe" > /tmp/sobre.txt
	echo "~Contato: @pinheirofellipe" >> /tmp/sobre.txt
	echo "~Compartilhe conhecimento." >> /tmp/sobre.txt

}

SOBRE() {
	yad --text-info --title="Proramador:" \
	--width="400" \
	--height="150" \
	--button=gtk-ok:0 \
	--fore="FFFFFF" --back="#000000" --fontname="Ubuntu Mono" \
	--filename="/tmp/sobre.txt" \

}




####################
## Menu Principal ##
####################
MENU() {
	
	op=$(\
		yad --list \
		--title="Envie sua foto para o Twitpic!" \
		--column="ID":NUM \
		--column="Escolha uma das opções:":TEXT \
		--width="400" \
		--height="400" \
		--button="Sair":1 \
		--button="Selecionar":0 \
			1 "Adicionar fotos" \
			2 "Adicionar comentário" \
			3 "Enviar" \
			4 "Sobre" \
		)

	acao="$?"
	test "$acao" -eq "1" || test "$acao" -eq "252"
	if [ "$?" -eq "0" ]; then
	exit
	fi

	op=$(echo $op | egrep -o '^[0-9]')	

	case $op in
		1) ADD_FOTO; MENU;;
		2) ADD_MSG; MENU;;
		3) ENVIA;;
		4) TEXTO; SOBRE; MENU;;
		*) 
			#yad --image="face-angry" \
			yad --image="gnome-about-logo" \
			--title="Alerta" \
			--text "Você esscolheu uma opção errada." \
			--button="Voltar para o menu."
			MENU;; 
	esac

}

## Chama o menu principal

INICIO

	

