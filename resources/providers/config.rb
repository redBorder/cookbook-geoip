
# Cookbook Name:: geoip
#
# Provider:: config
#

action :add do
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
      notifies :run, 'execute[geoipupdate]', :delayed
    end

    Chef::Log.info("GeoIP cookbook has been processed")
  rescue => e
    Chef::Log.error(e.message)
  end
end

action :remove do
  begin

    %w[ geoipupdate-cron geoipupdate GeoIP-GeoLite-data ].each do |pack|
      # packs GeoIP and GeoIP-GeoLite-data-extra are removed by dependencies
      yum_package pack do
        action :remove
        ignore_failure true
      end
    end

    Chef::Log.info("GeoIP cookbook has been processed")
  rescue => e
    Chef::Log.error(e.message)
  end
end
