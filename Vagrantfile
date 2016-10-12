#-*- mode: ruby -*-
 #vi: set ft=ruby :

 # Starting configuration
 Vagrant.configure("2") do |config|

   # Setting up the Shared folder
  config.vm.synced_folder "shared", "/tmp/shared" 
  
	config.vm.define "master" do |master|
  
 		# Configuring Hostname
		master.vm.hostname= "JeevesMaster.qac.local"
  
		# Selecting the box to use
		master.vm.box = "chad-thompson/ubuntu-trusty64-gui"
	
		# Setting up the network options
		#master.vm.network :public_network, :public_network=> "wlan0",ip:"192.168.1.80"
		master.vm.network "public_network", bridge: "Intel(R) Ethernet Connection I217-LM"
		
		# Calling the provision bash file
		master.vm.provision:shell,path:"bootstrap_master.sh"
		
		# Configuring vm provider options
		master.vm.provider "virtualbox" do |masterVM|
  
			# Showing the vm GUI and setting its name
			masterVM.gui = true
			masterVM.name="JeevesMasterVM"
   
			# Setting the amount of RAM the VM has access to
			masterVM.memory = "4096"
			masterVM.cpus = "2"
		end
	end
    
	
	
	config.vm.define "agent1" do |agent|
	
	 	# Configuring Hostname
		agent.vm.hostname= "JeevesAgent1.qac.local"
  
		# Selecting the box to use
		agent.vm.box = "chad-thompson/ubuntu-trusty64-gui"
	
		# Setting up the network options
		#agent.vm.network :public_network, :public_network=> "wlan0",ip:"192.168.1.26"
		agent.vm.network "public_network", bridge: "Intel(R) Ethernet Connection I217-LM"
		
		# Calling the provision bash file
		agent.vm.provision:shell,path:"bootstrap_agent.sh"
		
		# Configuring vm provider options
		agent.vm.provider "virtualbox" do |agentVM|
  
			# Showing the vm GUI and setting its name
			agentVM.gui = true
			agentVM.name="JeevesAgent1"
   
			# Setting the amount of RAM the VM has access to
			agentVM.memory = "4096"
			agentVM.cpus = "2"
		end
	end
	
		config.vm.define "agent2" do |agent|
	
	 	# Configuring Hostname
		agent.vm.hostname= "JeevesAgent2.qac.local"
  
		# Selecting the box to use
		agent.vm.box = "chad-thompson/ubuntu-trusty64-gui"
	
		# Setting up the network options
		#agent.vm.network :public_network, :public_network=> "wlan0",ip:"192.168.1.27"
		agent.vm.network "public_network", bridge: "Intel(R) Ethernet Connection I217-LM"
		
		# Calling the provision bash file
		agent.vm.provision:shell,path:"bootstrap_agent.sh"
		
		# Configuring vm provider options
		agent.vm.provider "virtualbox" do |agentVM|
  
			# Showing the vm GUI and setting its name
			agentVM.gui = true
			agentVM.name="JeevesAgent2"
   
			# Setting the amount of RAM the VM has access to
			agentVM.memory = "4096"
			agentVM.cpus = "2"
		end
	end
	
		config.vm.define "agent3" do |agent|
	
	 	# Configuring Hostname
		agent.vm.hostname= "JeevesAgent3.qac.local"
  
		# Selecting the box to use
		agent.vm.box = "chad-thompson/ubuntu-trusty64-gui"
	
		# Setting up the network options
		#agent.vm.network :public_network, :public_network=> "wlan0",ip:"192.168.1.28"
		agent.vm.network "public_network", bridge: "Intel(R) Ethernet Connection I217-LM"
		
		# Calling the provision bash file
		agent.vm.provision:shell,path:"bootstrap_agent.sh"
		
		# Configuring vm provider options
		agent.vm.provider "virtualbox" do |agentVM|
  
			# Showing the vm GUI and setting its name
			agentVM.gui = true
			agentVM.name="JeevesAgent3"
   
			# Setting the amount of RAM the VM has access to
			agentVM.memory = "4096"
			agentVM.cpus = "2"
		end
	end
	
		config.vm.define "agent4" do |agent|
	
	 	# Configuring Hostname
		agent.vm.hostname= "JeevesAgent4.qac.local"
  
		# Selecting the box to use
		agent.vm.box = "chad-thompson/ubuntu-trusty64-gui"
	
		# Setting up the network options
		#agent.vm.network :public_network, :public_network=> "wlan0",ip:"192.168.1.72"
		agent.vm.network "public_network", bridge: "Intel(R) Ethernet Connection I217-LM"
		
		# Calling the provision bash file
		agent.vm.provision:shell,path:"bootstrap_agent.sh"
		
		# Configuring vm provider options
		agent.vm.provider "virtualbox" do |agentVM|
  
			# Showing the vm GUI and setting its name
			agentVM.gui = true
			agentVM.name="JeevesAgent4"
   
			# Setting the amount of RAM the VM has access to
			agentVM.memory = "4096"
			agentVM.cpus = "2"
		end
	end

	# config.vm.define "mastertest" do |master|
  
 		# # Configuring Hostname
		# master.vm.hostname= "JeevesMasterTest.qac.local"
  
		# # Selecting the box to use
		# master.vm.box = "chad-thompson/ubuntu-trusty64-gui"
	
		# # Setting up the network options
		# master.vm.network :public_network, :public_network=> "wlan0",ip:"192.168.1.74"
		
		# # Calling the provision bash file
		# master.vm.provision:shell,path:"bootstrap_master.sh"
		
		# # Configuring vm provider options
		# master.vm.provider "virtualbox" do |masterVM|
  
			# # Showing the vm GUI and setting its name
			# masterVM.gui = true
			# masterVM.name="JeevesMasterTestVM"
   
			# # Setting the amount of RAM the VM has access to
			# masterVM.memory = "4096"
			# masterVM.cpus = "2"
		# end
	# end
	
	# config.vm.define "agenttest" do |agent|
	
	 	# # Configuring Hostname
		# agent.vm.hostname= "JeevesAgentTest.qac.local"
  
		# # Selecting the box to use
		# agent.vm.box = "chad-thompson/ubuntu-trusty64-gui"
	
		# # Setting up the network options
		# agent.vm.network :public_network, :public_network=> "wlan0",ip:"192.168.1.75"
		
		# # Calling the provision bash file
		# agent.vm.provision:shell,path:"bootstrap_agent.sh"
		
		# # Configuring vm provider options
		# agent.vm.provider "virtualbox" do |agentVM|
  
			# # Showing the vm GUI and setting its name
			# agentVM.gui = true
			# agentVM.name="JeevesAgentTest"
   
			# # Setting the amount of RAM the VM has access to
			# agentVM.memory = "4096"
			# agentVM.cpus = "2"
		# end
	# end
end