##### Installing Ansible (RHSM)


```yaml 

First register your system to RHSM:
$ subscription-manager register

Attach your Red Hat Ansible Engine subscription. This command will help you find the Red Hat Ansible Engine subscription:
$ subscription-manager list --available

Grab the pool id of the subscription and run the following:
$ subscription-manager attach --pool=<pool id here of engine subscription>

Enable the Red Hat Ansible Engine Repository:
$ subscription-manager repos --enable rhel-7-server-ansible-VERSION-rpms
$ subscription-manager repos --enable ansible-VERSION-for-rhel-8-x86_64-rpms

Ansible Engine 2.7 must be installed:
$ yum --showduplicates list ansible | expand | grep 2.7 | head -n1
ansible.noarch           2.7.10-1.el7ae            @rhel-7-server-ansible-2-rpms

Install Ansible Engine 2.7.10:
$ yum install ansible-2.7.10-1.el7ae

```
