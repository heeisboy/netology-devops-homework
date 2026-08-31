[webservers]
%{ for instance in instances ~}
${instance.name} ansible_host=${instance.ip} ansible_user=${ssh_user} ansible_ssh_private_key_file=${ssh_private_key_path}
%{ endfor ~}

[webservers:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
