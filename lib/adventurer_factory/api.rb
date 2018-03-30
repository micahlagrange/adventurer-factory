require 'json'

module AdventurerFactory
  class Api
    def call(env)
      @body = []
      @content_type = 'application/json'
      @status = 200
      @request = Rack::Request.new(env)

      case @request.path_info
      when /^\/dice\/(d\d+)\/(\d+)/
        count = $2.to_i
        type = $1.to_sym
        dice = AdventurerFactory::Dice.bulk(count, type)
        @body << JSON.generate(dice.map(&:to_h))

      when /^\/dice\/(d\d+)/
        dice = AdventurerFactory::Dice.send($1)
        @body << JSON.generate(dice.to_h)

      else
        [
          '<h1>Page not found.</h1><br>',
          'Try going to <a href=/dice/d20>this page</a>'
        ].each {|text| @body << text}
        @status = 404
        @content_type = 'text/html'

      end
      # Return the array of status, headers, body
      [ @status, {"Content-Type" => @content_type}, @body ]
    end
  end
end

