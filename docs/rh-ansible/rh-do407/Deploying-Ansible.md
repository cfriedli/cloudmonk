### Commands:
```bash
$ ansible-doc -l, --list  # List available modules
$ ansible infra --list-hosts
$ ansible-doc __stat__   # ansible-doc [options] [__module name__]
$ ansible serverb.lab.example.com -m setup -a "filter=ansible_mem*"
```
### Inventory 
```
ansible washingtonl.exanple.com --list-hosts
```

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

!!! tip "SUMMARY"
    The system where Ansible is installed is called a controll node.
    
    Managed hosts are defined in the inyenfory.     

    Inventories can be static files or dynamically     

    The location of the inventory is controlled by the Ansible configuration.

    The first configuration file found is used; all others are ignored.

    The ansible command is used to perform ad hoc commands on managed hosts.

    Ad hoc commands determine there actions through the use of modules and their arguments.
    
    Ad hoc commands can escalate there permissions through the Ansible's privilege escalation features

