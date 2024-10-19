# Cookbook:: geoip
# Resource:: config

actions :add, :remove
default_action :add

attribute :user_id, kind_of: String
attribute :license_key, kind_of: String
