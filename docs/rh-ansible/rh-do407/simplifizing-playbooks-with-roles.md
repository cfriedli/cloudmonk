#### Ansible Cheat Sheet

> Originally published at [www.edureka.co](https://www.edureka.co.)

#### Create templated role folders:
```yaml
$ mkdir roles/
$ ansible-galaxy init --offline -p roles/ myvhost
$ tree roles/
```


#### Import or install new role:
```yaml
$ ansible-galaxy install --help
$ cat role2install.yml
# From a webserver, where the role is packaged in a gzipped tar archive
- src: https://webserver.example.com/files/sample.tgz
  name: ftpserver-role
$ ansible-galaxy install -r role2install.yml -p roles-dir/
```

