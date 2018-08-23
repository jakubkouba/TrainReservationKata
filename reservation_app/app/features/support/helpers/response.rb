module Helpers
  module Response

    def json_response
      JSON.parse(last_response.body).with_indifferent_access
    end

  end
end
