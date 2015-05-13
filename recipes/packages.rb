


case node["platform_family"]
when "debian"

  include_recipe 'apt'

  %w{build-essential ntp libyaml-dev libevent-dev zlib1g zlib1g-dev openssl libssl-dev libxml2 libreadline5}.each do |pkg|
    package pkg do
      action [:install]
    end
  end

when "rhel"

  include_recipe 'yum'

    %w{gcc gcc-c++ make libtool git ntp openssl-devel readline-devel libevent-devel libyaml-devel zlib-devel}.each do |pkg|
    package pkg do
      action [:install]
    end
  end
end

include_recipe 'git'
