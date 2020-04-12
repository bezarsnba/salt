install_repo_zabbix:
  cmd.run:
    - name: rpm -Uvh https://repo.zabbix.com/zabbix/4.4/rhel/7/x86_64/zabbix-release-4.4-1.el7.noarch.rpm
  
install_zbx_prx:
  pkg.installed:
    - pkgs:
      - zabbix-proxy-sqlite3
      - zabbix-agent
