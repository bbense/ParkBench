ParkBench
=========

Park Bench is where you find [Disposable Vagrants](http://tvtropes.org/pmwiki/pmwiki.php/Quotes/DisposableVagrant) for your evil schemes. The goal is to use Vagrant to create an entire mini-cell for OpenAFS testing and development.

The Current State
=========

Prerequisites: At a minimum you will need ruby, Virtualbox and git installed to use this successfully. The setup.rb script will attempt to install vagrant for you, but I recommend that you install it outside of this script. The setup.rb program was tested with the
default OS install of ruby on OS X 10.6 (1.8.7)

Currently, running setup.rb will create create a Vagrantfile that will automatically setup a VM with the
OpenAFS src and all the tools and libraries required to build it. setup.rb will examine which virtualboxes
you have installed and ask you for which you want to build OpenAFS. 

Once you've run setup.rb, you should be able to do 

vagrant up boxname

and then 

vagrant ssh boxname
cd openafs 
make 

to build OpenAFS for that OS. So far this has only been tested on the default Ubuntu 32 and 64
virtualboxes that are distributed from the Vagrant website. 

Next Steps
=========

Work on getting the configuration setup to support all the major Linux OS distributions and
perhaps adding Lumos as well. 

After that the plan is to create a Vagrantfile that will also setup a mini-cell for testing. 