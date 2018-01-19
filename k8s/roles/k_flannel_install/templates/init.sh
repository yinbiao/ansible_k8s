#!/bin/bash
#

#mk-docker-opts.sh --help
#Generate Docker daemon options based on flannel env file
#OPTIONS:
#        -f      Path to flannel env file. Defaults to /run/flannel/subnet.env
#        -d      Path to Docker env file to write to. Defaults to /run/docker_opts.env
#        -i      Output each Docker option as individual var. e.g. DOCKER_OPT_MTU=1500
#        -c      Output combined Docker options into DOCKER_OPTS var
#        -k      Set the combined options key to this value (default DOCKER_OPTS=)
#        -m      Do not output --ip-masq (useful for older Docker version)

source /run/flannel/subnet.env
/opt/mk-docker-opts.sh -i
/opt/mk-docker-opts.sh -c

#添加cluster路由
ip route add {{ KUBE_FLANNEL_GW }} dev docker0