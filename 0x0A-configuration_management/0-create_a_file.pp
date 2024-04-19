# contains manifest to create a file
# File: school

# Define a file resource to manage the creation of 'school'
    file { '/tmp/school':
    mode => '0744',
    owner => 'www-data',
    group => 'www-data',
    content => 'I love Puppet',
}