# Cookbook:: geoip
# Resource:: config

actions :add, :remove
default_action :add

attribute :user_id, kind_of: Integer, default: 712324

# TODO: Get rid of this hardcode license
attribute :license_key, kind_of: String, default: 'WCr9s2QoEPWz'
