#!/bin/bash
declare -A groupsAndUsers=( [GRP_ADM]=carlos,maria,joao [GRP_VEN]=debora,sebastiana,roberto [GRP_SEC]=josefina,amanda,rogerio )
declare -A groupsAndFolders=( [GRP_ADM]=adm [GRP_VEN]=ven [GRP_SEC]=sec )

echo "Excluindo diretórios!"

rm -rf /publico
for group in "${!groupsAndFolders[@]}";
do
	rm -rf /${groupsAndFolders[$group]}
done

echo "Excluindo usuários!"

for group in "${!groupsAndUsers[@]}"; 
do
    for user in $(echo ${groupsAndUsers[$group]} | sed "s/,/ /g")
    do
        userdel -rf $user
    done
done

echo "Excluindo grupos de usuários!"

for group in "${!groupsAndUsers[@]}";
do
	groupdel -f $group
done

echo "Finalizando script!"
