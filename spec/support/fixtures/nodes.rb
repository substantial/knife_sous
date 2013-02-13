namespace :production do
  namespace :web do
    node :nodetastic do
      node_config "nodes/some_node.json"
      ssh_config "HostName: 12.34.56.789"
    end
  end
end

node :vagrant do
  node_config 'nodes/some_node.json'
  ssh_config 'vagrant config'
end

