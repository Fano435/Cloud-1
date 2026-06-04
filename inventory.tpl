[servers]
%{ for i, ip in ips ~}
wordpress-prod-${i} ansible_host=${ip}
%{ endfor ~}

[servers:vars]
ansible_user=${user}
ansible_ssh_private_key_file=~/.ssh/gcp_key
ansible_ssh_common_args='-o StrictHostKeyChecking=no'