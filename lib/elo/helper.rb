module Elo
  module Helper
    # Every object can be initialized with a hash,
    # almost, but not quite, entirely unlike ActiveRecord.
    def initialize(attributes = {})
      attributes.each do |key, value|
        public_send("#{key}=", value)
      end
    end
  end
end
