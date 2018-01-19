#!/bin/bash

install_log="{{ TMP }}/{{ install_log }}"

function log(){
    echo $1 >> $install_log
}

function checkinstall(){
    if [[ -d /usr/local/jdk ]]; then
        echo "/usr/local/jdk exist"
        exit 1
    fi
    if [[ -n $JAVA_HOME ]]; then
    	echo "find jdk : $JAVA_HOME"
    	exit 1
    fi
}

function jdkinstall(){
	cd {{ TMP }}
	jdk_name=`tar -tf $jdk_file |head -n 1 |cut -d "/" -f1`
	tar -zxf {{ TMP }}/$jdk_file -C /usr/local/
	log "install jdk ok !"
}

main(){
	> $install_log
    jdk_file=$1
    jdkinstall
}

main $@