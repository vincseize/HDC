#!/bin/bash
# Script pour l'installation de l'OS Headcam de Thirdeye




###########
#
#  Fonction contenant l'installation de l'OS Headcam 
#
#
###########

install_headcam(){

	diskheadcam=$1

	read -p "Appuyez sur [ENTER] pour lancer l'install " waitcontinue

	###########
	# Partitionnement du disk
	###########

	echo -e "\n##   Partionnement du disk   ##"

	parted -s /dev/${diskheadcam} mklabel msdos
	# Partition /var/log de 2Go
	parted -s /dev/${diskheadcam} unit GB mkpart primary ext4 0 2 
	# Partition root avec le reste du disque
	parted -s /dev/${diskheadcam} -- unit GB mkpart primary ext4 2 -1
	# La partition root contient /boot
	parted /dev/${diskheadcam} set 2 boot on


	read -p "Partitionnement fini. Appuyez sur [ENTER] pour continuer " waitcontinue


	###########
	# Formatge des partitions
	###########
	echo -e "\n##   Formatage des partitions   ##"

	mkfs.ext4 /dev/${diskheadcam}1 
	mkfs.ext4 /dev/${diskheadcam}2 


	read -p "Formatage fait. Appuyez sur [ENTER] pour continuer" waitcontinue


	###########
	# Montage pour la copie de l'OS
	###########
	echo -e "\n##   Point de montage temporaire pour l'installation   ##"

	mount /dev/${diskheadcam}2 disk-install
	mkdir -p disk-install/var/log
	mount /dev/${diskheadcam}1 disk-install/var/log


	read -p "Montage fait. Appuyez sur [ENTER] pour continuer" waitcontinue



	###########
	# Untar de l'OS
	###########
	echo -e "\n##   Installation de l'OS   ##"
	tar xvpf os-headcam.tar -C disk-install
	cp -rv dynamixyz/* disk-install/opt/dynamixyz


	read -p "Installation de l'OS fait. Appuyez sur [ENTER] pour continuer" waitcontinue


	###########
	# Point de montage & chroot pour grub
	###########
	mount -t proc proc disk-install/proc
	mount --rbind /sys disk-install/sys
	mount --rbind /dev disk-install/dev


	###########
	# Installation du bootloader grub2
	###########
	echo -e "\n##   Installation du bootloader   ##"
	chroot disk-install grub2-install /dev/${diskheadcam}
	chroot disk-install grub2-mkconfig -o /boot/grub/grub.cfg
	 #on est en chroot

	read -p "Installation du bootloader fini. Appuyez sur [ENTER] pour continuer" waitcontinue



	###########
	# Demontage des disques
	###########
	umount disk-install/var/log
	umount -l disk-install/dev{/shm,/pts,}
	umount -l disk-install{/sys,/proc}
	umount disk-install


	echo -e "\n#                                     #"
	echo -e "\n#                                     #"
	echo -e "\n#                                     #"
	echo -e "\n#                                     #"
	echo -e "\n#       Installation terminee         #"
	echo -e "\n#   Vous pouvez recuperer le disque   #"
	echo -e "\n#                                     #"
	echo -e "\n#                                     #"



} #install_headcam(){




#set -x

echo -e "\n\n###   Script d'installation de l'OS pour Headcam   ###\n"

echo -e "\n\n# Liste des disques   #\n"
fdisk -l


echo -e "\n\n# choix du disque   #\n"
###########
# Choix du disque 
###########
read -p "Lettre Disque SSD " diskheadcam

echo "Voici la table de partition de /dev/${diskheadcam}"

fdisk -l /dev/${diskheadcam}

echo ""

echo "Lancer l'installation sur le disque /dev/${diskheadcam} ? [Yes/No]"
select confirm in "Yes" "No"; do
case "${confirm}" in
	Yes ) 
		echo "Lancement de l'installation";
		install_headcam ${diskheadcam}
		break
		;;
	No ) 
		echo "Annulation"; 
		exit
		;; 
	* ) 
		echo "1 pour Yes / 2 pour No"
		;;
esac
done









echo -e "\n\n###   Fin du script d'installation de l'OS pour Headcam   ###"


read -p "Fin de l'installation. Appuyez sur [ENTER] pour terminer" waitcontinue
###########
# Fin du script
###########
