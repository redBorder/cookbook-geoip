# Cookbook:: geoip
# Provider:: config

action :add do
  user_id = new_resource.user_id
  license_key = new_resource.license_key

  begin
    dnf_package 'geoipupdate-cron' do
      action :remove
    end

    %w(GeoIP GeoIP-GeoLite-data GeoIP-GeoLite-data-extra geoipupdate).each do |pack|
      dnf_package pack do
        action :upgrade
      end
    end

    execute 'geoipupdate' do
      command 'geoipupdate'
      ignore_failure true
      action :nothing
      not_if { user_id.nil? || user_id.empty? || license_key.nil? || license_key.empty? }
    end

    template '/etc/GeoIP.conf' do
      source 'GeoIP.conf.erb'
      owner 'root'
      group 'root'
      mode '0644'
      cookbook 'geoip'
      variables(user_id: user_id, license_key: license_key)
      notifies :run, 'execute[geoipupdate]', :delayed
    end

    template '/etc/cron.weekly/geoipupdate' do
      source 'geoipupdate.cron.erb'
      owner 'root'
      group 'root'
      mode '0755'
      cookbook 'geoip'
      not_if { user_id.nil? || user_id.empty? || license_key.nil? || license_key.empty? }
    end

    Chef::Log.info('GeoIP cookbook has been processed')
  rescue => e
    Chef::Log.error(e.message)
  end
end

action :remove do
  begin
    Chef::Log.info('GeoIP cookbook has been processed')
  rescue => e
    Chef::Log.error(e.message)
  end
end
