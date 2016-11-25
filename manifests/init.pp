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

# == Class: nodejs
#
# This class is able to install nodejs
#
#
# === Parameters
#
#
# === Examples
#
# * Installation of nodejs
#     class {'nodejs':
#       repo    => 'test',
#}
#
class oldnodejs(
  $repo       = $oldnodejs::params::repo,
  $version    = $oldnodejs::params::version,
  $registry   = undef,
  $auth       = undef,
  $email      = undef,
  ) inherits oldnodejs::params {

    contain 'oldnodejs::repo'
    contain 'oldnodejs::install'
    contain 'oldnodejs::config'

    Class['oldnodejs::repo'] -> Class['oldnodejs::install'] -> Class['oldnodejs::config']
}
