<!-- thumbnail image wrapped in a link -->
<a href="#img1">
  <img src="../../../img/API.svg" class="thumbnail">
</a>

<!-- lightbox container hidden with CSS -->
<a href="#_" class="lightbox" id="img1">
  <img src="../../../img/API.svg">
</a>

#### Overview:

#### Questions evrey API should answer:
```yaml
    1. How can the client tell the service provider which operation it wants to perform? (Method information)
    2. How can the client tell the service prvider what data to operate on? (Scoping information)
```
#### Method information: 
```yaml
The method information should be expressed in the HTTP verb
DELETE api/users/:userId HTTP/1.1
Where :userId is the Scopint infromation
```
#### Example in Ansible using the URI module
```yaml

- name: Make requests to example api
  hosts: localhost
  connection: local
  tasks:
    - name: list employees
      uri:
        method: GET
        url: "http://dummy.restapiexample.com/api/v1/employees"
        return_content: yes
        headers:
          Accept: application/json
      register: response

    - debug:
        msg: "{{ response.content }}" 
```

#### URI (Uniform Resource Identifier)
```yaml
It's a string og characters userd to identify a resource on the internet
either by location or by name, or both.
```

##### URI Example:
```yaml
  Name:      John Doe
  Address:   7083 Columbia Street
             Woonsocket, RI 02895
```
#### URL (Uniform Resource Locator)
```yaml
It's a string of chatacters but it refers to just the address.
It's the most used way to loacte resources on the web.
```
##### URL Example
```yaml
  Address:   7083 Columbia Street
             Woonsocket, RI 02895
```
#### URN (Uniform Resource Name)
##### URN Example
```yaml
  Name:      John Doe
```

