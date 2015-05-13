

remote_file "/tmp/ruby-1.9.3-p362.tar.gz" do
  source "ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p362.tar.gz"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

bash "build ruby for you" do
  user "root"
  cwd "/tmp"
  creates "/usr/bin/gem"
  code <<-EOH
    STATUS=0
    tar xvzf ruby-1.9.3-p362.tar.gz || STATUS=1
    cd ruby-1.9.3-p362 || STATUS=1
     ./configure && make || STATUS=1
     make install || STATUS=1
    exit $STATUS
  EOH
end
