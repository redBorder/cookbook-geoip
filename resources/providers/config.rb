
# Cookbook Name:: geoip
#
# Provider:: config
#

action :add do
  user_id = new_resource.user_id
  license_key = new_resource.license_key
  begin

    %w[ GeoIP GeoIP-GeoLite-data GeoIP-GeoLite-data-extra geoipupdate geoipupdate-cron ].each do |pack|
      yum_package pack do
        action :upgrade
        flush_cache [:before]
      end
    end

    execute "geoipupdate" do
      command 'geoipupdate'
      ignore_failure true
      action :nothing
    end

    template "/etc/GeoIP.conf" do
      source "GeoIP.conf.erb"
      owner 'root'
      group 'root'
      mode 0644
      cookbook "geoip"
      variables(:user_id => user_id, :license_key => license_key)
      notifies :run, 'execute[geoipupdate]', :delayed
    end

    Chef::Log.info("GeoIP cookbook has been processed")
  rescue => e
    Chef::Log.error(e.message)
  end
end

action :remove do
  begin
    Chef::Log.info("GeoIP cookbook has been processed")
  rescue => e
    Chef::Log.error(e.message)
  end
end
