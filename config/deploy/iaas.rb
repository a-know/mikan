default_env = { path: "/usr/pgsql-9.4/bin:$PATH" }
set :default_env, default_env

role :app, %w{a-know@mikanz-test.gce}
role :web, %w{a-know@mikanz-test.gce}
role :db , %w{a-know@mikanz-test.gce}
