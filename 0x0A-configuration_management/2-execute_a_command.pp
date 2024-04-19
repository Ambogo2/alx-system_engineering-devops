# contains manifest  that kills a process

    exec { 'killing a process killmenow':
        command  => 'pkill',
        path     => 'bin: /usr/bin',
        onlyif   => 'pgrep killmenow'
        provider => 'shell'
}
