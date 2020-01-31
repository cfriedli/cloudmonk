#### ansible-playbook

| Option                | Description                     | 
|-----------            | ----------                      |
| ansible-playbook -v   | The task results                |
| ansible-playbook -vv  | Task results, task confiuration |
| ansible-playbook -vvv | connections to managed hosts    | 
| ansible-playbook -vvvv| User, scripts been executed     |  
| ansible-playbook --syntax-check | Check syntax     |  
| ansible-playbook -C | dry run|

#### ansible-doc
| Option                | Description                     | 
|                       |                                 |
| ansible-doc -l        | list of modules available       |
| ansible-doc module       | print module documentation        |
| ansible-doc -s module       | print example output |

#### YAML Strings
```
this is a string
'this is another string'
"thias is antother string"
```
```
include_newlines: |
        Example company
        123 Hain Street
        Atlanta,
        GA 30303
```
```
fold_newlines: >
     This is
     a very long
     sentence.
```

#### YAML Dictionaries
```
name: svcrole
svcservice: httpd
svcport: 80
```

#### YAML Lists
```
hosts:
  - servera
  - serverb
  - serverc
  - serverd
```
#### vimrc
```bash
autocmd FIleType yaml setlocal ai ts=2 sw=2 et
```

