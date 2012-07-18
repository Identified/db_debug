module DbDebug
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      env['db.count'] = 0
      env['db.time'] = 0.0
      resp = @app.call(env)
      color = determine_color env['db.count'], env['db.time']
      Logger.log color, "You hit the database #{env['db.count']} times and it took %5.3f ms" % env['db.time']
      resp
    end
    
    def determine_color count, time
      if count <= 10 || time < 50.0
        :green
      elsif count <= 20 || time < 100.0
        :yellow
      else
        :red
      end
    end
  end
end