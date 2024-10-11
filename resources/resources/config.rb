# Cookbook:: geoip
# Resource:: config

actions :add, :remove
default_action :add

attribute :user_id, kind_of: Integer, default: 712324
attribute :license_key, kind_of: String, default: node['redborder']['geoip_key']
