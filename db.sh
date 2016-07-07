#!/bin/bash
set -e
name=db-${USER}-wp
cloud_init_file="db.yaml"
grep -q EDITAR_USUARIO ${cloud_init_file} && { echo "ERROR: tenes que editar EDITAR_USUARIO con tu nombre en ${cloud_init_file}" ; exit 1; }
# OJO: la receta de WP falla en xenial, usar trusty
image=$(nova image-list | awk '/trusty.*disk1.img/{ print $4 }')
flavor=m1.small
net_id=$(nova net-list | awk '/net_umstack/{ print $2 }')
set -x
nova boot --image ${image} --nic net-id="${net_id}" --flavor ${flavor} --user-data ${cloud_init_file} "$@" ${name}
