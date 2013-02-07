# def default_node_config
#   node_config 'nodes/some_node.json'
#   ssh_config <<-TEXT
#   HostName: 12.34.56.789
#   TEXT
# end
# 
# namespace :production do
#   namespace :web do
#     node :nodetastic do
#       node_config 'nodes/some_node.json'
#       ssh_config <<-TEXT
#       HostName: 12.34.56.789
#       TEXT
#     end
# 
#   node :cool_world do
#     default_node_config
#   end
# end
# 
# namespace :vagrant do
#   node_config 'nodes/some_node.json'
#   ssh_config `vagrant ssh-config`
# end
# 
