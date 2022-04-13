# puppet_hands-on

Simple vagrant environment with puppet master server and 2 agent nodes. (CentOS 8)
Autosigning and a simple chrony NTP module is configured for automation.

- To initiate the environment run "vagrant up", master server will be initialized according to the puppetmaster.sh which will apply generic yum updates and then install puppet on the master server and then disable firewall and start/enable puppet server service. It will also install a basic NTP module (chrony due to CentOS 8 restrictions) and tr.pool.ntp.org NTP server configuration inside site.pp. puppetagent1 and puppetagent2 hostnames are added to autosign.conf for immediate certificate signing right after the agents send the certificate request.

- Puppetagent1 and Puppetagent2 which are the agent nodes will also be initiated after the master is initialized according to the puppetagent.sh. This will set up the agents, disable firewall service and then install puppet-agent service and automatically trigger an ssl bootstrap request to issue it's certificate signing from master server. NTP that was set on the master will be directly applied to the agents as it is set on the site.pp global scope on the master.
