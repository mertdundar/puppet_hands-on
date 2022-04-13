# puppet_hands-on

Simple vagrant environment with puppet master server and a single agent node. (CentOS 8)
Autosigning and a simple chrony NTP module is configured for automation.

- To initiate the environment run "vagrant up", master server will be initialized according to the puppetmaster.sh which will apply generic yum updates and then install puppet on the master server and then disable firewall and start/enable puppet server service. It will also install a basic NTP module (chrony due to CentOS 8 restrictions) and tr.pool.ntp.org NTP server configuration inside site.pp. puppetagent hostname is added to autosign.conf for immediate certificate signing right after the agent sends the certificate request.

- Puppetagent which is the agent node will also be initiated after the master is initialized according to the puppetagent.sh. This will set up the agent, disable firewall service and then install puppet-agent service and automatically trigger an ssl bootstrap request to issue it's certificate signing from master server. NTP that was set on the master will be directly applied to the agent as it is set on the site.pp global scope on the master.
