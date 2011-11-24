#!/bin/bash
#####################################################################
# 		 Script de backup do historico do emesene.
##Autor: Fellipe Pinheiro / DeLeTe    (pinheiro.llip[at]gmail[dot]com)
#
#		www.vivaolinux.com.br/~d3l3t3
######################################################################


#Limpa consola
clear

#### Variaveis ####
#Diretorio de onde sera salvo
dropdir=("$HOME/Dropbox/Backup/msn/html_logs")

#log
txt=("$HOME/Documentos/log.txt")
###################
#email
email=

#Copiando
cd $HOME/.config/emesene1.0/[EMAIL]_hotmail_com/html_logs/

cp -r * "$dropdir"

####Testando o comando acima e envinado o email!####
if [ $? -ne 0 ];then
 	if [ -s "$txt" ] ;then #Testa se o tamanho do arquivo é maior que 0
  		 		
		echo >> "$txt"
  		echo "Backup do Emesene falhou em `date +%d-%m-%y`" >> "$txt"
  		ssmtp '$email'  < "$txt"
	else
		echo "Subject: Backup do Emesene" > "$txt" 
		echo >> "$txt"
  		echo "Backup do Emesene falhou em `date +%d-%m-%y`" >> "$txt"
  		ssmtp '$email' < "$txt"

		
	fi
else
	if [ -s "$txt" ] ;then #Testa se o tamanho do arquivo é maior que 0
  		
  		echo >> "$txt"
  		echo "Backup do Emesene feito em `date +%d-%m-%y`" >> "$txt"
  		ssmtp '$email' < "$txt"
  	else
		echo "Subject: Backup do Emesene" > "$txt"
		echo >> "$txt"
  		echo "Backup do Emesene feito em `date +%d-%m-%y`" >> "$txt"
  		ssmtp '$email' < "$txt"

		
	fi
fi
