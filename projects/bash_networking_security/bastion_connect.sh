    #!/bin/bash


if [[ -z "${KEY_PATH}" ]]; then
  echo "KEY_PATH env var is expected"
  exit 5
fi

if [[ -z "${1}" ]]; then
  echo "Please provide bastion IP address"
  exit 5
fi

bastion_ip="${1}"
private_ip="${2}"
command="${3}"


if [[ -n "${private_ip}" ]]; then
  ssh -i "${KEY_PATH}" -o ProxyCommand="ssh -i ${KEY_PATH} -W %h:%p ubuntu@${bastion_ip}" ubuntu@${private_ip}
  exit $?
fi

ssh -i "${KEY_PATH}" ubuntu@"${bastion_ip}"
exit $?

if [[ -n "${private_ip}" && -n "${command}" ]]; then
  ssh -i "${KEY_PATH}" ubuntu@"${bastion_ip}" -t "ssh -i ${KEY_PATH} ubuntu@${private_ip} ${command}"
  exit $?
fi

echo "Please provide valid arguments"
exit 5
    
