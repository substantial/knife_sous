require 'chef/knife'

class Chef
  class Knife
    class SousCook < Knife
      banner "stuff"

      def run
        puts "hello world"
      end
    end
  end
end

