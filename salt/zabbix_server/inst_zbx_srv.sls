install_repo_zabbix:
  cmd.run:
    - name: rpm -Uvh https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-release-4.4-1.el7.noarch.rpm
  
install_zbx_server:
  pkg.installed:
    - pkgs:
      - zabbix-server-mysql 
      - zabbix-web-mysql
      - zabbix-agent

install_mariadb_repo:
  pkgrepo.managed:
    - name: mariadb
    - human name: MariaDB
    - baseurl:  http://yum.mariadb.org/10.4/centos7-amd64
    - gpgkey: https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
    - gpgcheck: 1

install_mariadb:
  pkg.installed:
    - pkgs:
      - MariaDB-server
      - MariaDB-client
      - MySQL-python
      - policycoreutils-python 
      - selinux-policy-targeted
      - policycoreutils


  service.running:
    - enable: True

## Disable Selinux
selinux_disabled:
  selinux.mode:
    - name: disabled


check_db:
  test.configurable_test_state:
    - name: Is there any tables in 'zabbix' database?
    - changes: True
    - result: True
    - comment: If changes is 'True' data import required.


zabbix_create_db:
  mysql_database.present: 
    - name: zabbix
    - character_set: utf8
    - collate: utf8_bin

  mysql_user.present:
    - name: zabbix
    - host: localhost
    - password: "zabbix"
    - saltenv:
      - LC_ALL: "en_US.utf8"

  mysql_grants.present:
    - grant: all privileges
    - database: zabbix.*
    - user: zabbix
    - host: 'localhost'

copy_file_zbx:
  file.managed:
    - source: salt://zabbix_server/files/zabbix_server.conf
    - name: /etc/zabbix/zabbix_server.conf
    - user: zabbix
    - group: zabbix

execute_gunzip:
  cmd.run:
    - name: gunzip /usr/share/doc/zabbix-server-mysql-4.4.7/create.sql.gz

export_zbx_database:
  mysql_query.run_file:
    - database: zabbix
    - connection_charset: utf8
    - query_file: /usr/share/doc/zabbix-server-mysql-4.4.7/create.sql
    - onchanges:
      - test: check_db

httpd:
  service.running:
    - enable: True




zabbix-server:
  service.running:
    - enable: True




