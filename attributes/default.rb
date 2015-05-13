
require 'securerandom'
password_secret = SecureRandom.hex(64)

default['onetimesecret']['secret'] = password_secret

default['onetimesecret']['redis_user'] = 'user'
default['onetimesecret']['redis_secret'] = 'not_secure_password'
default['onetimesecret']['redis_uri'] = "redis://#{default['onetimesecret']['redis_user']}:#{default['onetimesecret']['redis_secret']}@127.0.0.1:7179/0?timeout=10&thread_safe=false&logging=false"
