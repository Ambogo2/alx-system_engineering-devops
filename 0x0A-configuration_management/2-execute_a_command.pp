# contains manifest  that kills a process

    exec { 'killmenow':
        command  => 'pkill killmenow',
        path     => 'bin: /usr/bin',
        onlyif   => 'pgrep killmenow'
        provider => 'shell'
}
