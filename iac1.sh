#!/bin/bash
declare -A groupsAndUsers=( [GRP_ADM]=carlos,maria,joao [GRP_VEN]=debora,sebastiana,roberto [GRP_SEC]=josefina,amanda,rogerio )
declare -A groupsAndFolders=( [GRP_ADM]=adm [GRP_VEN]=ven [GRP_SEC]=sec )

echo "Criando diretórios!"

mkdir /publico
for group in "${!groupsAndFolders[@]}";
do
	mkdir /${groupsAndFolders[$group]}
done

echo "Criando grupos de usuários!"

for group in "${!groupsAndUsers[@]}";
do
	groupadd $group
done

echo "Criando usuários!"

for group in "${!groupsAndUsers[@]}"; 
do
    for user in $(echo ${groupsAndUsers[$group]} | sed "s/,/ /g")
    do
        useradd $user -m -s /bin/bash -p $(openssl passwd Senha123) -G $group
    done
done

echo "Especificando permissões!"

chmod 777 /publico
for group in "${!groupsAndFolders[@]}";
do
	chown -R root:$group /${groupsAndFolders[$group]}
	chmod 770 /${groupsAndFolders[$group]}
done

echo "Finalizando script!"
