# def vagrant_ssh_config_file
#   @vagrant_ssh_config_file ||=begin
#     config_file = Tempfile.new('vagrant_ssh_config')
#     config_file.write(`vagrant ssh-config`)
#     config_file.close
#     at_exit { config_file.delete }
#     config_file
#   end
#   @vagrant_ssh_config_file.path
# end
# 
# def default_node_options
#   {
#     user: 'deploy',
#     node_config: 'nodes/server.json'
#   }
# end
# 
# node :vagrant, node_config: 'nodes/something.json',
#   hostname: 'default',
#   ssh_config: vagrant_ssh_config_file
# 
# namespace :production do |prod|
#   prod.node :node_awesome, default_options.merge!(hostname: '00.12.34.56')
#   prod.namespace :web do |web|
#     web.node :nodetastic,
#       hostname: "12.34.56.789",
#       ssh_port: 22,
#       identity_file: "path/to/identity"
#   end
# end
# 
