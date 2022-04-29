# Cookbook Name:: geoip
#
# Resource:: config
#

actions :add, :remove
default_action :add

attribute :user_id, :kind_of => Fixnum, :default => 712324
attribute :license_key, :kind_of => Array, :default => "WCr9s2QoEPWz"
