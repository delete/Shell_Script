#/bin/bash
#####################################################################
# 		 #Agenda Telefonica#
#
##Autor: Fellipe Pinheiro / DeLeTe    (pinheiro.llip[at]gmail[dot]com)
#
#		www.vivaolinux.com.br/~d3l3t3
######################################################################


#### Diretorio dos contatos
contatos(){
if [ -e contatos ] ; then
	cd contatos
else
	mkdir contatos
	cd contatos
fi
}

#### Menu

menu() {
reset
echo "Bem vindo a lista telefonica."
echo
num=`ls | wc -l` #Conta o numero de linhas(aquivos)
if [ "$num" -ge "2" ] ;then
	echo "## Existem $num contatos salvos! ##"
	echo 
else
	echo "##Existe $num contato salvo!##"
	echo
fi
echo "-----------------------------------------"
ls
echo "-----------------------------------------"
echo 
echo "O que deseja fazer?"
echo
echo "(1) Visualizar contato"
echo "(2) Procurar por contato"
echo "(3) Novo contato"
echo "(4) Editar contato"
echo "(5) Deletar contato"
echo "(6) Sair"
echo -n "Opção:"
read opcao

case $opcao in

	1) ver;;
	2) procurar;;
	3) novo;;
	4) editar;;
	5) deletar;;
	6) exit;;	
	*) clear ; echo ; echo "Opção errada!" ; echo ; echo ; sleep 2 ; menu ;;
esac
}

######################################## Opcoes

### Novo contato
novo() {

echo -e "Entre com um nome: "
read nome 
contato=`echo "$nome" |tr '[:upper:]' '[:lower:]'` #Converte maiuscula em minuscula

if [ -e "$contato" ] ;then
	clear
	echo
	echo "Já existe um contato com esse nome!"
	echo
	sleep 2
	clear
	menu
else
	touch "$contato" 2>/dev/null
	echo -e "Numero:"
	read num
	echo "Nome: $contato" > "$contato" 2>/dev/null
	echo "Numero: $num " >> "$contato" 2>/dev/null
	echo -e "Operadora: "
	read operadora
	echo "Operadora: $operadora" >> "$contato" 2>/dev/null
	echo
	echo "Novo contato criado"
	echo
	echo "Voltando para o menu..." ; sleep 2
	clear
	menu
fi
}

#### Visualizar contato
ver() {

clear
echo "Nome do contato:"
read nome
contato=`echo "$nome" | tr '[:upper:]' '[:lower:]'`

echo
if [ -e "$contato" ] ; then
	
	echo "######################"
	echo
	cat "$contato"
	echo
	echo "######################"
	echo
	read -p "Pressione <ENTER> para ir voltar para o menu."
	menu
else
	echo "######################"
	echo	
	echo "Contato não existe"
	echo
	echo "######################"
	echo
	read -p "Pressione <ENTER> para ir voltar para o menu."
	menu
fi
}

#### Encontrar contato

procurar(){
clear
echo
echo "Nome do contato que deseja encontrar: "
echo
read nome
contato=`echo "$nome" | tr '[:upper:]' '[:lower:]'` 
echo
echo "#############"
echo
if [ -e "$contato" ] ; then
	cat "$contato"
else
	echo "Contato não existe!"
fi
echo
echo "#############"
echo
read -p "Aperte a tecla <ENTER> para voltar para o menu."
menu
}


#### Editar contato

editar(){
clear
echo "Contatos existentes: "
ls
echo
echo -e "Contato que queria editar ('A' é diferente de 'a' ): "
read nome
contato=`echo "$nome" | tr '[:upper:]' '[:lower:]'`

if [ -e "$contato" ] ; then
	vim "$contato"
	menu
else	
	clear
	echo " O contato:  $contato  não existe"
	echo
	sleep 2
	
	menu
fi
}

#### Deleter contato

deletar(){
echo -e "Qual contato deseja deletar?"
read nome 
contato=`echo "$nome" | tr '[:upper:]' '[:lower:]'`

if [ -e "$contato" ] ;then
	rm "$contato"
	echo
	echo "Contato deletado!"
	sleep 2
	menu
else	
	echo 
	echo "O contato não pode ser deletado, pois não existe!"
	echo
	sleep 2
	clear
	menu
fi
}
#iniciar
contatos
menu