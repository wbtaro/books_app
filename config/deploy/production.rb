server "booksapp.wbvh.tokyo", user: "ryotaro", roles: %w{app}
server "booksapp.wbvh.tokyo", user: "ryotaro", roles: %w{db}
server "booksapp.wbvh.tokyo", user: "ryotaro", roles: %w{web}

set :ssh_options, {
  keys: %w(~/.ssh/id_rsa_f9f9350c6edef6802316e20adc5166bd),
  port: 13245,
  forward_agent: true,
  auth_methods: %w(publickey)
}
