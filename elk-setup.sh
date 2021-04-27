
#!/bin/bash
NAME=$2
NS=log
CHART=elastic/${NAME}
VERSION=v7.6.1
VALUES=${NAME}/values.yaml
RELEASE=$(helm ls | awk '{print $1}' | grep ${NAME})

display_usage() {
	echo -e "\nThis script must be run with 2 parameters"
	echo -e "\nUsage:\n$0 [install|update] [elasticsearch|kibana|metricbeat]"
	echo -e "\n Example:\n$0 install kibana \n"
	}

if [[  $# -le 1 ||  $# == "-h" ]]
then
  display_usage
  exit 1
fi


case $1 in
install)
		helm install  ${NAME} ${CHART} --namespace agrippa -f ${VALUES} --version ${VERSION} 
		#helm install --debug --dry-run --name ${NAME} --namespace ${NS} -f ${NAME}.yaml ${CHART} > ${NAME}-debug.yaml
		echo "Installed ${NAME}"
		;;
update)
		helm upgrade ${RELEASE} ${CHART} --namespace ${NS} -f ${VALUES} --version ${VERSION}
		echo "Updated ${NAME}"
		;;
*)
		display_usage
		;;
esac