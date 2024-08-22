# Fix issue with a high number of open files by increasing the file descriptor limit

# Modify the 'nofile' limit in the /etc/security/limits.conf file (first replacement)
exec { 'increase-nofile-limit-1':
  provider => shell,
  command  => 'sudo sed -i "s/nofile 5/nofile 50000/" /etc/security/limits.conf',
  before   => Exec['increase-nofile-limit-2'],
}

# Modify the 'nofile' limit in the /etc/security/limits.conf file (second replacement)
exec { 'increase-nofile-limit-2':
  provider => shell,
  command  => 'sudo sed -i "s/nofile 4/nofile 40000/" /etc/security/limits.conf',
}
