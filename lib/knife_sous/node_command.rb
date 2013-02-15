module KnifeSous
  module NodeCommand

    def search_for_target
      result = search(name_args)
      if result.nil?
        ui.error "Can't find node. Run `knife sous list` to see nodes"
        exit 1
      end
      result
    end

    def check_args
      unless name_args.size > 0
        ui.fatal "You need to specificy a node or namespace"
        show_usage
        exit 1
      end
    end
  end
end

