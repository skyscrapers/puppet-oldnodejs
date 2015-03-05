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

# == Class nodejs::config
#
# This class is called from nodejs
#
class nodejs::config {

  #if( $nodejs::registry != undef) {
    file {
      '/usr/etc':
        ensure  => directory,
        mode    => '0764',
        owner   => root,
        group   => root;

      '/usr/etc/npmrc':
        ensure  => file,
        content => template ('nodejs/usr/etc/npmrc.erb'),
        owner   => root,
        group   => root,
        mode    => '0640',
        require => File['/usr/etc'];
    #}
  }
}
