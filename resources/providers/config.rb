
# Cookbook Name:: geoip
#
# Provider:: config
#

action :add do
  begin

    yum_package "GeoIP" do
      action :upgrade
      flush_cache [:before]
    end

    yum_package "GeoIP-update" do
      action :upgrade
      flush_cache [:before]
    end

    template "/etc/GeoIP.conf" do
      source "GeoIP.conf.erb"
      owner 'root'
      group 'root'
      mode 0644
      cookbook "geoip"
    end

    Chef::Log.info("GeoIP cookbook has been processed")
  rescue => e
    Chef::Log.error(e.message)
  end
end

action :remove do
  begin

    yum_package "GeoIP" do
      action :remove
    end

    yum_package "GeoIP-update" do
      action :remove
    end

    Chef::Log.info("GeoIP cookbook has been processed")
  rescue => e
    Chef::Log.error(e.message)
  end
end

