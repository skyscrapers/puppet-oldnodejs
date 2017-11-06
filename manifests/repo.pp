##### LICENSE

# Copyright (c) Skyscrapers (iLibris bvba) 2014 - http://skyscrape.rs
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# == Class oldnodejs::repo
#
# This class is called from nodejs
#
class oldnodejs::repo {
  if !defined(Class['apt']) {
    class { 'apt': }
  }

  if ($oldnodejs::version == '4') {
    file { "${::lsbdistcodename}-nodejs":
      ensure => 'absent',
      path   => "/etc/apt/sources.list.d/${name}.list",
      notify => Exec['apt_update'],
    }
    apt::source { "${::lsbdistcodename}-node4":
      location => 'http://repo.int.skyscrape.rs/',
      release  => "${::lsbdistcodename}-nodesource4",
      repos    => 'main',
      key      => {
        'id'     => '4633E867BE98D6919D4866A87B3E9B1E167A0F96',
        'server' => 'hkp://keyserver.ubuntu.com:80',
      },
    }
    if ($::lsbdistcodename == 'precise'){
        apt::source { 'ubuntu-toolchain':
          location    => 'http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu/',
          release     => 'precise',
          repos       => 'main',
          key         => 'BA9EF27F',
          include_src => false,
        }
        apt::source { 'llvm-toolchain':
          location => 'http://llvm.org/apt/precise/',
          release  => 'llvm-toolchain-precise-3.4',
          repos    => 'main',
          key      => {
            'source' => 'http://llvm.org/apt/llvm-snapshot.gpg.key',
          },
        } ->
        package {
          'clang-3.4':
            ensure => latest,
        }
    }
  } elsif ($oldnodejs::version == '0.12') {
    file { "${::lsbdistcodename}-nodejs":
      ensure => 'absent',
      path   => "/etc/apt/sources.list.d/${name}.list",
      notify => Exec['apt_update'],
    }
    apt::source { "${::lsbdistcodename}-node0.12":
      location => 'https://deb.nodesource.com/node_0.12/',
      release  => $::lsbdistcodename,
      repos    => 'main',
      key      => {
        'id'     => '9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280',
        'source' => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
      },
    }
  } elsif ($oldnodejs::version == '5') {
    file { "${::lsbdistcodename}-nodejs":
      ensure => 'absent',
      path   => "/etc/apt/sources.list.d/${name}.list",
      notify => Exec['apt_update'],
    }


    package { 'apt-transport-https':
            ensure => present,
    }

    package { ' ca-certificates':
            ensure => present,
    }

    apt::source { 'nodesource':
      location          => 'https://deb.nodesource.com/node_5.x/',
      release           => $::lsbdistcodename,
      repos             => 'main',
      key               => {
        'id'     => '9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280',
        'source' => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
      },
      require => Package['apt-transport-https', 'ca-certificates'],
    }
  } elsif ($oldnodejs::version == '6') {
    file { "${::lsbdistcodename}-nodejs":
      ensure => 'absent',
      path   => "/etc/apt/sources.list.d/${name}.list",
      notify => Exec['apt_update'],
    }

    apt::source { 'nodesource':
      location          => 'https://deb.nodesource.com/node_6.x/',
      release           => $::lsbdistcodename,
      repos             => 'main',
      key               => {
        'id'     => '9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280',
        'source' => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
      },
    }
  } elsif ($oldnodejs::version == '7') {
      file { "${::lsbdistcodename}-nodejs":
        ensure => 'absent',
        path   => "/etc/apt/sources.list.d/${name}.list",
        notify => Exec['apt_update'],
      }

      apt::source { 'nodesource':
        location          => 'https://deb.nodesource.com/node_7.x/',
        release           => $::lsbdistcodename,
        repos             => 'main',
        key               => {
          'id'     => '9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280',
          'source' => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
        },
      }
    } else {
    file { "${::lsbdistcodename}-node4":
      ensure => 'absent',
      path   => "/etc/apt/sources.list.d/${name}.list",
      notify => Exec['apt_update'],
    }
    if ($oldnodejs::repo == 'test') {
      apt::source { 'precise-nodejs-test':
        location => 'http://skypackages.s3-website-eu-west-1.amazonaws.com/ubuntu/',
        release  => 'precise-nodejs-test',
        repos    => 'main',
        key      => {
          'id'     => '5D14BB9A4D883FC38BF3140C096343CA613ECD57',
          'source' => 'http://skypackages.s3-website-eu-west-1.amazonaws.com/gpg.key',
        },
      }
    } else {
      apt::source { 'precise-nodejs':
        location => 'http://skypackages.s3-website-eu-west-1.amazonaws.com/ubuntu/',
        release  => 'precise-nodejs',
        repos    => 'main',
        key      => {
          'id'     => '5D14BB9A4D883FC38BF3140C096343CA613ECD57',
          'source' => 'http://skypackages.s3-website-eu-west-1.amazonaws.com/gpg.key',
        },
      }
    }
  }
}
