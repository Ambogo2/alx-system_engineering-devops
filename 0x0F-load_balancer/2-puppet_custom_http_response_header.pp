# Update package information
exec { 'apt-update':
  command => '/usr/bin/apt-get -y update',
  path    => ['/usr/bin', '/bin'],
  unless  => '/usr/bin/test -f /var/lib/apt/periodic/update-success-stamp',
}

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Create a basic HTML file
file { '/var/www/html/index.html':
  content => 'Hello World!',
  ensure  => file,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
}

# Configure Nginx to add the custom HTTP header
file_line { 'add custom header':
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  line   => "\tadd_header X-Served-By \$hostname;",
  after  => 'server_name _;',
  notify => Service['nginx'],
}

# Ensure Nginx is running
service { 'nginx':
  ensure     => running,
  enable     => true,
  subscribe  => Package['nginx'],
}