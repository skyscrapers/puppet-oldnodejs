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

# == Class nodejs::repo
#
# This class is called from nodejs
#
class nodejs::repo {
  if !defined(Class['apt']) {
    class { 'apt': }
  }

  if ($nodejs::version == '4') {
    file { "${::lsbdistcodename}-nodejs":
      ensure => 'absent',
      path   => "/etc/apt/sources.list.d/${name}.list",
      notify => Exec['apt_update'],
    }
    apt::source { "${::lsbdistcodename}-node4":
      location    => 'http://repo.int.skyscrape.rs/',
      release     => "${::lsbdistcodename}-nodesource4",
      repos       => 'main',
      key         => '0407B13E',
      include_src => false,
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
          location    => 'http://llvm.org/apt/precise/',
          release     => 'llvm-toolchain-precise-3.4',
          repos       => 'main',
          key_source  => 'http://llvm.org/apt/llvm-snapshot.gpg.key',
          include_src => false,
        } ->
        package {
          'clang-3.4':
            ensure  => latest,
        }
    }
  } elsif ($nodejs::version == '0.12') {
    file { "${::lsbdistcodename}-nodejs":
      ensure => 'absent',
      path   => "/etc/apt/sources.list.d/${name}.list",
      notify => Exec['apt_update'],
    }
    apt::source { "${::lsbdistcodename}-node0.12":
      location    => 'https://deb.nodesource.com/node_0.12/',
      release     => "${::lsbdistcodename}",
      repos       => 'main',
      key_source  => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
      include_src => false,
    }
  } elsif ($nodejs::version == '5') {
    file { "${::lsbdistcodename}-nodejs":
      ensure => 'absent',
      path   => "/etc/apt/sources.list.d/${name}.list",
      notify => Exec['apt_update'],
    }

    apt::source { 'nodesource':
      location          => "https://deb.nodesource.com/node_5.x/",
      release           => $::lsbdistcodename,
      repos             => 'main',
      key_source        => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
      include_src       => false,
      required_packages => 'apt-transport-https ca-certificates',
      key               => '68576280',
    }
  } else {
    file { "${::lsbdistcodename}-node4":
      ensure => 'absent',
      path   => "/etc/apt/sources.list.d/${name}.list",
      notify => Exec['apt_update'],
    }
    if ($nodejs::repo == 'test') {
      apt::source { 'precise-nodejs-test':
        location    => 'http://skypackages.s3-website-eu-west-1.amazonaws.com/ubuntu/',
        release     => 'precise-nodejs-test',
        repos       => 'main',
        key         => '1BC1B9EF',
        key_source  => 'http://skypackages.s3-website-eu-west-1.amazonaws.com/gpg.key',
        include_src => false,
      }
    } else {
      apt::source { 'precise-nodejs':
        location    => 'http://skypackages.s3-website-eu-west-1.amazonaws.com/ubuntu/',
        release     => 'precise-nodejs',
        repos       => 'main',
        key         => '1BC1B9EF',
        key_source  => 'http://skypackages.s3-website-eu-west-1.amazonaws.com/gpg.key',
        include_src => false,
      }
    }
  }
}
