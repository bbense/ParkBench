#
# Cookbook Name:: openafs_build
# Recipe:: default
#
# Copyright (C) 2012 Booker C. Bense
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# On ubuntu lucid the following packages were required
# libtool, automake, linux-headers-$(uname -r), libgssapi2-heimdal, 
# heimdal-clients, heimdal-dev, heimdal-kdc, heimdal-servers
# flex, byacc, libncurses5-dev 

prereq = Array.new

case node[:platform]
  # when "centos","redhat","fedora","suse"
    
  when "debian","ubuntu"
  	include_recipe "apt"
    prereq = %w[ build-essential libtool automake flex byacc heimdal-dev git-core ]
    prereq << "linux-headers-" + `uname -r`.chomp
end

prereq.each do |pkg|

	package pkg do
  		action :install
	end

end