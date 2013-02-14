namespace :production do
  namespace :web do
    node :nodetastic do |n|
      n.hostname "12.34.56.789"
      default_options(n)
    end
  end
end

node :vagrant do |n|
  n.node_config 'nodes/some_node.json'
  n.ssh_config 'vagrant config'
end

def default_options(node)
  node.node_config "nodes/some_node.json"
  node.ssh_port 22
  node.identity_file "path/to/identity/file"
end

