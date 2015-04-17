name             'a4tp'
maintainer       'Shayne Clausson'
maintainer_email 'sclausson@hotmail.com'
license          'all_rights'
description      'Installs/Configures Automation for the People website'
long_description 'Installs/Configures Automation for the People website for Stelligent mini-project'
version          '0.2.0'

=begin
change log
----------
v 0.2.0 - template file method replaced by a remote_file resource which grabs index.html from Github repo - This seems like a more natrual/realistic workflow
v 0.1.0 - initial commit - cookbook uses a template file resource to create /var/www/html/index.html on node
=end

