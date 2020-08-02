#### 
!!! error "All Facts relatet to System Memory Size are in MiB (1 GiB = 1024 MB)"
    ansible_memory_mb  

    ansible_memfree_mb

    ansible_memtotal_mb

    ansible_swapfree_mb

    ansible_swaptotal_mb


#### Scope
```
Global scope: CLI and ansible.cfg

Play scope: In play and related structures

Host scope: By the inventory, fact gathering, registred tasks. 

```
#### Variables in playbooks
```yaml
# When a variable is used as the first element to start a value, quotes are mandatory
# This prevents Ansible from interpreting the variable reference as starting a YAML
# dictionary.

yum:
  name: "{{ name }}"
  state: present
```
#### Presedence

!!! note
    Host variables take precedence over group variables, but variables defined by a playbook
    take precedence over both.

##### Example:

| Presedence                           | Name                                  | Value         |
| -------------                        |:-------------                        | -----:        |
| Variable defined in a <br> Playbook       | http_server=lighttpd                  | lighttpd      |
| Host Variable                        | http_server=httpd                     | httpd         |
| Group Variable                       | http_server=nginx                     | nginx         |

#### group_vars and host_vars

| Name                                 | Description                           |  File Name                |
| -------------                        |:-------------:                        |  -----:                   |
| group_vars                           | Contains hostgroup variables          |  Name of the hostgroup    |
| host_vars                            | Contains host variables               |  Name of the host         |

<a name="vault"></a>
### Ansible Vault
#### Creating an Encrypted File
```
ansible-vault create secret.yml
ansible-vault create --vault-password-file=vault-pass secret.yml
```
#### Viewing an Encrypted File
```
ansible-vault view secret1.yml
```
#### Editing an Existing File
```
ansible-vault edit secret.yml
```

#### Encrypting an Existing File
```
ansible-vault encrypt secret.yml secret2.yml
ansible-vault encrypt plain-text.yml --output=secret.yml 
```
#### Decrypting an Existing File
```
ansible-vault decrypt secret.yml --output=plain-text.yml
```
### Changing Password of an Encrypted File
```
ansible-vault rekey secret.yml
ansible-vault rekey --new-vault-password-file=NEW_VAULT_PASSWORD_FILE secret
```
#### Access encrypted files running a Playbook
```
ansible-playbook --vault-id @prompt site.yml
ansible-playbook --vault-id one@prompt --vault-id two@prompt site.yml
ansible-playbook --vault-password-file=vault-pw-file site.yml
export ANSIBLE_VAULT_PASSWORD=vault-pw-file
```
#### Recomended Prectices for Variable File Management
```
|--- ansible.cfg
|--- group_vars
|    |-- webservers
|        |vars
|
|--- host_vars
|    |-demo.example.com
|      |- vars
|      |- vault
|
|--inventory
|-- playbook.yml
```

#### Naming Varables
Inside a Role
```
rolename_varname_description
  sssd-win_sssd_pkg
  sssd-win_sssd_service
  sssd-win_sssd_service_state
```
Inside a Playbook
```yaml
varname_description
  sssd_pkg
  sssd_svc
  sssd_svc_state
```

#### Ansible facts injected as variables
| Ansible_Facts                                                          | Description                           | 
| -------------                                                          | -------------                         | 
| ansibele_facts['hostname']                                             | Hostname                              | 
| ansibele_facts['fqdn']                                                 | Fully Qualified Domain Name           | 
| ansibele_facts['default_ipv4']['address']                              | Default IPV4 Address.(Default route)  | 

#### Speed up encryption
```
sudo yum install python-cryptography
```
#### Example host and group variables in the inventory file

```
admin@station project]$ cat -/project/inventory
[datacenter1]
demo.exanple.com 
demo2.exanple.com

[datacenter2]
demo3.example.com ansible_user=hans
demo4.example.com

[datacenters:children]
datacenterl
datacenter2

[datacenters:vars]
package=httpd

[datacenter2:vars]
package=nginx
```
#### Example group_vars
```
admin@station project]$ cat -/project/group_vars/datacenters1
package: httpd


admin@station project]$ cat -/project/group_vars/datacenters2
package: nginx
```
#### Example host_vars
```
admin@station project]$ cat -/project/host_vars/demo1.example.com
package: lighttpd
```
### Example variables in playbooks
```yaml
admin@station project]$ cat -/project/site.pp
- name: var example
  hosts: demo1.example.com
  vars:
    package: tomecat
  tasks:

   - name: install http server
     yum:
       name: "{{ package }}"
       state: present

```

### Define playbook variables in external files.
```yaml
admin@station project]$ cat -/project/site.pp
- name: var file example
  hosts: demo1.example.com
  vars_files: vars/package.yml
  tasks:
   - name: install http server
     yum:
       name: "{{ package }}"
       state: present
```
```yaml
admin@station project]$ cat -/project/vars/package.yml
package: tomcat
```
