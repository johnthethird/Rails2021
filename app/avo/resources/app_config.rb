module Avo
  module Resources
    class AppConfig < Resource
      def initialize
        @title = :var
        @search = %i[var value]
        #@includes = []
      end

      fields do
        text :var, name: 'Setting', readonly: true, link_to_resource: true
        textarea :value, rows: 10
      end
    end
  end
end
