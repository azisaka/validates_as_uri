module ActiveRecord
  module Validations
    module ClassMethods
      def validates_as_uri(*attr_names)
        require 'curb'
        
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)

        validates_each attr_names do |record, attribute, value|
          record.errors.add attribute, "is invalid" if value[0] !~ /(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
          # record.errors.add attribute, "can't be found" if Curl::Easy.perform(value[0]).response_code != 200..300
        end
      end
    end
  end
end