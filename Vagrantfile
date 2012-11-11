# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

Vagrant::Config.run do |config|
 
  # Read in the boxfile
  # For now it's just a hash
  boxes = YAML.load_file( 'boxConfig.yaml' )
  
  boxes.each_key do |key|

    config.vm.define key.to_sym do |key_config|
   
      key_config.vm.box = key

      # Enable provisioning with chef solo, specifying a cookbooks path, roles
      # path, and data_bags path (all relative to this Vagrantfile), and adding 
      # some recipes and/or roles.
      #
      # key_config.vm.provision :chef_solo do |chef|
      #   chef.cookbooks_path = "./chef/cookbooks"
      #   chef.roles_path = "./chef/roles"
      #   chef.data_bags_path = "./chef/data_bags"
      #   chef.add_recipe "openafs"
      #   chef.add_role boxes[key]
      #   #
      #   #   # You may also specify custom JSON attributes:
      #   #   chef.json = { :mysql_password => "foo" }
      # end
  end
  # Build OpenAFS 
  end

 
end
