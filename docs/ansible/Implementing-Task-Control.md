<a name="loops"></a>
##### Loops 
###### Loop over items 
```yaml
- name: Postfix and Dovecot are running
  service:
    name: "{{ item }}"
    state: started
  loop:
    - postfix
    - dovecot
```
###### Loop over Variables
```yaml
vars:
  mail_services:
    - postfix
    - dovecot
tasks:
  - name: Postfix and Dovecot are running
    service:
      name: "{{ item }}"
      state: started
    loop: "{{ mail_service }}"

```
###### Loop over a List of Tasks
```yaml
- name: looping over a list of all linux ecs in london
  include: include.yml
  with_inventory_hostnames: london:&linux
  loop_control:
    loop_var: servername

```

###### Loop over a List of Hashes/Dictionaries
```yaml
- name: Users exist and are in the correct groups
  user:
    name: "{{ item.name }}"
    state: present
    groups: "{{ item.groups }}"
  loop:
    - name: jane
      groups: wheel
    - name: joe
      groups: root
```
<a name="conditionals"></a>
### Running Tasks conditionally:
#### Test Boolean
```yaml
- name: Simple Boolean Task Demo
  hosts: all
  vars:
    run_my_task: true

  tasks:
    - name: http package is installed
      yum:
        name: httpd
      when: run_my_task

```
#### Test Variable
```yaml
- name: Test variable is Defined Demo
  hosts: all
  vars:
    my_service: httpd

  tasks:
    - name: "{{ my_service }} package is installed"
      yum:
        name: "{{ my_service}}"
        state: present
      when: my_service is defined
```
#### The "in" keyword
```yaml
---
- name: Demonstrate the "in" keyword
  hosts: all
  vars: 
    supported_distros:
      - RedHat
      - Fedora
  tasks:
    - name: INstall httpd using yum, where supported
      yum:
        name: http
        state: present
      when: ansibel_distribution in supported_distros
```
#### Testing Multiple Conditions

AND Operation
```yaml
when:
 - ansible_distribution_version == "7.5" 
 - ansible_kernel == "3.10.1-325.el7.x86_64"

when: ansible_distribution_version == "7.5" and ansible_kernel == "3.10.1-325.el7.x86_64"
```
OR Operation
```yaml
when: ansible_distribution == "RedHat"       or ansible_distribution == "Fedora"
```
#### Grouping Conditions
```yaml
when: >
    ( ansible_distribution == "RedHat" and 
      ansible_distribution_version == "7")
    or
    ( ansible_distribution == "Fedora" and 
      ansible_distribution_version == "28")
```
#### Known Conditionals

| Operation      	                                                     | Example                     	               |
|-----------     	                                                     |-----------------------------	               |
|Equal string    	                                                     | ansible_machine == "x86 64" 	               |
|Equal numeric   	                                                     | max_memory == 542           	               |
|Less than       	                                                     | min_memory < 128            	               |
|Grater than     	                                                     | min_mamory > 128            	               |
|Less or equal to	                                                     | min_memory <= 256           	               |
|Grater or qual to                                                           | min_memory >= 256           	               |
|Not equal to    	                                                     | min_memory  != 1024	                       |
|Variable exists 	                                                     | min_memory is defined       	               |
|Variable does not exist                                                     | min_memory is not defined   	               |
|Variable is true </br> than 1/true/yes                                      | memory_available                                |
|Variabe is false                                                            | not memory_available        	               |
|First variable's </br> is present as a value in second </br> variable's list | ansible_ditribution in </br>  supported_distros|

### LOOPS and Conditions
#### Example: File System Size 

```yaml
- name: install mariadb-server if enough space on root
  yum:
    name: mariadb-server
    state: present
  loop: "{{ ansible_mounts }}"
  when: item.mount == "/" and item.size_available > 300000000
```

#### Example: Podman


```yaml

- name: Configure /etc/container/*.conf
  template:
    src: "{{ item }}.j2"
    dest: "/{{ item }}"
    owner: root
    group: root
    mode: 0644
    backup: yes
  loop:
    - etc/containers/libpod.conf
    - etc/containers/registries.conf
    - etc/containers/storage.conf
```
### Using Handlers

!!! note "Important things to remember about Handlers"
    Notify handlers are always run in the same order they are defined, not in the order listed in the notify-statement. This is also the case for handlers using listen.

    Handlers execute at the end

    Handler names and listen topics live in a global namespace.

    Handler names are templatable and listen topics are not.

    Use unique handler names. If you trigger more than one handler with the same name, the first one(s) get overwritten. Only the last one defined will run.

    You cannot notify a handler that is defined inside of an include. As of Ansible 2.1, this does work, however the include must be static.

#### How Handlers work

```yaml
    
    - name: mariadb-server packages are installed
      yum:
        name: mariadb-server
        state: present
      notify:
        - set alter password
    
    - name: Make sure that mariadb is running
      service:
        name: mariadb
        state: started
        enabled: true

    - name: The my.cnf has been installed
      get_url:
        url: https://config.cloudmonk.ch/my.cnf
        dest: /etc/my.cnf
        owner: mysql
        group: mysql
        force: true
      notify:
        - restart mariadb service
  
  handlers:
    - name: restart mariadb service
      service:
        name: mariadb
        state: restarted

    - name: set alter password
      mysql_user:
        name: john doe
        password: unknown
```

### Handling Task Failure

#### ignore_errors

```yaml
  - name: Install Adobe Photoshop® 
    yum:
      name: Adobe-Photoshop®
      state: latest
   ignore_errors: true

```

#### force_handlers

!!! note  "Default behaviour" 
    When a task failes, any handler that had been notified by earlier in the play will not run. 
!!! note "When force_handlers: true"
    Notified handlers are called even if the play aborted becouse a later task failed
```yaml
- hosts: karen-workstation
  force_handlers: true
  tasks:
    - name: Karen likes Adobe Photoshop®. So let's install GIMP instead.
      yum:
        name: gimp
        state: latest
      notify: open gimp

    - name: Install Adobe Photoshop® for Karen
      yum:
        name: Adobe-Photoshop®
        state: latest
     ignore_errors: false
```  


#### failed_when

```yaml 
  tasks:
  - name: convert karen.jpg to karen.png
    shell: convert /home/karen/karen.jpg /home/karen/karen.png
    register: command_result
    failed_when: "'unable to open image' in command_result.stdout"

```

#### changed_when

```yaml 
  tasks:
    - name: upgrade 
      shell: /usr/local/bin/upgrade
      register: command_result
      changed_when: "'Success' in command_result.stdout"
      notify:
        - restart httpd

  handlers: 
    - name: restart httpd
      service:
        name: httpd
        state: restarted
```

#### block

#### error handling

| Operation      	                                                     | Example                     	               |
|-----------     	                                                     |-----------------------------	               |
|block    	                                                     | Defines the main task 	               |
|rescue          	                                                     | Tasks to run if tasks in block clause fail.|
|always          	                                                     | Tasks that will allways run|

```yaml

- block:
    - name: update database schema on pg-prod1 
      shell:
        cmd: schema_update pg-prod1
      delegate_to: pg-prod1
  rescue:
    - name: rollback database on pg-prod1
      shell:
        cmd: rollback_database pd-prod1
  always:
    - name: check application on app_cluster
      shell:
        cmd: check_application.sh
```
