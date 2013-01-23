name             "openafs_build"
maintainer       "Booker C. Bense"
maintainer_email "bbense@gmail.com"
license          "MIT"
description      "Installs/Configures openafs_build"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"
recipe            "default", "Builds OpenAFS from source code"


%w{ centos debian fedora redhat scientific ubuntu  }.each do |os|
  supports os
end

# supports "mac_os_x", ">= 10.6.0"

%w{ build-essential git  }.each do |cookbook|
  depends cookbook
end
