<a name="loops"></a>
### LOOPS:
##### Simple Loops 
List of items over the task should be iterated. 

```yaml
- name: Postfix and Dovecot are running
  service:
    name: "{{ item }}"
    state: started
  loop:
    - postfix
    - dovecot
```
via variable
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
##### Loops over a List of Hashes/Dictionaries
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
#### Grouping condidions
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
!!! note
    Install mariadb-server when:<br><br>
    -  "/" mounted <br>
    -  more than 300 MB Free<br>

```yaml
- name: install mariadb-server if enough space on root
  yum:
    name: mariadb-server
    state: present
  loop: "{{ ansible_mounts }}"
  when: item.mount == "/" and item.size_available > 300000000
```
### Using Handlers

!!! note "Important things to remember about Handlers"
    Notify handlers are always run in the same order they are defined, not in the order listed in the notify-statement. This is also the case for handlers using listen.

    Handler names and listen topics live in a global namespace.

    Handler names are templatable and listen topics are not.

    Use unique handler names. If you trigger more than one handler with the same name, the first one(s) get overwritten. Only the last one defined will run.

    You cannot notify a handler that is defined inside of an include. As of Ansible 2.1, this does work, however the include must be static.

