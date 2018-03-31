require 'json'

module AdventurerFactory
  class Api
    def call(env)
      @body = []
      @content_type = 'application/json'
      @status = 200
      @request = Rack::Request.new(env)

      case @request.path_info
      when /^\/dice\/(d\d+)$/
        type = $1
        dice = AdventurerFactory::Dice.send(type)
        @body << JSON.generate(dice.to_h)

      when /^\/dice\/(d\d+)\/advantage$/
        type = $1.to_sym
        dice = AdventurerFactory::Dice.advantage
        @body << JSON.generate(dice.to_h)

      when /^\/dice\/(d\d+)\/disadvantage$/
        type = $1.to_sym
        dice = AdventurerFactory::Dice.disadvantage
        @body << JSON.generate(dice.to_h)

      when /^\/dice\/(d\d+)\/(\d+)$/
        count = $2.to_i
        type = $1.to_sym
        dice = AdventurerFactory::Dice.bulk(count, type)
        @body << JSON.generate(dice.map(&:to_h))

      else
        [
          '<h1>Dice api: 404</h1><br>',
          '<br>Try rolling a <a href=/dice/d20>d20</a>',
          '<br>Or try rolling <a href=/dice/d20/advantage>with advantage</a>',
          '<br>Or try rolling <a href=/dice/d20/disadvantage>with disadvantage</a>',
          '<br>Or try rolling <a href=/dice/d8/5>5 d8\'s</a>',
        ].each {|text| @body << text}
        @status = 404
        @content_type = 'text/html'

      end
      # Return the array of status, headers, body
      [ @status, {"Content-Type" => @content_type}, @body ]
    end
  end
end

