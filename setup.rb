#!/usr/bin/env ruby 

# This could be a shell script, but since you need to have ruby to run vagrant
# I'll just hack away.

require 'yaml'

class Configurinator
  def initialize
    @path = ENV['PATH'].split(":")
    @boxes = Hash.new 
  end
      
  def find_bin(bin)
    @path.each do |head|
      fpath = "#{head}/#{bin}"
      return true if ( File.executable?(fpath))
    end
    return nil
  end
    
  def get_answer(question,valid_answers)
    not_valid = true
    answer = false 
    while( not_valid ) do
      print question
      guess = gets.chomp.downcase
      answer = valid_answers.find do |x|
        x == guess 
      end 
      not_valid = false if answer 
    end
    return answer
  end
  
  def yesno(question)
    answer = self.get_answer(question,['y','n','yes','no'])
    if answer =~ /^y/ 
      return true
    else 
      return false
    end
  end
  
  # This should end up as being some kind of struct
  def add_box (box)
    @boxes[box] = "build" 
  end 
  
  # Use yaml config for now. 
  def write_box(boxfile)
    f = File.new(boxfile,"w")
    f.write(@boxes.to_yaml)
    f.close
  end 

end

# First check if vagrant is installed. If not offer to run a gem install vagrant
#

#yesno = ['y','n','yes','no']
salutation = 'Curse you Perry the Platypus!'

finder = Configurinator.new 

if finder.find_bin('vagrant').nil? then
  if ( File.directory?('/Applications') ) then
    print "On OS/X you should probably install the Vagrant via disk image download.\n"
  end 
  install = finder.yesno("Cannot find vagrant in your PATH. Do you want me to try gem install vagrant? [y/n] ")
  if ( install ) then
    if ( finder.find_bin('gem')) then
      system("gem install vagrant")
    else
      print "Cannot find gem in your PATH, #{salutation}\n"
      exit
    end
  else
    print "#{salutation}, come back when you've got vagrant installed.\nhttp://vagrantup.com/\n"
    exit
  end
end

# Is git available? 
unless ( finder.find_bin('git')) 
  print "#{salutation}, cannot find git in your PATH, Try \nhttp://git-scm.com/downloads\n"
  exit
end

# Then find out what boxes are available. 
# It would be cool do it this way, but on OS/X at least
# we are in ruby version hell. 
#require 'rubygems'
#require 'vagrant'
#env = Vagrant::Environment.new
boxes = `vagrant box list`.split(/\n/) 
while boxes.empty? do 
  get_box = finder.yesno("You don't have any boxes installed.\nDo you want to download an example Ubuntu Lucid box?[y/n] ")
  if ( get_box ) then
    cmd = "vagrant box add http://files.vagrantup.com/lucid32.box"
    print "#{cmd}\n"
    system('cmd')
  else
    print "#{salutation}, you can find some example boxes here:\nhttps://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Boxes\n"
    exit
  end
  boxes = `vagrant box list`.split(/\n/) 
end

# Write boxconfig for VagrantFile to slurp in. 
boxes.each do |box|
    question = "Build OpenAFS on #{box}? [y/n] "
    if ( finder.yesno(question) )
      finder.add_box(box) 
    end
end 

finder.write_box("boxConfig.yaml")

# Is there src in openafs? git clone if not. 
unless File.exists?("./openafs/configure")
  get_openafs = finder.yesno("You don't appear to have OpenAFS code in ./openafs.\nDo you want to git clone from master?[y/n] ")
  if (get_openafs) 
    cmd =  "git clone git://git.openafs.org/openafs.git"
    system cmd
  else
    print "#{salutation}, you need to install the OpenAFS source tree in ./openafs ."
    exit
  end
end

# Skip these questions for now. 
# Do they want to use /vagrant on the VM to build or the local file system? 

# Hiemdal or MIT kerberos? 

print "At last the Configurinator is ready, vagrant up will build OpenAFS on all the boxes you selected.\n"