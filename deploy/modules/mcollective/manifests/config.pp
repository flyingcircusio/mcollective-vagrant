class mcollective::config {
   file{"/etc/mcollective/server.cfg":
      owner => root,
      group => root,
      mode  => 0500,
      content => template("mcollective/server.cfg.erb")
   }

   file{"/etc/mcollective/client.cfg":
      owner => root,
      group => root,
      mode  => 0444,
      content => template("mcollective/client.cfg.erb")
   }

   file{"/etc/mcollective/inventory.mc":
      owner => root,
      group => root,
      mode  => 0444,
      source => "puppet:///modules/mcollective/inventory.mc"
   }

   file{"/usr/libexec/mcollective/mcollective":
      owner => root,
      group => root,
      recurse => true,
      source => "puppet:///modules/mcollective/lib"
   }

   # Old location of implemented_by scripts, symlink to new location
   file{"/usr/libexec/mcollective/agents":
      ensure => "directory",
      owner => root,
      group => root,
      mode => 755
   }
   file{"/usr/libexec/mcollective/agents/livemigration":
      ensure => "link",
      target => "/usr/libexec/mcollective/mcollective/agent/livemigration"
   }


   # Symlink mock fc-qemu to $PATH
   file{"/usr/bin/fc-qemu":
      ensure => "link",
      target => "/home/vagrant/fc.mcollective/tests/fc.qemu"
   }


   file{"/etc/mcollective/facts.yaml":
      content => inline_template("<%= Hash[scope.to_hash.reject { |k,v| k.to_s =~ /(uptime|timestamp|memory|free|swap)/ }.sort].to_yaml %>"),
      owner => root,
      group => root,
      mode => 0444,
   }

   file{"/etc/mcollective/authorized_nodes.yaml":
      content => template("mcollective/authorized_nodes.yaml"),
      owner => root,
      group => root,
      mode => 0444,
   }





}
