require 'spec_helper'

describe 'onetimesecret::default' do

  describe file('/home/ots') do
    it { should be_directory }
  end

  describe file('/home/ots/onetimesecret') do
    it { should be_directory }
  end

  describe file('/home/ots/onetimesecret/.git/') do
    it { should be_directory }
  end

  describe file('/etc/onetime/') do
    it { should be_directory }
  end

  describe file('/etc/onetime/config') do
    it { should be_file }
  end

  describe file('/etc/onetime/redis.conf') do
    it { should be_file }
  end

  describe service('redis') do
    it { should be_running }
  end

  describe service('thin') do
    it { should be_running }
  end


end
