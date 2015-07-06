module Minicron
  module Hub
    class AlertOptionsSubgroupSerializer
      def initialize(subgroups)
        @subgroups = subgroups
      end

      def serialize
        { alert_options_subgroups: @subgroups }
      end
    end
  end
end
