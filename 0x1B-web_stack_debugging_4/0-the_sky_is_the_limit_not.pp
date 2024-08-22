# Increase the number of open file descriptors Nginx can handle

# Modify the ULIMIT value in the Nginx default configuration file
exec { 'increase-ulimit-for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => '/usr/local/bin/:/bin',
}

# Restart Nginx to apply changes
exec { 'restart-nginx':
  command => '/etc/init.d/nginx restart',
  path    => '/sbin:/bin:/usr/sbin:/usr/bin',
}
