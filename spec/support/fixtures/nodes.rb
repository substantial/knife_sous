def default_options
  {
    node_config: "nodes/some_node.json",
    ssh_port: 22,
    identity_file: "path/to/identity/file"
  }
end

namespace :production do |prod|
  prod.node :node_awesome, default_options.merge!(hostname: '00.12.34.56')
  prod.namespace :web do |web|
    web.node :nodetastic,
      hostname: "12.34.56.789",
      ssh_port: 22,
      identity_file: "path/to/identity"
  end
end

node :vagrant, node_config: 'nodes/some_node.json', ssh_config: 'vagrant config'

