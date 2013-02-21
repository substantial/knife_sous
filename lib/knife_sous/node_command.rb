require 'parallel'

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

    def run
      check_args
      search_result = search_for_target
      process_result(search_result)
    end

    def process_result(result)
      if result.is_a? KnifeSous::Namespace
        Parallel.map(result, in_threads: result.size) {|node| solo_command(node) }
      else
        solo_command(result)
      end
    end
  end
end

