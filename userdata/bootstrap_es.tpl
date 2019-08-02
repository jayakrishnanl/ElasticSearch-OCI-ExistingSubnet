#cloud-config
timezone: "${timezone}"

output: {all: '| tee -a /var/log/cloud-init-output.log'}
  
yum_repos: 
  elasticsearch-7.x: 
    autorefresh: true
    baseurl: "https://artifacts.elastic.co/packages/7.x/yum"
    enabled: true
    gpgcheck: true
    gpgkey: "https://artifacts.elastic.co/GPG-KEY-elasticsearch"
    name: "Elasticsearch repository for 7.x packages"
    type: rpm-md

packages:
  - java
  - elasticsearch
  - kibana
  - logstash

runcmd:
  - [ /bin/rpm, --import, "https://artifacts.elastic.co/GPG-KEY-elasticsearch"]
  - [ /bin/firewall-offline-cmd, --add-port=9200/tcp ]
  - [ /bin/firewall-offline-cmd, --add-port=5601/tcp ]
  - [ /bin/systemctl, restart, firewalld ]
  - [ systemctl, daemon-reload ]
  - [ systemctl, enable, elasticsearch.service ]
  - [ systemctl, start, --no-block, elasticsearch.service ]
  - [ systemctl, enable, kibana.service ]
  - [ systemctl, start, --no-block, kibana.service ]
  - [ systemctl, enable, logstash.service ]
  - [ systemctl, start, --no-block, logstash.service ]