

remote_file "/tmp/redis-2.6.17.tar.gz" do
  source "http://download.redis.io/releases/redis-2.6.17.tar.gz"
  owner "root"
  group "root"
  mode "0644"

  action :create
end

bash "build redis for you" do
  user "root"
  cwd "/tmp"
  creates "maybe"
  code <<-EOH
    STATUS=0
    tar xvzf redis-2.6.17.tar.gz || STATUS=1
    cd redis-2.6.17 || STATUS=1
    make || STATUS=1
    make install || STATUS=1
    exit $STATUS
  EOH
end
